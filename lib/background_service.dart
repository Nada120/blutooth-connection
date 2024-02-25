import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';

DateTime now = DateTime.now();
String hour = now.hour.toString();
String min = now.minute.toString();
String timeNow = '$hour:$min';

Future<void> intializeService() async {
  await FlutterBackgroundService().configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: true,
      isForegroundMode: false,
    ),
    iosConfiguration: IosConfiguration(),
  );
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  Timer.periodic(
    const Duration(seconds: 3),
    (timer) async {
      if (service is AndroidServiceInstance) {
        // if the clock is 12 pm then themn send this data to the api
        if (await service.isForegroundService()) {
          service.setForegroundNotificationInfo(
            title: "My App Service",
            content: "Updated at ${DateTime.now()}",
          );
        }
        if (timeNow == '23:16') {
          FlutterBackgroundService().invoke('setAsForeground');
        }

        // This service will run even if the app closed 'Background Service'
        debugPrint('The Data in the background ${DateTime.now()}');
      }
    },
  );
}
