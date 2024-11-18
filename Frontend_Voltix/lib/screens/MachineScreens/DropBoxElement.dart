import 'package:flutter/material.dart';

class CustomDropdownItem extends StatelessWidget {
  final String text;
  final String imagePath;
  CustomDropdownItem({required this.text, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Row(
          children: [
            Text(text),
            SizedBox(width: 150),
          ],
        ),
        Image.asset(imagePath, width: 60, height: 20),
      ],
    );
  }
}
