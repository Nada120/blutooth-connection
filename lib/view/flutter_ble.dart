import '../widgets/custom_dialog_error.dart';
import '../cubit/bluetooth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/custom_list_builder.dart';

class BleFlutter extends StatelessWidget {
  const BleFlutter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Devices'),
      ),
      body: BlocConsumer<BluetoothCubit, BluetoothState>(
        listener: (context, state) {
          if (state is BluetoothFailur) {
            showDialog(
              barrierDismissible: false,
              context: context, 
              builder: (_) => CustomDialogError(
                title: state.error, 
                onPressed: state.action,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is BluetoothScanDevice) {
            return CustomListBuilder(devices: state.devices);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
