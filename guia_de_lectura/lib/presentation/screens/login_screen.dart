import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:guia_de_lectura/config/theme/app_theme.dart';
import 'package:guia_de_lectura/core/data/firebase_auth_service.dart';
import 'package:guia_de_lectura/domain/credentials.dart';
import 'package:guia_de_lectura/domain/user.dart';
import 'package:guia_de_lectura/presentation/providers/book_provider.dart';
import 'package:guia_de_lectura/presentation/providers/user_provider.dart';
import 'package:guia_de_lectura/presentation/screens/password_screen.dart';
import 'package:guia_de_lectura/presentation/screens/signup_screen.dart';
import 'package:guia_de_lectura/presentation/widgets/asset_image.dart';
import 'package:guia_de_lectura/presentation/widgets/snackbar.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  static String name = 'LoginScreen';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool passwordVisible = false;
  bool stayLoggedIn = false;
  bool _isLoading = false;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser != null ? isLoggedIn = true : false;
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(myUserNotifierProvider);

    // Si ya esta logeado, reanudar la sesion
    if (isLoggedIn) {
      Future.delayed(const Duration(milliseconds: 100))
          .then((value) => loginFromPreviousSesion());
    }

    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackgroundColorLight,
      body: Stack(children: [
        SingleChildScrollView(
          child: Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                getImageWithSizeFromAsset(
                    'assets/images/LogoCircular.png', 250, 250),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Olvido su contraseña?",
                      style: TextStyle(color: AppTheme.textColorDark),
                    ),
                    TextButton(
                      onPressed: () {
                        // cargarBaseDeDatos();
                        context.pushNamed(PasswordScreen.name);
                      },
                      child: const Text(
                        'Reestablecer',
                        style:
                            TextStyle(color: AppTheme.scaffoldBackgroundColor),
                      ),
                    ),
                  ],
                ),
                // Row(
                //   children: [
                //     Checkbox(
                //         value: stayLoggedIn,
                //         onChanged: (value) {
                //           setState(() {
                //             stayLoggedIn = !stayLoggedIn;
                //           });
                //         }),
                //     const Text(
                //       "Recuerdame",
                //       style: TextStyle(color: AppTheme.textColorDark),
                //     )
                //   ],
                // ),
                const SizedBox(height: 40),
                ElevatedButton(
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all<Size>(const Size(100, 50)),
                      backgroundColor: MaterialStateProperty.all<Color>(AppTheme
                          .scaffoldBackgroundColor), // Hacer el fondo transparente
                      foregroundColor: MaterialStateProperty.all<Color>(
                          AppTheme.textColor), // Color del texto
                    ),
                    onPressed: _onLoginButtonPressed,
                    child: const Text(
                      'Iniciar sesion',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Usuario nuevo?",
                      style: TextStyle(color: AppTheme.textColorDark),
                    ),
                    TextButton(
                      onPressed: () {
                        context.pushNamed(SignUpScreen.name);
                      },
                      child: const Text(
                        'Registrarse',
                        style:
                            TextStyle(color: AppTheme.scaffoldBackgroundColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
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
      ]),
    );
  }

  // ----------------------------------
  // ------------- Boton --------------
  // ----------------------------------
  void _onLoginButtonPressed() async {
    FocusManager.instance.primaryFocus?.unfocus();
    // ignore: unused_local_variable
    MyUser? myUser;

    final credentials = LoginCredentials(
      email: userController.text,
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
      final user = await authService.signInWithEmailAndPassword(
        credentials.email,
        credentials.password,
      );

      // Pido el usuario a la base de datos para luego utilizarlo en la aplicacion
      myUser = await MyUser.getfromFirestore(user.uid);
      ref.read(myUserNotifierProvider.notifier).setUser(myUser!);

      // Pido los libros de la base de datos para iniciar la aplicacion
      ref.read(bookProvider.notifier).getAllBooks();

      // Paso a la homescreen
      context.go('/home/${user.uid}');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar('Usuario no encontrado', context);
      } else if (e.code == 'wrong-password') {
        showSnackBar('Contraseña incorrecto', context);
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
  }

  Future<void> loginFromPreviousSesion() async {
    MyUser? myUser;
    setState(() {
      _isLoading = true;
    });
    try {
      // Pido el usuario a la base de datos para luego utilizarlo en la aplicacion
      myUser =
          await MyUser.getfromFirestore(FirebaseAuth.instance.currentUser!.uid);
      ref.read(myUserNotifierProvider.notifier).setUser(myUser!);

      // Pido los libros de la base de datos para iniciar la aplicacion
      ref.read(bookProvider.notifier).getAllBooks();

      setState(() {
        _isLoading = false;
      });

      // Paso a la homescreen
      context.go('/home/${FirebaseAuth.instance.currentUser!.uid}');
    } on FirebaseException {
      showSnackBar('Error de conexion', context);
    } catch (e) {}
  }

  //
  // Precarga de base de datos, descomentar para su uso
  //
  // Future<void> cargarBaseDeDatos() async {
  //   // Obtener referencia al archivo en Storage
  //   final ref = FirebaseStorage.instance.ref();
  //   final storageRef = ref.child('assets/images/book_covers/Sunlit.png');

  //   // Obtener el enlace de descarga
  //   String downloadURL = await storageRef.getDownloadURL();

  //   Book newBook = Book(
  //     title: 'El Hombre Iluminado',
  //     year: '2023',
  //     coverURL: downloadURL,
  //     description:
  //         'Años atrás tenía compañeros de armas y una causa en la que creer, pero ahora el hombre que se hace llamar a sí mismo Nomad solo conoce una vida huyendo. Forzado a saltar de mundo en mundo dentro del Cosmere, cada vez que la implacable «Night Brigade» se acerca demasiado, Nomad acaba llegando a un nuevo planeta donde se ve inmediatamente envuelto en una contienda entre un tirano y unos rebeldes.',
  //     id: '25',
  //     order: 25,
  //   );

  //   await newBook.addToFirestore();
  // }
}
