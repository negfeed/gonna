const functions = require("firebase-functions");
const admin = require('firebase-admin');
const { v4: uuidv4 } = require('uuid');

admin.initializeApp();

// Create and Deploy Your First Cloud Functions
// https://firebase.google.com/docs/functions/write-firebase-functions

exports.helloWorld = functions.https.onRequest((request, response) => {
  functions.logger.info("Hello logs 2!", {structuredData: true});
  response.send("Hello from Firebase! 2.0");
});

exports.createDeviceAccount = functions.https.onRequest(async (request, response) => {
  functions.logger.info("createDeviceAccount called");

  // Process POST requests only.
  if (request.method != 'POST') {
    response.status(403).send('Unauthorized');
    return;
  }

  // Reject requests missing an Authorization header.
  if (!request.headers.authorization || !request.headers.authorization.startsWith('Bearer ')) {
    console.error('No Firebase ID token was passed as a Bearer token in the Authorization header.',
    'Make sure you authorize your request by providing the following HTTP header:',
    'Authorization: Bearer <Firebase ID Token>');
    response.status(403).send('Unauthorized');
    return;
  }

  // Decode the ID Token.
  let idToken = request.headers.authorization.split('Bearer ')[1];
  var decodedIdToken;
  try {
    decodedIdToken = await admin.auth().verifyIdToken(idToken);
    console.log('ID Token correctly decoded. Phone number: ', decodedIdToken.phone_number);
  } catch (error) {
    console.error('Error while verifying Firebase ID token:', error);
    response.status(403).send('Unauthorized');
    return;
  }

  // Only accept phone auth provider tokens.
  if (decodedIdToken.firebase.sign_in_provider != 'phone') {
    console.error('ID token sign in provider is not phone: ', decodedIdToken.firebase.sign_in_provider);
    response.status(403).send('Unauthorized');
    return;
  }

  // Create custom authorization token.
  const userId = uuidv4();
  const additionalClaims = {
    // Device gonna account type (gat).
    // This is an explicit market on the token to make it easier to distinguish it from phone accounts.
    gat: 'device',
    // The phone number that was used to mint this token.
    phoneNumber: decodedIdToken.phone_number,
    // The time this token was minted.
    creationTimestamp: Date.now(),
  };
  
  admin
    .auth()
    .createCustomToken(userId, additionalClaims)
    .then((customToken) => {
      response.status(200).send(customToken);
    })
    .catch((error) => {
      console.log('Error creating custom token:', error);
      response.status(403).send('Unauthorized');
    });
});