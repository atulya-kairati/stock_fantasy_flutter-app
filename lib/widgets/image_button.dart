import 'package:flutter/material.dart';
import 'package:image_card/image_card.dart';

class ImageButton extends StatelessWidget {
  const ImageButton({
    Key? key,
    this.title,
    this.description,
    this.footer,
    required this.imagePath,
    required this.onPressed,
  }) : super(key: key);

  final Widget? title;
  final Widget? description;
  final Widget? footer;
  final String imagePath;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: onPressed,
        child: TransparentImageCard(
          imageProvider: AssetImage(imagePath),
          width: double.infinity,
          title: title,
          description: description,
          footer: footer,
        ),
      ),
    );
  }
}
