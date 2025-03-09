import 'package:flutter/material.dart';

void runRegularSnackBar(
    BuildContext context, IconData icon, Color color, String text) {
  var snackBar = SnackBar(
    content: Row(
      children: [
        Icon(
          icon,
          color: color,
        ),
        const SizedBox(
          width: 20,
        ),
        Text(text),
      ],
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
