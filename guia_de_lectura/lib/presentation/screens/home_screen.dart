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
import 'package:guia_de_lectura/presentation/widgets/asset_image.dart';
import 'package:guia_de_lectura/presentation/widgets/drawer_menu.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({required this.userId, super.key});

  static String name = "HomeScreen";

  final String userId;

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(bookProvider.notifier).getAllBooks();
  }

  @override
  Widget build(BuildContext context) {
    MyUser myUser = ref.watch(myUserNotifierProvider);
    List<Book> bookList = ref.watch(bookProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.scaffoldBackgroundColor,
        iconTheme: const IconThemeData(color: AppTheme.textColor),
      ),
      drawer: DrawerMenu(user: myUser),
      body: Scaffold(
        body: RefreshIndicator(
          color: AppTheme.textColor,
          backgroundColor: AppTheme.primaryColor,
          strokeWidth: 4.0,
          onRefresh: () async {
            return ref.read(bookProvider.notifier).getAllBooks();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 100),
                  FadeIn(
                    duration: const Duration(milliseconds: 800),
                    child: getImageWithSizeFromAsset(
                        'assets/images/LogoCircular.png', 250, 250),
                  ),
                  const SizedBox(height: 100),
                  FadeInUp(
                    child: Text(
                      '¡Bienvenido de vuelta, ${myUser.username}!',
                      style: const TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  FadeInUp(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all<Size>(
                            const Size(200, 50)),
                        foregroundColor: MaterialStateProperty.all<Color>(
                            AppTheme.textColor),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppTheme.primaryColor),
                      ),
                      onPressed: () {
                        context.go('/guide/${myUser.id}',
                            extra: BookRepository.fromList(bookList));
                      },
                      child: const Text(
                        'Guia Grafica',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  //
                  // Para futuras implementaciones
                  //
                  // ElevatedButton(
                  //   style: ButtonStyle(
                  //     minimumSize:
                  //         MaterialStateProperty.all<Size>(const Size(200, 50)),
                  //     foregroundColor:
                  //         MaterialStateProperty.all<Color>(AppTheme.textColor),
                  //     backgroundColor:
                  //         MaterialStateProperty.all<Color>(AppTheme.primaryColor),
                  //   ),
                  //   onPressed: () {},
                  //   child: const Text(
                  //     'Lista de Libros',
                  //     style: TextStyle(
                  //       fontSize: 20,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
