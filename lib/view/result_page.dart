import 'dart:async';
import 'package:bluetooth_connect/widgets/result_page_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class ResultPage extends StatefulWidget {
  final BluetoothDevice bluetoothDevice;
  const ResultPage({
    super.key,
    required this.bluetoothDevice,
  });

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  List<Map<String, dynamic>> data = [];
  BluetoothCharacteristic? uartCharacteristic;
  StreamSubscription<List<int>>? characteristicSubscription;
  String receivedData = '';

  @override
  void initState() {
    super.initState();
    discoverServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Data'),
      ),
      body: ResultPageBody(
        data: data,
        receivedData: receivedData,
      ),
    );
  }

  void discoverServices() async {
    List<BluetoothService> services =
        await widget.bluetoothDevice.discoverServices();
    for (BluetoothService service in services) {
      setState(() {
        data.add({
          "servicesUUID": service.uuid.toString(),
          "characteristicsUUID":
              service.characteristics.map((c) => c.uuid.toString()).toList(),
        });
      });
    }

    for (BluetoothService service in services) {
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        if (characteristic.uuid
                .toString()
                .compareTo('e9241982-4580-42c4-8831-95048216b256') ==
            0 /*'6e400001-b5a3-f393-e0a9-e50e24dcca9f'*/) {
          setState(() {
            uartCharacteristic = characteristic;
          });
          await startCharacteristicNotifications(characteristic);
          break;
        }
      }
    }
  }

  Future<void> startCharacteristicNotifications(
      BluetoothCharacteristic characteristic) async {
    await characteristic.setNotifyValue(true);
    characteristicSubscription = characteristic.lastValueStream.listen((value) {
      print('The Received Data is =============>  $value');
      setState(() {
        receivedData = String.fromCharCodes(value);
      });
    });
  }
}
