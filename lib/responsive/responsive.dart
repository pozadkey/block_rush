import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget child;
  final BoxConstraints? constraints;
  const Responsive({
    Key? key,
    required this.child, this.constraints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      // Constraint widgets to maximum width
      child: ConstrainedBox(
        constraints: constraints?? const BoxConstraints(
          maxWidth: 600,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: child,
        ),
      ),
    );
  }
}
