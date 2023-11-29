import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'bluetooth_state.dart';

class BluetoothCubit extends Cubit<BluetoothState> {
  BluetoothCubit() : super(BluetoothInitial());

  void checkBluetoothConnectivity() {
    FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) async {
      if (state == BluetoothAdapterState.off) {
        await FlutterBluePlus.turnOn().fbpEnsureAdapterIsOn('').catchError((_) {
          emit(BluetoothFailur(
            'Please Turn On Your Bluetooth',
            () {
              checkBluetoothConnectivity();
            },
          ));
        });
      }
      if (state == BluetoothAdapterState.on) {
        scanDevices();
      }
    });
  }

  void scanDevices() {
    FlutterBluePlus.scanResults.listen((results) {
      if (results.isNotEmpty) {
        emit(BluetoothScanDevice(results));
      } else {
        emit(BluetoothFailur(
          'There Is No Devices In This Location',
          () {
            scanDevices();
          },
        ));
      }
    });
  }

  void connectToDevice(BluetoothDevice device) {
    device.connect().then((_) {
      emit(BluetoothConnectedDevice(device));
    }).onError((_, __) {
      emit(BluetoothFailur(
        'Failed To Connect To Your Device',
        () {
          connectToDevice(device);
        },
      ));
    });
  }
}
