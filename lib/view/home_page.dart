import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/bluetooth_cubit.dart';
import 'scan_devices_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var data = BlocProvider.of<BluetoothCubit>(context).recievedData;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<BluetoothCubit>(context)
                  .checkBluetoothConnectivity();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScanDevicesPage(),
                ),
              );
            },
            icon: Icon(
              Icons.watch_sharp,
              color: data != null ? Colors.purple : Colors.grey,
            ),
          ),
        ],
      ),
      body: Center(
        child: StreamBuilder(
          stream: data,
          builder: (context, snapshot) {
            var sn = snapshot.data;
            var hex = sn?.map((code) => code.toRadixString(16)).join('');
            debugPrint('The data in the hex is $hex');
            return Column(
              children: [
                Text(
                  'The Heart rate is: ${sn == null ? '0' : sn}',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'The Blood Oxygen is: ${sn == null ? '0' : sn}',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'The Calories is: ${sn == null ? '0' : sn}',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
