import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:prueba2/screens/depositos_screen.dart';
import 'package:prueba2/screens/login_screen.dart';
import 'package:prueba2/screens/registro_screen.dart';
import 'package:prueba2/screens/transferencias_screen.dart';
import 'package:prueba2/screens/welcome_screen.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicación Bancaria',
      initialRoute: '/',
      routes: {
        '/': (context) =>  WelcomeScreen(),
        '/login': (context) =>  LoginScreen(),
        '/register': (context) =>  RegisterScreen(),
        '/transferencias': (context) =>  TransferenciasScreen(),
        '/depositos': (context) => const DepositosScreen(),
      },
    );
  }
}
