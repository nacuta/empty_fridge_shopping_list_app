import 'package:flutter/material.dart';

class ImageLogo extends StatelessWidget {
  const ImageLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 500,
      // height: 250,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      child: Image.asset(
        'assets/app_logo.png',
        fit: BoxFit.fill,
      ),
    );
  }
}
