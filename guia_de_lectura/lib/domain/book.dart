import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  String id;

  String title;
  String year;
  String description;
  String? coverURL;
  String? saga;
  int order;

  Book({
    required this.id,
    required this.title,
    required this.year,
    required this.description,
    this.coverURL,
    this.saga,
    required this.order,
  });

  static Book fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return Book(
      id: data?['id'],
      title: data?['title'],
      year: data?['year'],
      description: data?['description'],
      coverURL: data?['coverURL'],
      saga: data?['saga'],
      order: data?['order'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'title': title,
      'year': year,
      'description': description,
      'coverURL': coverURL,
      'saga': saga,
      'order': order,
    };
  }

  Future<void> addToFirestore() async {
    try {
      // Obtener una referencia a la colección 'books'
      CollectionReference booksRef =
          FirebaseFirestore.instance.collection('books');

      // Convertir el objeto Book a un mapa
      Map<String, dynamic> bookData = toFirestore();

      // Agregar el libro a Firestore y obtener el DocumentReference
      DocumentReference docRef = await booksRef.add(bookData);

      // Actualizar el documento con el id asignado por Firestore
      await docRef.update({'id': docRef.id});
    } catch (e) {
      // ignore: avoid_print
      print('Error al subir el libro a Firestore: $e');
    }
  }
}
