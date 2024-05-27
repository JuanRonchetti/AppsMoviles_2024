import 'package:floor/floor.dart';

@entity
class Book {
  @PrimaryKey(autoGenerate: true)
  int id;

  String name;
  String author;
  String year;
  String description;
  String? coverURL;

  Book(
      {required this.name,
      required this.author,
      required this.year,
      required this.description,
      this.coverURL,
      required this.id});
}
