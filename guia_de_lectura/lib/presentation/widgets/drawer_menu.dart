import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:guia_de_lectura/config/theme/app_theme.dart';
import 'package:guia_de_lectura/domain/user.dart';
import 'package:guia_de_lectura/presentation/screens/login_screen.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({super.key, required this.user});

  final MyUser user;

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    int index = 0;
    final String username = widget.user.username;
    return Stack(children: [
      NavigationDrawer(
        selectedIndex: index,
        backgroundColor: AppTheme.primaryColor,
        indicatorColor: AppTheme.scaffoldBackgroundColor,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Hola, $username',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.textColor,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const NavigationDrawerDestination(
            icon: Icon(
              Icons.logout,
              color: AppTheme.textColor,
            ),
            label: Text(
              "Log out",
              style: TextStyle(
                  color: AppTheme.textColor, fontWeight: FontWeight.bold),
            ),
          )
        ],
        onDestinationSelected: (value) async {
          index = value;
          setState(() {});
          // Si selecciono la opcion de log out (no hay otra pero es en caso de si la hubiera)
          if (value == 0) {
            setState(() {
              _isLoading = true;
            });
            // Aviso que se cerro la sesion y vuelvo a la pantalla login
            final firebaseAuth = FirebaseAuth.instance;
            await firebaseAuth.signOut();
            setState(() {
              _isLoading = false;
            });
            context.goNamed(LoginScreen.name);
          }
        },
      ),
      if (_isLoading)
        Container(
          color: AppTheme.detailColor.withOpacity(0.5),
          child: const Center(
            child: CircularProgressIndicator(
              color: AppTheme.scaffoldBackgroundColor,
            ),
          ),
        ),
    ]);
  }
}
