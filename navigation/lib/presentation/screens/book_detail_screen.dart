import 'package:flutter/material.dart';
import 'package:navigation/core/entities/book.dart';
import 'package:navigation/data/book_repository.dart';

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
            IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.delete))
          ],
        ),
        body: FutureBuilder(
            future: bookRequest,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                if (snapshot.data != null) {
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
  const _DetailView({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network(
              book.coverURL,
              width: 300,
              height: 400,
            ),
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
    );
  }
}
