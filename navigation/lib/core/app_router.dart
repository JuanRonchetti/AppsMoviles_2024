import 'package:navigation/core/entities/user.dart';
import 'package:navigation/data/app_config_repository.dart';
import 'package:navigation/data/book_repository.dart';
import 'package:navigation/data/local_book_repository.dart';
import 'package:navigation/data/local_user_repository.dart';
import 'package:navigation/presentation/screens/book_detail_screen.dart';
import 'package:navigation/presentation/screens/home_screen.dart';
import 'package:navigation/presentation/screens/login_screen.dart';
import 'package:go_router/go_router.dart';

final BookRepository bookRepository = LocalBookRepository();
final LocalUserRepository userRepository = LocalUserRepository();
final AppConfigRepository appConfigRepository = AppConfigRepository();

final appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    name: LoginScreen.name,
    path: '/',
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    name: HomeScreen.name,
    path: '/home',
    builder: (context, state) => HomeScreen(
      user: state.extra as User,
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
