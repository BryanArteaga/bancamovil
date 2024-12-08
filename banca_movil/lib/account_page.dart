import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Cuenta'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blueGrey,
                child: Icon(
                  Icons.person,
                  size: 80,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Name
            const Text(
              'Irving Zambrano',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            // Email
            Text(
              'irving.zambrano@email.com',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 20),
            // Account Details
            const Text(
              'Datos de la cuenta',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildAccountDetailRow(
                Icons.card_travel, 'Número de tarjeta', '**** **** **** 3245'),
            _buildAccountDetailRow(
                Icons.access_time, 'Fecha de creación', '01/2023'),
            _buildAccountDetailRow(
                Icons.money, 'Saldo disponible', '\$8,640.00'),
            _buildAccountDetailRow(
                Icons.notifications, 'Notificaciones', 'Habilitadas'),
          ],
        ),
      ),
    );
  }

  // Helper function to build a row of account details
  Widget _buildAccountDetailRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, size: 30, color: Colors.blueGrey),
          const SizedBox(width: 15),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
