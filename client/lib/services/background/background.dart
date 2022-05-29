import 'dart:isolate' as isolate;

import 'package:async/async.dart' as async;
import 'package:gonna_client/services/contact_sync/contact_sync.dart' as contact_sync;
import 'package:flutter_isolate/flutter_isolate.dart' as flutter_isolate;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:gonna_client/preference_util.dart' as preference_util;

class BackgroundService {
  static late BackgroundService _instance;

  static BackgroundService get instance {
    return _instance;
  }

  static Future<void> init() async {
    final isolate.ReceivePort receivePort = isolate.ReceivePort();
    await flutter_isolate.FlutterIsolate.spawn(
        _processBackgroundRequests, receivePort.sendPort);
    final backgroundEvents = async.StreamQueue<dynamic>(receivePort);
    final isolate.SendPort sendPort = await backgroundEvents.next;
    _instance = BackgroundService(backgroundEvents, sendPort);
  }

  final isolate.SendPort sendPort;
  final async.StreamQueue<dynamic> backgroundEvents;

  BackgroundService(async.StreamQueue<dynamic> this.backgroundEvents,
      isolate.SendPort this.sendPort) {}

  void syncAllContacts() {
    sendPort.send('syncAllContacts');
  }

  static Future<void> _processBackgroundRequests(isolate.SendPort p) async {
    await preference_util.PreferenceUtil.init();
    await firebase_core.Firebase.initializeApp();
    final commandPort = isolate.ReceivePort();
    p.send(commandPort.sendPort);

    await for (final command in commandPort) {
      switch (command) {
        case 'syncAllContacts':
          print('background: Syncing all contacts.');
          await contact_sync.ContactSyncService.instance.syncAllContacts();
          print('background: Finished syncing all contacts.');
          break;
        default:
          throw UnsupportedError('Unsupported command: $command');
      }
    }
  }
}
