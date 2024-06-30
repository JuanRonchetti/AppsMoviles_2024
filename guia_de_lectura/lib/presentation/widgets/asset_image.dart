import 'package:flutter/material.dart';

Widget getImageWithSizeFromAsset(
    String imagePath, double height, double width) {
  try {
    return Image.asset(
      imagePath,
      height: height,
      width: width,
      errorBuilder: (context, error, stackTrace) {
        return Icon(Icons.image_not_supported,
            size: (height < width) ? height : width);
      },
    );
  } catch (e) {
    return Icon(Icons.image_not_supported,
        size: (height < width) ? height : width);
  }
}
