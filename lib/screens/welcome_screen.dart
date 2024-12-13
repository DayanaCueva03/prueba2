import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,  
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 185, 17, 190),  
        title: Row(
          children: [
            
            Image.network(
              'https://www.descargas.com/images/7330/banco-guayaquil_icon_android.png',
              height: 40,  
            ),
            const SizedBox(width: 10),  
            const Text(
              'BANCO GUAYAQUIL',
              style: TextStyle(
                fontSize: 24, 
                fontWeight: FontWeight.bold,
                color: Colors.white, 
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Bienvenido a Banco de Guayaquil!',
              style: TextStyle(
                fontSize: 28, 
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F3B69),  
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
               padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 40.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), 
                ),
              ),
              child: const Text(
                'Iniciar sesión',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 40.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Registrarse',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'Desarrollador: Dayana Cueva\nGitHub: @',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF7D7D7D),  
              ),
            ),
          ],
        ),
      ),
    );
  }
}
