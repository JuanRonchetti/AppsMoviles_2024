import 'package:flutter/material.dart';
import 'package:navigation/core/entities/book.dart';
import 'package:navigation/data/book_repository.dart';

// Dialog para eliminacion de libro
Future<bool> deleteItemDialog(BuildContext context) async {
  bool result = false;
  await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content:
                const Text('You are about to delete this book from the list'),
            actions: [
              TextButton(
                  onPressed: () {
                    result = false;
                    Navigator.pop(context, result);
                  },
                  child: const Text('Cancel')),
              FilledButton(
                  onPressed: () {
                    result = true;
                    Navigator.pop(context, result);
                  },
                  child: const Text('Ok')),
            ],
          ));
  return result;
}

// Dialog para editar libro
Future<bool> editItemDialog(
    BuildContext context, Book myBook, BookRepository repository) async {
  TextEditingController titleController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  bool result = false;
  Book book = myBook;
  String coverImage;
  if (myBook.coverURL != null) {
    coverImage = myBook.coverURL!;
  } else {
    coverImage = '';
  }
  await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('Edit book'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                      //initialValue: myBook.name,
                      controller: titleController..text = myBook.name,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Title',
                        hintText: 'Title of the book',
                      )),
                  const SizedBox(height: 20),
                  TextFormField(
                      //initialValue: myBook.author,
                      controller: authorController..text = myBook.author,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Author',
                        hintText: 'Author of the book',
                      )),
                  const SizedBox(height: 20),
                  TextFormField(
                      //initialValue: myBook.year,
                      controller: yearController..text = myBook.year,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Year',
                        hintText: 'Year',
                      )),
                  const SizedBox(height: 20),
                  TextFormField(
                      //initialValue: myBook.description,
                      maxLines: 5,
                      controller: descriptionController
                        ..text = myBook.description,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Description',
                        hintText: 'Description of the book',
                      )),
                  const SizedBox(height: 20),
                  TextFormField(
                      //initialValue: myBook.coverURL,
                      controller: imageController..text = coverImage,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Cover',
                        hintText: 'Book cover image URL',
                      ))
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    result = false;
                    Navigator.pop(context, result);
                  },
                  child: const Text('Cancel')),
              FilledButton(
                  onPressed: () {
                    book.name = titleController.text;
                    book.author = authorController.text;
                    book.year = yearController.text;
                    book.description = descriptionController.text;
                    book.coverURL = imageController.text;

                    repository.updateBook(book);

                    result = true;
                    Navigator.pop(context, result);
                  },
                  child: const Text('Save')),
            ],
          ));
  return result;
}

// Dialog para agregar libro
Future<bool> addItemDialog(
    BuildContext context, BookRepository repository) async {
  TextEditingController titleController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  bool result = false;

  int asignedId = await repository.getNewId();
  Book book =
      Book(name: '', author: '', year: '', description: '', id: asignedId);

  await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('Add new book'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                      //initialValue: myBook.name,
                      controller: titleController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Title',
                        hintText: 'Title of the book',
                      )),
                  const SizedBox(height: 20),
                  TextFormField(
                      //initialValue: myBook.author,
                      controller: authorController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Author',
                        hintText: 'Author of the book',
                      )),
                  const SizedBox(height: 20),
                  TextFormField(
                      //initialValue: myBook.year,
                      controller: yearController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Year',
                        hintText: 'Year',
                      )),
                  const SizedBox(height: 20),
                  TextFormField(
                      //initialValue: myBook.description,
                      maxLines: 5,
                      controller: descriptionController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Description',
                        hintText: 'Description of the book',
                      )),
                  const SizedBox(height: 20),
                  TextFormField(
                      //initialValue: myBook.coverURL,
                      controller: imageController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Cover',
                        hintText: 'Book cover image URL',
                      ))
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    result = false;
                    Navigator.pop(context, result);
                  },
                  child: const Text('Cancel')),
              FilledButton(
                  onPressed: () {
                    book.name = titleController.text;
                    book.author = authorController.text;
                    book.year = yearController.text;
                    book.description = descriptionController.text;
                    book.coverURL = imageController.text;

                    repository.insertBook(book);

                    result = true;
                    Navigator.pop(context, result);
                  },
                  child: const Text('Add')),
            ],
          ));
  return result;
}
