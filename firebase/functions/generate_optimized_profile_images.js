const functions = require('firebase-functions');
const mkdirp = require('mkdirp');
const admin = require('firebase-admin');
const spawn = require('child-process-promise').spawn;
const path = require('path');
const os = require('os');
const fs = require('fs');

// Max height and width of the thumbnail in pixels.
const THUMB_MAX_HEIGHT = 128;
const THUMB_MAX_WIDTH = 128;

// Max height and width of the profile image in pixels.
const PROFILE_MAX_HEIGHT = 512;
const PROFILE_MAX_WIDTH = 512;

/**
 * When an image is uploaded in the Storage bucket We generate optimized versions automatically using
 * ImageMagick. These optimized versions are saved in the same bucket.
 */
exports.generateOptimizedProfileImages = functions.storage.object().onFinalize(async (object) => {

  const contentType = object.contentType;
  const filePath = object.name;

  // Verify that the file is an image.
  if (!contentType.startsWith('image/')) {
    console.log('This is not an image.');
    return null;
  }

  // Make sure this file is in the profile pictures path.
  if (!filePath.startsWith('profileImage/')) {
    console.log('This is not a profile picture. filePath: ' + filePath);
    return null;
  }

  // File and directory paths.
  const fileDir = path.dirname(filePath);
  const fileName = path.basename(filePath);
  const thumbFileDir = fileDir + '-thumbnails';
  const thumbFilePath = path.join(thumbFileDir, fileName);
  const profileFileDir = fileDir + '-profiles';
  const profileFilePath = path.join(profileFileDir, fileName);

  const tempLocalFile = path.join(os.tmpdir(), filePath);
  const tempLocalDir = path.dirname(tempLocalFile);
  const tempLocalThumbFile = path.join(tempLocalDir, thumbFilePath);
  const tempLocalProfileFile = path.join(tempLocalDir, profileFilePath);

  // Cloud Storage files.
  const bucket = admin.storage().bucket(object.bucket);
  const file = bucket.file(filePath);
  const thumbFile = bucket.file(thumbFilePath);
  const profileFile = bucket.file(profileFilePath);
  const metadata = {
    contentType: contentType,
    // To enable Client-side caching you can set the Cache-Control headers here. Uncomment below.
    'Cache-Control': 'public,max-age=3600', // 1 hour
  };

  // Create the temp directory where the storage file will be downloaded.
  await mkdirp(path.dirname(tempLocalFile));

  // Create the temp directory where the thumbnail will be generated.
  await mkdirp(path.dirname(tempLocalThumbFile));

  // Create the temp directory where the profile picture will be generated.
  await mkdirp(path.dirname(tempLocalProfileFile));

  // Download file from bucket.
  await file.download({ destination: tempLocalFile });
  functions.logger.log('The file has been downloaded to', tempLocalFile);

  // Generate a thumbnail using ImageMagick.
  await spawn('convert', [tempLocalFile, '-thumbnail', `${THUMB_MAX_WIDTH}x${THUMB_MAX_HEIGHT}>`, tempLocalThumbFile], { capture: ['stdout', 'stderr'] });
  functions.logger.log('Thumbnail created at', tempLocalThumbFile);

  // Generate a profile picture using ImageMagick.
  await spawn('convert', [tempLocalFile, '-thumbnail', `${PROFILE_MAX_WIDTH}x${PROFILE_MAX_HEIGHT}>`, tempLocalProfileFile], { capture: ['stdout', 'stderr'] });
  functions.logger.log('Profile picture created at', tempLocalProfileFile);

  // Uploading the Thumbnail.
  await bucket.upload(tempLocalThumbFile, { destination: thumbFilePath, metadata: metadata });
  functions.logger.log('Thumbnail uploaded to Storage at', thumbFilePath);

  // Uploading the Profile Picture.
  await bucket.upload(tempLocalProfileFile, { destination: profileFilePath, metadata: metadata });
  functions.logger.log('Profile picture uploaded to Storage at', profileFilePath);

  // Once the image has been uploaded delete the local files to free up disk space.
  fs.unlinkSync(tempLocalFile);
  fs.unlinkSync(tempLocalThumbFile);
  fs.unlinkSync(tempLocalProfileFile);
});
