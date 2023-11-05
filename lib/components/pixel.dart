import 'package:flutter/material.dart';

class Pixel extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables

  final Color? color;
  const Pixel({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
      margin: const EdgeInsets.all(1.0),
    );
  }
}
