import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'bluetooth_state.dart';

class BluetoothCubit extends Cubit<BluetoothState> {
  BluetoothCubit() : super(BluetoothInitial());

  void checkBluetoothConnectivity() {
    // It is check for bluetooth connection
    FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) async {
      // The bluetooth is turn off
      if (state == BluetoothAdapterState.off) {
        // It is required to turn on bluetooth
        await FlutterBluePlus.turnOn().fbpEnsureAdapterIsOn('').catchError((_) {
          // Here will show error when NOT turn on the bluetooth
          emit(BluetoothFailur(
            'Please Turn On Your Bluetooth', // Error text that will show to the user
            () {
              checkBluetoothConnectivity(); // This action will run the function again
            },
          ));
        });
      }
      // The bluetooth is turn on
      if (state == BluetoothAdapterState.on) {
        // Will start to scan for devices
        scanDevices();
      }
    });
  }

  void scanDevices() {
    // Start for scanning devices
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
    // Show the results of the scanning devices
    FlutterBluePlus.scanResults.listen((results) {
      // Devices was founded
      // active BluetoothScanDevice state
      emit(BluetoothScanDevice(results));
    },
    onError: (_) => // No devices was founded
      emit(BluetoothFailur(
        'There Is No Devices In This Location', // Error text that will show to the user
        () {
          scanDevices(); // This action will run the function again
        }),
      ),
    );
  }

  void connectToDevice(BluetoothDevice device) {
    // Start connect to the device
    device.connect().then((_) {
      // Active BluetoothConnectedDevice state
      emit(BluetoothConnectedDevice(device));
    }).onError((_, __) {
      // Will show error if can NOT connect to the device
      emit(BluetoothFailur(
        'Failed To Connect To Your Device', // Error text that will show to the user
        () {
          connectToDevice(device); // This action will run the function again
        },
      ));
    });
  }
}
