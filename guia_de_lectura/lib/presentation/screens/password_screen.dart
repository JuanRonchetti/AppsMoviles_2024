import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:guia_de_lectura/config/theme/app_theme.dart';
import 'package:guia_de_lectura/presentation/widgets/snackbar.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  static String name = 'PasswordScreen';

  @override
  State<StatefulWidget> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  TextEditingController emailController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackgroundColorLight,
      appBar: AppBar(
        title: const Text('Cambiar contraseña'),
        backgroundColor: AppTheme.scaffoldBackgroundColor,
        foregroundColor: AppTheme.textColor,
      ),
      body: Stack(children: [
        SingleChildScrollView(
          child: Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 100),
                const Icon(
                  Icons.email_outlined,
                  size: 100,
                  color: AppTheme.scaffoldBackgroundColor,
                ),
                const SizedBox(height: 60),
                const Text(
                  "Recibira un correo con las instrucciones para reestablecer su contraseña",
                  style: TextStyle(
                      color: AppTheme.textColorDark,
                      fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
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
                      setState(() {
                        _isLoading = true;
                      });

                      try {
                        // FirebaseAuthService();
                        await FirebaseAuth.instance.sendPasswordResetEmail(
                            email: emailController.text.trim());
                        setState(() {
                          _isLoading = true;
                        });
                        // Vuelvo a la pantalla de login
                        context.pop();
                      } catch (e) {
                        showSnackBar('Fallo en la operacion', context);
                      } finally {
                        // Hide the loading indicator
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    },
                    child: const Text(
                      'Enviar',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
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
}
