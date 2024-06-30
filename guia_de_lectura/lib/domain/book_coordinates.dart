import 'package:flutter/material.dart';

class BookCoordinates {
  Rect rect;
  String bookTitle;

  BookCoordinates({required this.bookTitle, required this.rect});
}

List<BookCoordinates> listOfBookCoordinates = [
  BookCoordinates(
      bookTitle: 'Mistborn I: El Imperio Final',
      rect: Rect.fromPoints(const Offset(90, 209), const Offset(631, 448))),
  BookCoordinates(
      bookTitle: 'Mistborn IV: Aleacion de Ley',
      rect: Rect.fromPoints(const Offset(90, 612), const Offset(577, 851))),
  BookCoordinates(
      bookTitle: 'El Undecimo Metal',
      rect: Rect.fromPoints(const Offset(1168, 205), const Offset(1428, 405))),
  // BookCoordinates(
  //     bookTitle: 'Alomante Jak y los Pozos de Eltania',
  //     rect: Rect.fromPoints(const Offset(100, 100), const Offset(200, 200))),
  // BookCoordinates(
  //     bookTitle: 'Mistborn: Historia Secreta',
  //     rect: Rect.fromPoints(const Offset(100, 100), const Offset(200, 200))),
  // BookCoordinates(
  //     bookTitle: 'El Camino de los Reyes',
  //     rect: Rect.fromPoints(const Offset(100, 100), const Offset(200, 200))),
  // BookCoordinates(
  //     bookTitle: 'Palabras Radiantes',
  //     rect: Rect.fromPoints(const Offset(100, 100), const Offset(200, 200))),
  // BookCoordinates(
  //     bookTitle: 'Juramentada',
  //     rect: Rect.fromPoints(const Offset(100, 100), const Offset(200, 200))),
  // BookCoordinates(
  //     bookTitle: 'El Ritmo de la Guerra',
  //     rect: Rect.fromPoints(const Offset(100, 100), const Offset(200, 200))),
  // BookCoordinates(
  //     bookTitle: 'Danzante del Filo',
  //     rect: Rect.fromPoints(const Offset(100, 100), const Offset(200, 200))),
  // BookCoordinates(
  //     bookTitle: 'Esquirla del Amanecer',
  //     rect: Rect.fromPoints(const Offset(100, 100), const Offset(200, 200))),
  // BookCoordinates(
  //     bookTitle: 'Elantris',
  //     rect: Rect.fromPoints(const Offset(100, 100), const Offset(200, 200))),
  // BookCoordinates(
  //     bookTitle: 'La Esperanza de Elantris',
  //     rect: Rect.fromPoints(const Offset(100, 100), const Offset(200, 200))),
  // BookCoordinates(
  //     bookTitle: 'El Alma del Emperador',
  //     rect: Rect.fromPoints(const Offset(100, 100), const Offset(200, 200))),
  // BookCoordinates(
  //     bookTitle: 'El Aliento de los Dioses',
  //     rect: Rect.fromPoints(const Offset(100, 100), const Offset(200, 200))),
  // BookCoordinates(
  //     bookTitle: 'Arena Blanca',
  //     rect: Rect.fromPoints(const Offset(100, 100), const Offset(200, 200))),
  // BookCoordinates(
  //     bookTitle: 'Sombras por Silencio en los Bosques del Infierno',
  //     rect: Rect.fromPoints(const Offset(100, 100), const Offset(200, 200))),
  // BookCoordinates(
  //     bookTitle: 'Sexto del Ocaso',
  //     rect: Rect.fromPoints(const Offset(100, 100), const Offset(200, 200))),
  // BookCoordinates(
  //     bookTitle: 'Trenza del Mar Esmeralda',
  //     rect: Rect.fromPoints(const Offset(100, 100), const Offset(200, 200))),
  // BookCoordinates(
  //     bookTitle: 'Yumi y el Pintor de las Pesadillas',
  //     rect: Rect.fromPoints(const Offset(100, 100), const Offset(200, 200))),
  // BookCoordinates(
  //     bookTitle: 'El Hombre Iluminado',
  //     rect: Rect.fromPoints(const Offset(100, 100), const Offset(200, 200))),
];
