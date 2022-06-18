const admin = require('firebase-admin');
const createDeviceAccount = require('./create_device_account');
const helloWorld = require('./hello_world');

admin.initializeApp();

exports.helloWorld = helloWorld.helloWorld;
exports.createDeviceAccount = createDeviceAccount.createDeviceAccount;
