import 'package:flutter/material.dart';
import 'package:navigation/core/entities/book.dart';

class DetailScreen extends StatelessWidget {
  static const name = 'Detailscreen';
  final int bookId;
  const DetailScreen({super.key, this.bookId = 0});

  @override
  Widget build(BuildContext context) {
    final myBook = listOfBooks.firstWhere((element) => element.id == bookId);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Detail'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.delete))
        ],
      ),
      body: DetailView(book: myBook),
    );
  }
}

class DetailView extends StatelessWidget {
  final Book book;
  const DetailView({super.key, required this.book});

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
