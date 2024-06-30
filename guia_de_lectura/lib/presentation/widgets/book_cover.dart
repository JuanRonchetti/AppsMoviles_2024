import 'package:flutter/material.dart';

Widget getCover(String? coverURL) {
  if (coverURL != null) {
    try {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          coverURL,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.menu_book);
          },
        ),
      );
    } catch (e) {
      return const Icon(Icons.menu_book);
    }
  } else {
    return const Icon(Icons.menu_book);
  }
}

Widget getCoverWithSize(String? coverURL, double height, double width) {
  if (coverURL != null) {
    try {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          coverURL,
          height: height,
          width: width,
          errorBuilder: (context, error, stackTrace) {
            return Icon(Icons.menu_book,
                size: (height < width) ? height : width);
          },
        ),
      );
    } catch (e) {
      return Icon(Icons.menu_book, size: (height < width) ? height : width);
    }
  } else {
    return Icon(Icons.menu_book, size: (height < width) ? height : width);
  }
}
