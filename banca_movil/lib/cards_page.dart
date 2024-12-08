import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';

class CardsPage extends StatefulWidget {
  const CardsPage({super.key});

  @override
  _CardsPageState createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {
  String? selectedCard; // Almacena la tarjeta seleccionada (Visa o Master)
  bool showCardNumber = false; // Controla si se muestra el número de tarjeta
  bool showCardDetails = false; // Controla si se muestran los datos adicionales

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        title:
            Text('Tarjetas', style: TextStyle(fontSize: appState.fontSize + 6)),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: selectedCard == null
            ? _buildCardList(
                appState) // Si no hay tarjeta seleccionada, muestra la lista
            : _buildCardDetails(
                appState), // Si hay tarjeta seleccionada, muestra los detalles
      ),
    );
  }

  // Construye la lista de tarjetas
  Widget _buildCardList(AppState appState) {
    return Column(
      children: [
        _buildCardItem(
          appState,
          logo: Icons.credit_card,
          title: 'Visa Card',
          subtitle: '**3245',
          onTap: () {
            setState(() {
              selectedCard = 'Visa';
            });
          },
        ),
        const SizedBox(height: 16),
        _buildCardItem(
          appState,
          logo: Icons.credit_card,
          title: 'Master Card',
          subtitle: '**6539',
          onTap: () {
            setState(() {
              selectedCard = 'Master';
            });
          },
        ),
      ],
    );
  }

  // Construye un elemento de tarjeta en la lista
  Widget _buildCardItem(AppState appState,
      {required IconData logo,
      required String title,
      required String subtitle,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          leading: Icon(logo,
              size: appState.buttonSize * 0.7, color: Colors.blueGrey),
          title: Text(title, style: TextStyle(fontSize: appState.fontSize)),
          subtitle:
              Text(subtitle, style: TextStyle(fontSize: appState.fontSize - 2)),
        ),
      ),
    );
  }

  // Construye los detalles de la tarjeta seleccionada
  Widget _buildCardDetails(AppState appState) {
    // Información específica para cada tarjeta
    String cardNumber =
        selectedCard == 'Visa' ? '1234 5678 9012 3245' : '9876 5432 1098 6539';
    String cardDetails = selectedCard == 'Visa'
        ? 'Nombre: Juan Pérez\nFecha Expiración: 12/25\nBanco: Banco XYZ'
        : 'Nombre: Ana López\nFecha Expiración: 08/24\nBanco: Banco ABC';

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.credit_card,
          size: 120,
          color: Colors.blueGrey,
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              showCardNumber
                  ? cardNumber
                  : '**** **** **** ${cardNumber.substring(cardNumber.length - 4)}',
              style: const TextStyle(fontSize: 24),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  showCardNumber = !showCardNumber;
                });
              },
              icon: Icon(
                  showCardNumber ? Icons.visibility_off : Icons.visibility),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            setState(() {
              showCardDetails = !showCardDetails;
            });
          },
          child: Text(showCardDetails ? 'Ocultar Datos' : 'Mostrar Datos'),
        ),
        if (showCardDetails)
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Text(
              cardDetails,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () {
            setState(() {
              selectedCard = null; // Regresa a la lista de tarjetas
              showCardNumber = false; // Restablece estado
              showCardDetails = false;
            });
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          ),
          child: const Text('Regresar', style: TextStyle(fontSize: 20)),
        ),
      ],
    );
  }
}
