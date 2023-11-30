import '../widgets/result_page_body.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final List<Map<String, dynamic>> servicesData;
  final List<int> receivedData;
  
  const ResultPage({
    super.key,
    required this.receivedData,
    required this.servicesData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Data'),
      ),
      body: ResultPageBody(
        servicesData: servicesData,
        receivedData: receivedData,
      ),
    );
  }
}
