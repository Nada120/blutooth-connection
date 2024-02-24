part of 'bluetooth_cubit.dart';

@immutable
sealed class BluetoothState {}

final class BluetoothInitial extends BluetoothState {}

final class BluetoothScanDevice extends BluetoothInitial {
  final List<ScanResult> devices;
  BluetoothScanDevice(this.devices);
}

final class BluetoothDeviceService extends BluetoothInitial {
  final  List<Stream<List<int>>> receivedData;
  BluetoothDeviceService(this.receivedData);
}

final class BluetoothFailur extends BluetoothInitial {
  final String error;
  BluetoothFailur(this.error);
}
