import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  final Function()? onTap;
  final Icon icon;
  final Color? iconColor;
  final Color? bgdColor;
  final double? buttonWidth;
  final double? iconSize;

  const MyIconButton({
    Key? key,
    this.onTap,
    this.buttonWidth,
    required this.icon,
    this.iconColor,
    this.bgdColor,
    this.iconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        color: Colors.transparent,
        child: Ink(
          decoration: ShapeDecoration(
            color: bgdColor ?? Colors.grey[900],
            shape: const CircleBorder(),
            shadows: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(0, 3),
                blurRadius: 6,
              ),
            ],
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(50.0),
            onTap: onTap,
            child: Container(
              width: buttonWidth,
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Icon(
                  icon.icon,
                  color: iconColor ?? Colors.white,
                  size: iconSize ?? 30,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
