import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DepositosScreen extends StatefulWidget {
  const DepositosScreen({super.key});

  @override
  _DepositosScreenState createState() => _DepositosScreenState();
}

class _DepositosScreenState extends State<DepositosScreen> {
  Future<List<dynamic>> fetchDepositos() async {
    final response = await http.get(Uri.parse('https://jritsqmet.github.io/web-api/depositos.json'));

    if (response.statusCode == 200) {
      // Si la respuesta es exitosa, decodificamos el JSON
      List<dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Error al cargar los depósitos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Depósitos')),
      body: FutureBuilder<List<dynamic>>(
        future: fetchDepositos(), // Llamamos la API y obtenemos los depósitos
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay depósitos disponibles'));
          } else {
            List<dynamic> depositos = snapshot.data!;

            return ListView.builder(
              itemCount: depositos.length,
              itemBuilder: (context, index) {
                var deposito = depositos[index];

                return ListTile(
                  title: Text('Monto: \$${deposito['monto']}'),
                  subtitle: Text('Banco: ${deposito['banco']}'),
                  leading: Image.network(deposito['detalles']['imagen_comprobante'], width: 40, height: 40, fit: BoxFit.cover),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Detalles de Depósito'),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('ID: ${deposito['id']}'),
                            Text('Banco: ${deposito['banco']}'),
                            Text('Monto: \$${deposito['monto']}'),
                            Text('Fecha: ${deposito['fecha']}'),
                            Text('Método de Pago: ${deposito['detalles']['método_pago']}'),
                            Text('Estado: ${deposito['detalles']['estado']}'),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cerrar'),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
