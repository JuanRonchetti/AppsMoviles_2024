import 'package:flutter/material.dart';

class BookCoordinates {
  Rect rect;
  String bookTitle;

  BookCoordinates({required this.bookTitle, required this.rect});
}

List<BookCoordinates> listOfBookCoordinates = [
  BookCoordinates(
      bookTitle: 'El Imperio Final',
      rect: Rect.fromPoints(const Offset(90, 209), const Offset(631, 448))),
  BookCoordinates(
      bookTitle: 'Aleacion de Ley',
      rect: Rect.fromPoints(const Offset(90, 612), const Offset(577, 851))),
  BookCoordinates(
      bookTitle: 'El Undecimo Metal',
      rect: Rect.fromPoints(const Offset(1170, 205), const Offset(1428, 405))),
  BookCoordinates(
      bookTitle: 'Alomante Jak y los Pozos de Eltania',
      rect: Rect.fromPoints(const Offset(1170, 480), const Offset(1430, 740))),
  BookCoordinates(
      bookTitle: 'Historia Secreta',
      rect: Rect.fromPoints(const Offset(1170, 750), const Offset(1430, 1010))),
  BookCoordinates(
      bookTitle: 'El Camino de los Reyes',
      rect: Rect.fromPoints(const Offset(2257, 209), const Offset(2407, 486))),
  BookCoordinates(
      bookTitle: 'Palabras Radiantes',
      rect: Rect.fromPoints(const Offset(2406, 209), const Offset(2556, 486))),
  BookCoordinates(
      bookTitle: 'Juramentada',
      rect: Rect.fromPoints(const Offset(2556, 209), const Offset(2706, 486))),
  BookCoordinates(
      bookTitle: 'El Ritmo de la Guerra',
      rect: Rect.fromPoints(const Offset(2706, 209), const Offset(2856, 486))),
  BookCoordinates(
      bookTitle: 'Danzante del Filo',
      rect: Rect.fromPoints(const Offset(2257, 657), const Offset(2508, 829))),
  BookCoordinates(
      bookTitle: 'Esquirla del Amanecer',
      rect: Rect.fromPoints(const Offset(2257, 834), const Offset(2508, 1006))),
  BookCoordinates(
      bookTitle: 'Elantris',
      rect: Rect.fromPoints(const Offset(3333, 210), const Offset(3720, 510))),
  BookCoordinates(
      bookTitle: 'La Esperanza de Elantris',
      rect: Rect.fromPoints(const Offset(3333, 522), const Offset(3583, 694))),
  BookCoordinates(
      bookTitle: 'El Alma del Emperador',
      rect: Rect.fromPoints(const Offset(3333, 700), const Offset(3720, 1000))),
  BookCoordinates(
      bookTitle: 'El Aliento de los Dioses',
      rect: Rect.fromPoints(const Offset(4413, 212), const Offset(4823, 600))),
  BookCoordinates(
      bookTitle: 'Arena Blanca',
      rect: Rect.fromPoints(const Offset(4413, 611), const Offset(4823, 1000))),
  BookCoordinates(
      bookTitle: 'Sombras por Silencio en los Bosques del Infierno',
      rect: Rect.fromPoints(const Offset(5492, 212), const Offset(5900, 600))),
  BookCoordinates(
      bookTitle: 'Sexto del Ocaso',
      rect: Rect.fromPoints(const Offset(5492, 611), const Offset(5900, 1000))),
  BookCoordinates(
      bookTitle: 'Trenza del Mar Esmeralda',
      rect: Rect.fromPoints(const Offset(6570, 206), const Offset(6825, 461))),
  BookCoordinates(
      bookTitle: 'Yumi y el Pintor de las Pesadillas',
      rect: Rect.fromPoints(const Offset(6570, 476), const Offset(6825, 731))),
  BookCoordinates(
      bookTitle: 'El Hombre Iluminado',
      rect: Rect.fromPoints(const Offset(6570, 746), const Offset(6825, 1000))),
];
