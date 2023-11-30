import 'package:bluetooth_connect/widgets/custom_list_view_uuid.dart';
import 'package:flutter/material.dart';

class ResultPageBody extends StatelessWidget {
  final List<Map<String, dynamic>> servicesData;
  final List<int> receivedData;

  const ResultPageBody({
    super.key,
    required this.servicesData,
    required this.receivedData,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomListViewUUID(data: servicesData),
            SizedBox(height: 30),
            Text(
              'THE RECEIVED DATA:',
              style: TextStyle(
                color: Colors.purple[500],
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '$receivedData',
              style: TextStyle(
                color: Colors.purple[500],
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
