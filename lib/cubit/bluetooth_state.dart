part of 'bluetooth_cubit.dart';

@immutable
sealed class BluetoothState {}

final class BluetoothInitial extends BluetoothState {}

final class BluetoothScanDevice extends BluetoothInitial {
  final List<ScanResult> devices;

  BluetoothScanDevice(this.devices);
}

final class BluetoothConnectedDevice extends BluetoothInitial {
  final BluetoothDevice connectDevice;

  BluetoothConnectedDevice(this.connectDevice);
}

final class BluetoothFailur extends BluetoothInitial {
  final String error;
  final void Function()? action;
  BluetoothFailur(this.error, this.action);
}
