import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation/core/entities/book.dart';
import 'package:navigation/data/book_repository.dart';
import 'package:navigation/presentation/screens/book_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  static const name = 'Homescreen';
  final String userName;
  const HomeScreen(
      {super.key, this.userName = '', required this.bookRepository});

  final BookRepository bookRepository;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Book>> bookRequest;

  @override
  void initState() {
    super.initState();
    bookRequest = widget.bookRepository.getBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Browse Books'),
        ),
        body: FutureBuilder(
            future: bookRequest,
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                return _BooksView(listOfBooks: snapshot.data!);
              } else {
                return Text(snapshot.error.toString());
              }
            })),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ));
  }
}

class _BooksView extends StatelessWidget {
  const _BooksView({
    super.key,
    required this.listOfBooks,
  });

  final List<Book> listOfBooks;

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
