# Gonna Modifications to the Flutter Platform Project Templates

When creating a new Flutter project, the Flutter command line tool creates a platform specific project directory based off some template.
Some development activity requires editing these project files directly.
For example, adding new service keys or configuration for various platform SDKs.

## What's the Problem?

This template could change from one Flutter release to another.
Sometimes we are going to be forced to adopt the new template in order to use a certain new feature that is
platform specific.
To generate project directories based of the new templates, we need to recreate the platform projects.

## How do we re-apply the changes we made? 

Manually!!

This document lists all changes that need to be applied to platform project directories! Please update it whenever you update any of the platform project directories.

## iOS Changes

### Firebase SDK 

1. Go to the project home page in firebase (e.g. Gonna Prod).
2. Go to the iOS apps settings.
3. Download the `GoogleService-Info.plist`.
4. Open the iOS project in Xcode.
5. Add the file above to the root of the iOS project.

### image_picker (dart package)

Roughly copied from the documentation [here][image_picker_ios_doc].

Add the following keys to your Info.plist file, located in &lt;project root&gt;/ios/Runner/Info.plist:

1. NSPhotoLibraryUsageDescription - describe why your app needs permission for the photo library. This is called Privacy - Photo Library Usage Description in the visual editor.
2. NSCameraUsageDescription - describe why your app needs access to the camera. This is called Privacy - Camera Usage Description in the visual editor.

[image_picker_ios_doc]: https://pub.dev/packages/image_picker#ios

