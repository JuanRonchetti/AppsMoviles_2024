import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation/core/entities/book.dart';
import 'package:navigation/presentation/screens/book_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'Homescreen';
  final String userName;
  const HomeScreen({super.key, this.userName = ''});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Browse Books'),
        ),
        body: const _BooksView(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ));
  }
}

class _BooksView extends StatelessWidget {
  const _BooksView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listOfBooks.length,
        itemBuilder: (context, index) {
          final book = listOfBooks[index];
          return BookItem(book: book);
        });
  }
}

class BookItem extends StatelessWidget {
  final Book book;

  const BookItem({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(book.name),
        subtitle: Text(book.author),
        trailing: const Icon(Icons.arrow_forward),
        leading: Image.network(book.coverURL),
        onTap: () {
          context.pushNamed(DetailScreen.name, extra: book.id);
        },
      ),
    );
  }
}
