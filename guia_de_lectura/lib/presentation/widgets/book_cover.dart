import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:guia_de_lectura/config/theme/app_theme.dart';

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
        borderRadius: BorderRadius.circular(15),
        child: CachedNetworkImage(
          imageUrl: coverURL,
          height: height,
          width: width,
          placeholder: (context, url) => const CircularProgressIndicator(
            color: AppTheme.detailColor,
          ),
          errorWidget: (context, url, error) =>
              Icon(Icons.menu_book, size: (height < width) ? height : width),
        ),
      );
    } catch (e) {
      return Icon(Icons.menu_book, size: (height < width) ? height : width);
    }
  } else {
    return Icon(Icons.menu_book, size: (height < width) ? height : width);
  }
}
