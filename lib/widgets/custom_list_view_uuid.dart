import 'package:flutter/material.dart';

class CustomListViewUUID extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  const CustomListViewUUID({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: data.length,
      physics: NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => SizedBox(height: 25),
      itemBuilder: (context, index) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'The SERVICE UUID:',
            style: TextStyle(
              color: Colors.purple[900],
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            data[index]['servicesUUID'],
            style: TextStyle(
              color: Colors.purple[600],
              fontSize: 15,
            ),
          ),
          Text(
            'The characteristic UUID:',
            style: TextStyle(
              color: Colors.purple[900],
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          for (var c in data[index]['characteristicsUUID'])
            Text('$c',
                style: TextStyle(color: Colors.purple[600], fontSize: 15)),
        ],
      ),
    );
  }
}
