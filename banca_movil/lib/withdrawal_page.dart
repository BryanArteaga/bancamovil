import 'package:flutter/material.dart';

class WithdrawalPage extends StatelessWidget {
  const WithdrawalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Retiro'),
      ),
      body: const Center(
        child: Text('Página de Retiro'),
      ),
    );
  }
}
