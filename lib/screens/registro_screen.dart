import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:prueba2/screens/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrarse')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Correo Electrónico'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Contraseña'),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => _register(context),
              child: const Text("Registrar", style: TextStyle(fontSize: 25)),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _register(context) async {
    try {

      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      _goToLoginScreen(context);
    } on FirebaseAuthException catch (e) {
   
      if (e.code == 'weak-password') {
        _showAlertDialog(context, 'La contraseña proporcionada es demasiado débil.');
      } else if (e.code == 'email-already-in-use') {
        _showAlertDialog(context, 'El correo electrónico ya está registrado.');
      } else {
        _showAlertDialog(context, 'Error: ${e.message}');
      }
    } catch (e) {
      _showAlertDialog(context, 'Ocurrió un error desconocido. Inténtalo de nuevo.');
    }
  }

  void _goToLoginScreen(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  LoginScreen()),
    );
  }

  void _showAlertDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); 
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}
