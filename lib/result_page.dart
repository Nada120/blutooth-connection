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
  List<String> servicesUUID = [];
  List<String> characteristicsUUID = [];
  late int batteryLevel;

  @override
  void initState() {
    super.initState();
    discoverServices();
  }

  void discoverServices() async {
    List<BluetoothService> services =
        await widget.bluetoothDevice.discoverServices();
    for (BluetoothService service in services) {
      if (service.uuid.toString() == '0000180f-0000-1000-8000-00805f9b34fb') {
        for (var c in service.characteristics) {
          if (c.uuid.toString() == "00002a19-0000-1000-8000-00805f9b34fb") {
            c.read().then((value) {
              int batteryLevel = value[0];
              print("Battery level is $batteryLevel %");
            });
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Data'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: height,
          color: Colors.purpleAccent.withOpacity(0.04),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: ListView(
            children: [
              Text(
                "Battery level is ${batteryLevel}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
