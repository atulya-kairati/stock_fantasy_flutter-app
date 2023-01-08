import 'package:flutter/material.dart';

class CircularImageWithBorder extends StatelessWidget {
  const CircularImageWithBorder({
    Key? key, required this.imagePath, this.borderColor, required this.radius, required this.borderRadius,
  }) : super(key: key);

  final String imagePath;
  final Color? borderColor;
  final double radius, borderRadius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: borderColor,
      child: Padding(
        padding: EdgeInsets.all(borderRadius),
        child: ClipOval(
          child: Image.asset(
            imagePath,
            height: radius*2,
            width: radius*2,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
