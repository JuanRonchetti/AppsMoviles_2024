import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:guia_de_lectura/core/data/book_repository.dart';
import 'package:guia_de_lectura/domain/book.dart';
import 'package:guia_de_lectura/presentation/screens/detail_screen.dart';
import 'package:guia_de_lectura/presentation/screens/guide_screen.dart';
import 'package:guia_de_lectura/presentation/screens/home_screen.dart';
import 'package:guia_de_lectura/presentation/screens/login_screen.dart';
import 'package:guia_de_lectura/presentation/screens/password_screen.dart';
import 'package:guia_de_lectura/presentation/screens/signup_screen.dart';

final db = FirebaseFirestore.instance;

final appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    name: LoginScreen.name,
    path: '/',
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    name: SignUpScreen.name,
    path: '/signup',
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        transitionDuration: const Duration(milliseconds: 300),
        key: state.pageKey,
        child: const SignUpScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
              position: animation.drive(
                Tween<Offset>(
                  begin: const Offset(0.9, 0),
                  end: Offset.zero,
                ).chain(CurveTween(curve: Curves.easeIn)),
              ),
              child: child);
        },
      );
    },
  ),
  GoRoute(
    name: PasswordScreen.name,
    path: '/password',
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        transitionDuration: const Duration(milliseconds: 300),
        key: state.pageKey,
        child: const PasswordScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
              position: animation.drive(
                Tween<Offset>(
                  begin: const Offset(0.9, 0),
                  end: Offset.zero,
                ).chain(CurveTween(curve: Curves.easeIn)),
              ),
              child: child);
        },
      );
    },
  ),
  GoRoute(
    name: HomeScreen.name,
    path: '/home/:userId',
    builder: (context, state) =>
        HomeScreen(userId: state.pathParameters['userId']!),
  ),
  GoRoute(
    name: GuideScreen.name,
    path: '/guide/:userId',
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        transitionDuration: const Duration(milliseconds: 300),
        key: state.pageKey,
        child: GuideScreen(
            bookRepository: state.extra as BookRepository,
            userId: state.pathParameters['userId']!),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
              position: animation.drive(
                Tween<Offset>(
                  begin: const Offset(0.9, 0),
                  end: Offset.zero,
                ).chain(CurveTween(curve: Curves.easeIn)),
              ),
              child: child);
        },
      );
    },
  ),
  GoRoute(
    name: DetailScreen.name,
    path: '/detail/:userId',
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        transitionDuration: const Duration(milliseconds: 300),
        key: state.pageKey,
        child: DetailScreen(
            book: state.extra as Book, userId: state.pathParameters['userId']!),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
              position: animation.drive(
                Tween<Offset>(
                  begin: const Offset(0.9, 0),
                  end: Offset.zero,
                ).chain(CurveTween(curve: Curves.easeIn)),
              ),
              child: child);
        },
      );
    },
  ),
]);
