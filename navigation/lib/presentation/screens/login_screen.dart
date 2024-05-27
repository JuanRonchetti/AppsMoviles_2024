import 'package:navigation/core/app_router.dart';
import 'package:navigation/core/entities/app_config.dart';
import 'package:navigation/presentation/screens/home_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:navigation/core/entities/user.dart';
import 'package:navigation/presentation/widgets/snackbar.dart';

class LoginScreen extends StatefulWidget {
  static const String name = 'Loginscreen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late Future<List<User>> usersRequest;
  late Future<AppConfig?> appConfigRequest;

  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool passwordVisible = false;
  bool stayLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkActiveSesion();
    usersRequest = userRepository.getUsers();
  }

  Future<void> checkActiveSesion() async {
    AppConfig? appConfig = await appConfigRepository.getAppConfig();
    if (appConfig != null && appConfig.activeSesion == true) {
      // Si hay sesion abierta
      int userId = appConfig.userId!;
      User? user = await userRepository.getUserById(userId);
      context.goNamed(HomeScreen.name, extra: user!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: usersRequest,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Espero al future
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.data != null) {
            // Hay datos, entonces armo la pantalla
            List<User> listOfUsers = snapshot.data!;

            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 100),
                      Image.asset(
                        'assets/images/WelcomeScreen.png',
                        height: 300,
                        //width: 200,
                        //fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 60),
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
                        obscureText: !passwordVisible,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          prefixIcon: const Icon(Icons.password),
                          suffixIcon: IconButton(
                            icon: Icon(
                              passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: stayLoggedIn,
                              onChanged: (value) {
                                setState(() {
                                  stayLoggedIn = !stayLoggedIn;
                                });
                              }),
                          const Text("Stay logged in")
                        ],
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                          onPressed: () {
                            if (userController.text.isEmpty) {
                              showSnackBar('Enter your username', context);
                            } else if (passwordController.text.isEmpty) {
                              showSnackBar('Enter your password', context);
                            } else {
                              if (listOfUsers.any((myUser) =>
                                      myUser.name == userController.text) ==
                                  true) {
                                // Esta parte se podria mejorar usando la furncion validateUser(), pero no se llego a implementar
                                final User user = listOfUsers.firstWhere(
                                    (myUser) =>
                                        myUser.name == userController.text);
                                if (user.verifyPassword(
                                        passwordController.text) ==
                                    true) {
                                  // Guardar el estado de la sesion
                                  if (stayLoggedIn == true) {
                                    appConfigRepository.updateAppConfig(
                                        AppConfig(
                                            activeSesion: true,
                                            id: 1,
                                            userId: user.id));
                                  } else if (stayLoggedIn == false) {
                                    appConfigRepository.updateAppConfig(
                                        AppConfig(
                                            activeSesion: false,
                                            id: 1,
                                            userId: null));
                                  }
                                  // Navegar a la otra pantalla
                                  context.goNamed(HomeScreen.name, extra: user);
                                } else {
                                  showSnackBar(
                                      'The password is incorrect', context);
                                }
                              } else {
                                showSnackBar(
                                    'The username is incorrect', context);
                              }
                            }
                          },
                          child: const Text('Login'))
                    ],
                  ),
                ),
              ),
            );
          } else {
            // No hay datos, error
            return Text(snapshot.error.toString());
          }
        }));
  }
}
