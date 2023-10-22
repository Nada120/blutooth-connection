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

  @override
  void initState() {
    super.initState();
    discoverServices();
  }

  void discoverServices() async {
    List<BluetoothService> services =
        await widget.bluetoothDevice.discoverServices();
    for (BluetoothService service in services) {
      setState(() {
        servicesUUID.add(service.uuid.toString());
      });
      List<BluetoothCharacteristic> characteristics = service.characteristics;

      for (var c in characteristics) {
        setState(() {
          characteristicsUUID.add(c.uuid.toString());
        });
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
              const Text(
                'servicesUUID',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              buildList(servicesUUID),
              const SizedBox(height: 7),
              const Text(
                'characteristicsUUID',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              buildList(characteristicsUUID),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildList(List<String> data) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (context, index) => Text(
        data[index],
        style: TextStyle(
          color: Colors.purpleAccent[900],
          fontSize: 14,
        ),
      ),
    );
  }
}
