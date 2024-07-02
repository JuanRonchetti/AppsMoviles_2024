import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:guia_de_lectura/config/theme/app_theme.dart';
import 'package:guia_de_lectura/core/data/book_repository.dart';
import 'package:guia_de_lectura/domain/book.dart';
import 'package:guia_de_lectura/domain/user.dart';
import 'package:guia_de_lectura/presentation/providers/book_provider.dart';
import 'package:guia_de_lectura/presentation/providers/user_provider.dart';
import 'package:guia_de_lectura/presentation/widgets/book_cover.dart';
import 'package:guia_de_lectura/presentation/widgets/snackbar.dart';

class DetailScreen extends ConsumerStatefulWidget {
  DetailScreen({super.key, required this.book, required this.userId});

  static String name = "DetailScreen";
  final Book book;

  final String userId;

  @override
  ConsumerState<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends ConsumerState<DetailScreen> {
  List<String> estados = ['Pendiente', 'Leyendo', 'Leido'];
  // String selectedItem = 'Pendiente';
  late MyUser myUser;
  BookRepository bookRepository = BookRepository.emptyRepository();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    bookRepository = BookRepository.fromList(ref.read(bookProvider));
  }

  @override
  Widget build(BuildContext context) {
    myUser = ref.watch(myUserNotifierProvider);
    MyUserBookStatus status = (myUser.hasBookStatusList)
        ? myUser.getUserBookStatus(widget.book)!
        : MyUserBookStatus();

    Book? previousBook = bookRepository.getPreviousBook(widget.book);
    Book? nextBook = bookRepository.getNextBook(widget.book);

    return Scaffold(
        // ----------------------------------
        // ----------- App Bar --------------
        // ----------------------------------
        appBar: AppBar(
            title: Text(widget.book.title),
            backgroundColor: AppTheme.primaryColor,
            foregroundColor: AppTheme.textColor,
            leading: IconButton(
              onPressed: () async {
                try {
                  setState(() {
                    _isLoading = true;
                  });
                  await MyUser.saveToFirestore(myUser);
                  setState(() {
                    _isLoading = false;
                  });

                  context.go('/guide/${myUser.id}', extra: bookRepository);
                } catch (e) {
                  showSnackBar(e.toString(), context);
                } finally {
                  setState(() {
                    _isLoading = false;
                  });
                }
              },
              icon: const Icon(Icons.arrow_back),
            )),
        // ----------------------------------
        // ----------- Bottom Bar -----------
        // ----------------------------------
        bottomNavigationBar: BottomAppBar(
          color: AppTheme.primaryColor,
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Estado: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              DropdownButton(
                  value: myUser.getStatusByBookTitle(widget.book.title),
                  dropdownColor: AppTheme.primaryColor,
                  iconEnabledColor: AppTheme.detailColor,
                  style: const TextStyle(
                    color: AppTheme.textColor,
                    decoration: TextDecoration.none,
                  ),
                  underline: Container(
                    height: 0,
                    color: Colors.transparent,
                  ),
                  items: estados.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    status.status = value!;
                    ref
                        .read(myUserNotifierProvider.notifier)
                        .updateUserBookStatus(status);
                  }),
              const SizedBox(width: 70),
              IconButton(
                icon: const Icon(Icons.star),
                onPressed: () {
                  status.isFavorite = !status.isFavorite;
                  ref
                      .read(myUserNotifierProvider.notifier)
                      .updateUserBookStatus(status);
                },
                color: myUser.getIsFavoriteByBookTitle(widget.book.title)!
                    ? Colors.yellow
                    : AppTheme.textColor,
              ),
            ],
          ),
        ),
        // ----------------------------------
        // ------------- Cuerpo -------------
        // ----------------------------------
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Stack(children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  getCoverWithSize(widget.book.coverURL, 250, 250),
                  const SizedBox(height: 20),
                  Text(
                    widget.book.title,
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 10),
                  Text(widget.book.year),
                  const SizedBox(height: 0),
                  Text(
                    widget.book.saga ?? 'Novela independiente',
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 130,
                        height: 150,
                        child: FadeInLeft(
                            child:
                                bookContainer(previousBook, 'Libro anterior:')),
                      ),
                      const SizedBox(width: 100),
                      SizedBox(
                          width: 130,
                          height: 150,
                          child: FadeInRight(
                              child:
                                  bookContainer(nextBook, 'Libro siguiente:'))),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(widget.book.description),
                ],
              ),
            ),
            if (_isLoading)
              Container(
                color: AppTheme.scaffoldBackgroundColor.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
          ]),
        ));
  }

  // ----------------------------------
  // ---------Container Libro ---------
  // ----------------------------------
  Widget bookContainer(Book? book, String text) {
    if (book != null) {
      return GestureDetector(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text),
              Text(
                book.title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.detailColor,
                    decoration: TextDecoration.underline,
                    decorationColor: AppTheme.detailColor),
              ),
              const SizedBox(height: 5),
              getCoverWithSize(book.coverURL, 70, 70)
            ],
          ),
        ),
        onTap: () {
          context.go('/detail/${widget.userId}', extra: book);
        },
      );
    } else {
      return const Text('');
    }
  }
}
