const functions = require('firebase-functions');

exports.helloWorld = functions.https.onRequest((request, response) => {
  functions.logger.info("Hello logs 2!", {structuredData: true});
  response.send("Hello from Firebase! 2.0");
});
