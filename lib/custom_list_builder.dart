import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'result_page.dart';

class CustomListBuilder extends StatefulWidget {
  final List<ScanResult> devices;

  const CustomListBuilder({
    super.key,
    required this.devices,
  });

  @override
  State<CustomListBuilder> createState() => _CustomListBuilderState();
}

class _CustomListBuilderState extends State<CustomListBuilder> {
  Future<bool> connectToDevice(BluetoothDevice device) async {
    await device.connect();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.devices.length,
      itemBuilder: (_, index) => ListTile(
        title: Text(
          'Device Name: ${widget.devices[index].device.platformName}',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          'ID: ${widget.devices[index].device.remoteId}',
          style: const TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
        trailing: ElevatedButton(
          onPressed: () {
            connectToDevice(widget.devices[index].device).then(
              (value) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultPage(
                    bluetoothDevice: widget.devices[index].device,
                  ),
                ),
              ),
            );
          },
          child: const Text('connect'),
        ),
      ),
    );
  }
}
