import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificaciones'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildNotification(
              'Pago realizado',
              'Has realizado un pago de \$1000 a tu tarjeta Visa.',
              Icons.payment,
            ),
            _buildNotification(
              'Transferencia exitosa',
              'Tu transferencia de \$250 a cuenta 2345 fue exitosa.',
              Icons.swap_horiz,
            ),
            _buildNotification(
              'Nuevo mensaje',
              'Tienes un mensaje nuevo en tu bandeja de entrada.',
              Icons.message,
            ),
            _buildNotification(
              'Configuración actualizada',
              'Tu cuenta ha sido actualizada correctamente.',
              Icons.settings,
            ),
            // Puedes agregar más notificaciones aquí
          ],
        ),
      ),
    );
  }

  // Helper function to build each notification item
  Widget _buildNotification(String title, String message, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueGrey),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(message),
      ),
    );
  }
}
