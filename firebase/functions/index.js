const admin = require('firebase-admin');
const createDeviceAccount = require('./create_device_account');
const helloWorld = require('./hello_world');
const generateOptimizedProfileImages = require('./generate_optimized_profile_images');

admin.initializeApp();

exports.helloWorld = helloWorld.helloWorld;
exports.createDeviceAccount = createDeviceAccount.createDeviceAccount;
exports.generateOptimizedProfileImages = generateOptimizedProfileImages.generateOptimizedProfileImages;
