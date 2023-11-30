// has import flutter_blue_plus package so we use 'as cubit' to avoid conflict
import 'package:bluetooth_connect/view/result_page.dart';

import '../cubit/bluetooth_cubit.dart' as cubit;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Can NOT delete this Becuase devices varaible which it's data type is ScanResult
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
        trailing: BlocListener<cubit.BluetoothCubit, cubit.BluetoothState>(
          listener: (context, state) {
            if (state is cubit.BluetoothConnectedDevice) {
              // Navigate to the result page with the connected device
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ResultPage(
                    bluetoothDevice: state.connectDevice,
                  ),
                ), 
              );
            }
          },
          child: ElevatedButton(
            onPressed: () {
              // call the method of connecting the device 
              context.read<cubit.BluetoothCubit>().connectToDevice(
                devices[index].device,
              );
            },
            child: const Text('connect'),
          ),
        ),
      ),
    );
  }
}
