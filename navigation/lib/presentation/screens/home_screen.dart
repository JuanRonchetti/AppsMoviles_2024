import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation/core/entities/book.dart';
import 'package:navigation/core/entities/user.dart';
import 'package:navigation/data/book_repository.dart';
import 'package:navigation/presentation/screens/book_detail_screen.dart';
import 'package:navigation/presentation/widgets/book_cover.dart';
import 'package:navigation/presentation/widgets/dialogs.dart';
import 'package:navigation/presentation/widgets/drawer_menu.dart';

class HomeScreen extends StatefulWidget {
  static const name = 'Homescreen';

  const HomeScreen(
      {super.key, required this.user, required this.bookRepository});

  final User user;
  final BookRepository bookRepository;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Book>> bookRequest;

  bool requestSuccesful = false;

  @override
  void initState() {
    super.initState();
    bookRequest = widget.bookRepository.getBooks();
  }

  void _updateList() {
    setState(() {
      bookRequest = widget.bookRepository.getBooks();
    });
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
              requestSuccesful = true;
              return _BooksView(
                  listOfBooks: snapshot.data!, refreshList: _updateList);
            } else {
              return Text(snapshot.error.toString());
            }
          })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (requestSuccesful) {
            addItemDialog(context, widget.bookRepository).then((result) {
              _updateList();
            });
          }
        },
        child: const Icon(Icons.add),
      ),
      drawer: DrawerMenu(user: widget.user),
    );
  }
}

class _BooksView extends StatelessWidget {
  const _BooksView({
    required this.listOfBooks,
    required this.refreshList,
  });

  final List<Book> listOfBooks;

  final VoidCallback refreshList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listOfBooks.length,
        itemBuilder: (context, index) {
          final book = listOfBooks[index];
          return BookItem(book: book, refreshList: refreshList);
        });
  }
}

class BookItem extends StatelessWidget {
  final Book book;
  const BookItem({super.key, required this.book, required this.refreshList});

  final VoidCallback refreshList;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(book.name),
        subtitle: Text(book.author),
        trailing: const Icon(Icons.arrow_forward),
        leading: getCover(book.coverURL),
        onTap: () {
          context.pushNamed(DetailScreen.name, extra: book.id).then((value) {
            refreshList();
          });
        },
      ),
    );
  }
}
