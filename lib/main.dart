import 'package:bluetooth_connect/cubit/bluetooth_cubit.dart';
import 'package:bluetooth_connect/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]).then((value) => runApp(const MyApp()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BluetoothCubit(),
      child: MaterialApp(
        title: 'Bluetooth Connection',
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
