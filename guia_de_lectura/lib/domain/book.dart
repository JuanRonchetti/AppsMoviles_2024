import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  int id;

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
}

// El user tiene una lista de UserSettings donde almacena el id de cada libro, si es favoritos y su estado
