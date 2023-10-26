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
        data.add({
          "servicesUUID": service.serviceUuid.toString(),
          "characteristicsUUID": service.characteristics
              .map((c) => c.characteristicUuid.toString())
              .toList(),
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Data'),
      ),
      body: Container(
        height: height,
        color: Colors.purpleAccent.withOpacity(0.04),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: buildList(data),
      ),
    );
  }

  Widget buildList(List<Map<String, dynamic>> data) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: data.length,
      separatorBuilder: (context, index) => SizedBox(height: 25),
      itemBuilder: (context, index) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'The SERVICE UUID:',
            style: TextStyle(
              color: Colors.purple[900],
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            data[index]['servicesUUID'],
            style: TextStyle(
              color: Colors.purple[600],
              fontSize: 15,
            ),
          ),
          Text(
            'The characteristic UUID:',
            style: TextStyle(
              color: Colors.purple[900],
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          for (var c in data[index]['characteristicsUUID']) Text('$c', style: TextStyle(color: Colors.purple[600], fontSize: 15)),
        ],
      ),
    );
  }
}
