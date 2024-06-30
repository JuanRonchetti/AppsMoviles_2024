import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:guia_de_lectura/config/theme/app_theme.dart';
import 'package:guia_de_lectura/core/data/book_repository.dart';
import 'package:guia_de_lectura/domain/book.dart';
import 'package:guia_de_lectura/domain/book_coordinates.dart';
import 'package:photo_view/photo_view.dart';

class GuideScreen extends ConsumerWidget {
  GuideScreen({super.key, required this.bookRepository, required this.userId});

  static String name = "GuideScreen";

  final String userId;

  final PhotoViewControllerBase photoController = PhotoViewController();

  final BookRepository bookRepository;

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Guia de Lectura'),
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: AppTheme.textColor,
          leading: IconButton(
            onPressed: () async {
              context.go('/home/$userId');
            },
            icon: const Icon(Icons.home),
          ),
        ),
        body: PhotoView(
          controller: photoController,
          imageProvider: const AssetImage('assets/images/GuiaImagen.jpg'),
          minScale: PhotoViewComputedScale.covered,
          maxScale: PhotoViewComputedScale.covered,
          initialScale: PhotoViewComputedScale.covered,
          basePosition: Alignment.centerLeft,
          onTapUp: onTapUp,
        ));
  }

  void onTapUp(BuildContext context, TapUpDetails details,
      PhotoViewControllerValue controller) {
    double xOffset = controller.position.dx;
    double yOffset = controller.position.dy;

    // Obtengo coordenadas de la posicion
    Offset tapPosition = Offset(
        (details.localPosition.dx - xOffset) / controller.scale!,
        (details.localPosition.dy - yOffset) / controller.scale!);

    // print("X:${(details.localPosition.dx - xOffset) / controller.scale!}");
    // print("Y:${(details.localPosition.dy - yOffset) / controller.scale!}");

    for (int i = 0; i < listOfBookCoordinates.length; i++) {
      // Si las coordenadas son de un libro
      if (listOfBookCoordinates[i].rect.contains(tapPosition)) {
        // Pido el libro al repositorio y paso a la detailscreen mandandole ese libro
        final Book? book =
            bookRepository.getBookByTitle(listOfBookCoordinates[i].bookTitle);
        if (book != null) {
          context.go('/detail/$userId', extra: book);
        }
      }
    }
  }
}
