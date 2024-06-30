import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guia_de_lectura/domain/book.dart';

final bookProvider = StateNotifierProvider<BooksNotifier, List<Book>>(
  (ref) => BooksNotifier(FirebaseFirestore.instance),
);

class BooksNotifier extends StateNotifier<List<Book>> {
  final FirebaseFirestore db;

  BooksNotifier(this.db) : super([]);

  Future<void> getAllBooks() async {
    final docs = db.collection('books').withConverter(
        fromFirestore: Book.fromFirestore,
        toFirestore: (Book book, _) => book.toFirestore());
    final books = await docs.get();
    state = [...state, ...books.docs.map((d) => d.data())];
  }

  Future<Book?> getBookByTitle(String title) async {
    final querySnapshot = await db
        .collection('books')
        .where('title', isEqualTo: title)
        .withConverter(
          fromFirestore: Book.fromFirestore,
          toFirestore: (Book book, _) => book.toFirestore(),
        )
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.data();
    } else {
      return null;
    }
  }
}
