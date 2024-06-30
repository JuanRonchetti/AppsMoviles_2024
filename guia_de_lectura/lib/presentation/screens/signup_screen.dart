import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:guia_de_lectura/config/theme/app_theme.dart';
import 'package:guia_de_lectura/core/data/firebase_auth_service.dart';
import 'package:guia_de_lectura/domain/book.dart';
import 'package:guia_de_lectura/domain/credentials.dart';
import 'package:guia_de_lectura/domain/user.dart';
import 'package:guia_de_lectura/presentation/providers/book_provider.dart';
import 'package:guia_de_lectura/presentation/providers/user_provider.dart';
import 'package:guia_de_lectura/presentation/widgets/snackbar.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  static String name = 'SignUpScreen';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool passwordVisible = false;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    ref.read(bookProvider.notifier).getAllBooks();
  }

  @override
  Widget build(BuildContext context) {
    List<Book> bookList = ref.watch(bookProvider);
    ref.watch(myUserNotifierProvider);
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackgroundColorLight,
      appBar: AppBar(
        title: const Text('Nuevo usuario'),
        backgroundColor: AppTheme.scaffoldBackgroundColor,
        foregroundColor: AppTheme.textColor,
      ),
      body: Stack(children: [
        SingleChildScrollView(
          child: Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                const Icon(
                  Icons.person_add,
                  size: 100,
                  color: AppTheme.scaffoldBackgroundColor,
                ),
                const SizedBox(height: 60),
                TextFormField(
                  controller: userController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppTheme.scaffoldBackgroundColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: AppTheme.scaffoldBackgroundColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Usuario',
                      hintText: 'Ingrese su usuario',
                      labelStyle: const TextStyle(
                          color: AppTheme.scaffoldBackgroundColor),
                      prefixIcon: const Icon(Icons.person_2_outlined)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese su usuario';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppTheme.scaffoldBackgroundColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: AppTheme.scaffoldBackgroundColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Correo',
                      hintText: 'Ingrese su correo',
                      labelStyle: const TextStyle(
                          color: AppTheme.scaffoldBackgroundColor),
                      prefixIcon: const Icon(Icons.person_2_outlined)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese su correo';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: passwordController,
                  obscureText: !passwordVisible,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: AppTheme.scaffoldBackgroundColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: AppTheme.scaffoldBackgroundColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Contraseña',
                    hintText: 'Ingrese su contraseña',
                    labelStyle: const TextStyle(
                        color: AppTheme.scaffoldBackgroundColor),
                    prefixIcon: const Icon(Icons.password),
                    suffixIcon: IconButton(
                      icon: Icon(
                        passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppTheme.textColorDark,
                      ),
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese su contraseña';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all<Size>(const Size(100, 50)),
                      backgroundColor: MaterialStateProperty.all<Color>(AppTheme
                          .scaffoldBackgroundColor), // Hacer el fondo transparente
                      foregroundColor: MaterialStateProperty.all<Color>(
                          AppTheme.textColor), // Color del texto
                    ),
                    // ----------------------------------
                    // ----------- Boton ----------------
                    // ----------------------------------
                    onPressed: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      // ignore: unused_local_variable
                      MyUser? myUser;

                      final credentials = SignUpCredentials(
                        username: userController.text,
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      if (!credentials.isValid) {
                        showSnackBar('Credenciales invalidas', context);
                        return;
                      }
                      // Show a loading indicator
                      setState(() {
                        _isLoading = true;
                      });

                      try {
                        // Autentico al usuario
                        final authService = FirebaseAuthService();
                        final createdUser =
                            await authService.registerWithEmailAndPassword(
                          credentials.email,
                          credentials.password,
                        );

                        // Creo el usuario para la db
                        final newUser = MyUser(
                            id: createdUser.uid,
                            username: credentials.username,
                            email: credentials.email);

                        // Precargo los libros
                        newUser.createBookStatusList(bookList);

                        // Lo subo a firestore
                        await MyUser.saveToFirestore(newUser);

                        // Vuelvo a la pantalla de login
                        context.pop();
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnackBar('La contraseña es muy debil', context);
                        } else if (e.code == 'email-already-in-use') {
                          showSnackBar(
                              'Ya existe un usuario con este correo', context);
                        }
                      } on FirebaseException {
                        showSnackBar('Error de conexion', context);
                      } catch (e) {
                        showSnackBar('Autenticacion fallida', context);
                      } finally {
                        // Hide the loading indicator
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    },
                    child: const Text(
                      'Registrarse',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ],
            ),
          ),
        ),
        // Show a loading indicator if the state is loading
        if (_isLoading)
          Container(
            color: AppTheme.detailColor.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(
                color: AppTheme.scaffoldBackgroundColor,
              ),
            ),
          ),
      ]),
    );
  }
}
