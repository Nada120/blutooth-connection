import 'package:bluetooth_connect/cubit/bluetooth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class CustomListBuilder extends StatelessWidget {
  final List<ScanResult> devices;

  const CustomListBuilder({
    super.key,
    required this.devices,
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
          onPressed: () {
            //TODO Here make connect to device and navigate to the result page
            context
                .read<BluetoothCubit>()
                .connectToDevice(devices[index].device);
          },
          child: const Text('connect'),
        ),
      ),
    );
  }
}
