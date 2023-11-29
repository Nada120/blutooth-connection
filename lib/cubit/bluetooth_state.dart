part of 'bluetooth_cubit.dart';

@immutable
sealed class BluetoothState {}

final class BluetoothInitial extends BluetoothState {}

final class CkeckBluetoothConnection extends BluetoothInitial {}

final class BluetoothScanDevice extends BluetoothInitial {
  final List<ScanResult> devices;
  BluetoothScanDevice(this.devices);
}

final class ReadBluetoothData extends BluetoothInitial {}
