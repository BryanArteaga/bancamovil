import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';

class IncreaseButtons extends StatelessWidget {
  const IncreaseButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            appState.increaseFontSize();
            appState.increaseButtonSize();
          },
          child: const Text('Aumentar'),
        ),
        const SizedBox(width: 20),
        ElevatedButton(
          onPressed: () {
            appState.decreaseFontSize();
            appState.decreaseButtonSize();
          },
          child: const Text('Disminuir'),
        ),
      ],
    );
  }
}
