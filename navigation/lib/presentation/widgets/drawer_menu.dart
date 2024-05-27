import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation/core/app_router.dart';
import 'package:navigation/core/entities/app_config.dart';
import 'package:navigation/core/entities/user.dart';
import 'package:navigation/presentation/screens/login_screen.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({super.key, required this.user});

  final User user;

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    int index = 0;
    final String username = widget.user.name;
    return NavigationDrawer(
      selectedIndex: index,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Hello, $username',
            style: const TextStyle(fontSize: 20),
          ),
        ),
        const NavigationDrawerDestination(
            icon: Icon(Icons.logout), label: Text("Log out"))
      ],
      onDestinationSelected: (value) {
        index = value;
        setState(() {});
        // Si selecciono la opcion de log out (no hay otra pero es en caso de si la hubiera)
        if (value == 0) {
          // Aviso que se cerro la sesion y vuelvo a la pantalla login
          appConfigRepository
              .updateAppConfig(AppConfig(activeSesion: false, id: 1));
          context.goNamed(LoginScreen.name);
        }
      },
    );
  }
}
