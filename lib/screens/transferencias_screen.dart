import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'depositos_screen.dart'; 

class TransferenciasScreen extends StatefulWidget {
  TransferenciasScreen({super.key});

  @override
  _TransferenciasScreenState createState() => _TransferenciasScreenState();
}

class _TransferenciasScreenState extends State<TransferenciasScreen> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController montoController = TextEditingController();

  int _transferenciaId = 1000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transferencias')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nombreController,
              decoration: const InputDecoration(labelText: 'Nombre del Destinatario'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: montoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Monto'),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                _realizarTransferencia(context);
              },
              child: const Text('Revisar Transferencia'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => guardar(nombreController.text, montoController.text),
              child: const Text('Guardar', style: TextStyle(fontSize: 25)),
            ),
            const SizedBox(height: 20),
           
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DepositosScreen()),
                );
              },
              child: const Text('Ir a Depositos', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }

  void _realizarTransferencia(BuildContext context) {
    String idTransferencia = _generarIdTransferencia(); 

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Verifique su Transferencia '),
        content: Text(
          'ID de Transferencia: $idTransferencia\nDestinatario: ${nombreController.text}\nMonto: \$${montoController.text}',
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
  }

  String _generarIdTransferencia() {
    _transferenciaId++; 
    return _transferenciaId.toString(); 
  }

  Future<void> guardar(String nombre, String monto) async {
    String idTransferencia = _generarIdTransferencia(); 

    DatabaseReference ref = FirebaseDatabase.instance.ref("transferencias/$idTransferencia");

    await ref.set({
      "id": idTransferencia,
      "nombre": nombre,
      "monto": monto,
    }).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Transferencia exitosa')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al guardar transferencia: $error')),
      );
    });
  }
}
