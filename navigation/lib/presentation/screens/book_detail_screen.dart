import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation/core/app_router.dart';
import 'package:navigation/core/entities/book.dart';
import 'package:navigation/data/book_repository.dart';
import 'package:navigation/presentation/widgets/book_cover.dart';
import 'package:navigation/presentation/widgets/dialogs.dart';

class DetailScreen extends StatefulWidget {
  static const name = 'Detailscreen';
  final int bookId;
  const DetailScreen(
      {super.key, this.bookId = 0, required this.bookRepository});

  final BookRepository bookRepository;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<Book?> bookRequest;
  Book? myBook;
  bool bookExists = false;

  // Elimina el libro y retorna a la anterior pantalla si el resultado es true
  void deleteBookAndReturn(bool result) {
    if (result == true) {
      widget.bookRepository.deleteBook(myBook!);
      context.pop();
    }
  }

  @override
  void initState() {
    super.initState();
    bookRequest = widget.bookRepository.getBookById(widget.bookId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Book Detail'),
          actions: [
            // Editar
            IconButton(
                onPressed: () {
                  if (bookExists) {
                    editItemDialog(context, myBook!, bookRepository)
                        .then((result) => {setState(() {})});
                  }
                },
                icon: const Icon(Icons.edit)),

            // Eliminar
            IconButton(
                onPressed: () {
                  if (bookExists) {
                    deleteItemDialog(context)
                        .then((result) => deleteBookAndReturn(result));
                  }
                },
                icon: const Icon(Icons.delete))
          ],
        ),
        body: FutureBuilder(
            future: bookRequest,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                if (snapshot.data != null) {
                  bookExists = true;
                  myBook = snapshot.data;
                  return _DetailView(book: snapshot.data!);
                } else {
                  return const Text('No Book');
                }
              } else {
                return Text(snapshot.error.toString());
              }
            }));
  }
}

class _DetailView extends StatelessWidget {
  final Book book;
  const _DetailView({required this.book});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              getCoverWithSize(book.coverURL, 400, 300),
              const SizedBox(height: 10),
              Text(
                book.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              Text(
                'Author: ${book.author}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 10),
              Text(
                book.year,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 10),
              Text(book.description)
            ],
          ),
        ),
      ),
    );
  }
}
