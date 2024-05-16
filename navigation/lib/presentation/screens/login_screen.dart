import 'package:flutter/widgets.dart';
import 'package:navigation/presentation/screens/home_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:navigation/core/entities/usuario.dart';

class LoginScreen extends StatefulWidget {
// *********************************************************************************
// ******************       ATRIBUTOS     ******************************************
// *********************************************************************************
  static const String name = 'Loginscreen';

  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool _passwordVisible = false;

// *********************************************************************************
  void showSnackBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    SnackBar snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/welcome.png',
              height: 200,
              //width: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: userController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: 'Username',
                  hintText: 'Enter your username',
                  prefixIcon: const Icon(Icons.person_2_outlined)),
            ),
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: passwordController,
              obscureText: !_passwordVisible,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: 'Password',
                hintText: 'Enter your password',
                prefixIcon: const Icon(Icons.password),
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  if (userController.text.isEmpty) {
                    showSnackBar('Enter your username', context);
                  } else if (passwordController.text.isEmpty) {
                    showSnackBar('Enter your password', context);
                  } else {
                    if (listaDeUsuarios.any(
                            (myUser) => myUser.name == userController.text) ==
                        true) {
                      final Usuario user = listaDeUsuarios.firstWhere(
                          (myUser) => myUser.name == userController.text);
                      if (user.verifyPassword(passwordController.text)) {
                        // Navegar a la otra pantalla pasando como parametro el texto ingresado.
                        context.pushNamed(HomeScreen.name, extra: user.name);
                      } else {
                        showSnackBar('The password is incorrect', context);
                      }
                    } else {
                      showSnackBar('The username is incorrect', context);
                    }
                  }
                },
                child: const Text('Login'))
          ],
        ),
      ),
    );
  }
}
