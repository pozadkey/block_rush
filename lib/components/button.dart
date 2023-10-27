import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final double? buttonWidth;
  final Color? bgColor;
  final Color textColor;
  final double borderRadius;
  final double padding;

  const MyButton({
    Key? key,
    this.onTap,
    required this.text,
    this.buttonWidth,
    this.bgColor,
    this.textColor = Colors.white,
    this.borderRadius = 15.0,
    this.padding = 20.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: buttonWidth,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: bgColor ?? Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
