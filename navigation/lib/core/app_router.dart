import 'package:navigation/data/book_repository.dart';
import 'package:navigation/data/fake_book_repository.dart';
import 'package:navigation/presentation/screens/book_detail_screen.dart';
import 'package:navigation/presentation/screens/home_screen.dart';
import 'package:navigation/presentation/screens/login_screen.dart';
import 'package:go_router/go_router.dart';

//final BookRepository bookRepository = LocalBookRepository();
final BookRepository bookRepository = FakeBookRepository();

final appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    name: LoginScreen.name,
    path: '/',
    builder: (context, state) => LoginScreen(),
  ),
  GoRoute(
    name: HomeScreen.name,
    path: '/home',
    builder: (context, state) => HomeScreen(
      userName: state.extra as String,
      bookRepository: bookRepository,
    ),
  ),
  GoRoute(
    name: DetailScreen.name,
    path: '/detail',
    builder: (context, state) => DetailScreen(
      bookId: state.extra as int,
      bookRepository: bookRepository,
    ),
  )
]);
