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
              color: data.isNotEmpty ? Colors.purple : Colors.grey,
            ),
          ),
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return StreamBuilder(
              stream: data[index],
              builder: (context, snapshot) => Text(
                'The Data of index ${index} is: ${snapshot.data}',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
