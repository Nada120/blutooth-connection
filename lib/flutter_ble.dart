import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'custom_list_builder.dart';
import 'package:flutter/material.dart';

class BleFlutter extends StatefulWidget {
  const BleFlutter({super.key});

  @override
  State<BleFlutter> createState() => _BleFlutterState();
}

class _BleFlutterState extends State<BleFlutter> {
  List<ScanResult> devices = [];

  @override
  void initState() {
    super.initState();
    scanDevices();
  }

  void scanDevices() async {
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
    FlutterBluePlus.scanResults.listen((results) {
      setState(() {
        devices = results;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Devices'),
      ),
      body: devices.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : CustomListBuilder(
              devices: devices,
            ),
    );
  }
}
