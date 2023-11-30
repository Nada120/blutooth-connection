import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class CustomListBuilder extends StatelessWidget {
  final List<ScanResult> devices;
  final void Function()? onPressed;

  const CustomListBuilder({
    super.key,
    required this.devices,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: devices.length,
      itemBuilder: (_, index) => ListTile(
        title: Text(
          'Device Name: ${devices[index].device.platformName}',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          'ID: ${devices[index].device.remoteId}',
          style: const TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
        trailing: ElevatedButton(
          onPressed: onPressed,
          child: const Text('connect'),
        ),
      ),
    );
  }
}
