import 'package:flutter/material.dart';

class CustomDialogError extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  const CustomDialogError({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
      ),
      actions: [
        TextButton(
          onPressed: onPressed,
          child: Text('OK'),
        ),
      ],
    );
  }
}
