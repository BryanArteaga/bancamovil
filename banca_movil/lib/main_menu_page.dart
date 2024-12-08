import 'package:banca_movil/account_page.dart';
import 'package:banca_movil/main.dart';
import 'package:banca_movil/notifications_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'increase_buttons.dart';
import 'transfer_page.dart'; // Asegúrate de que esta página exista
import 'withdrawal_page.dart'; // Asegúrate de que esta página exista
import 'payments_page.dart'; // Asegúrate de que esta página exista

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({Key? key}) : super(key: key);

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  String? selectedCard; // Tarjeta seleccionada ('Visa' o 'MasterCard')
  bool showCardNumber = false; // Mostrar u ocultar el número de tarjeta
  bool showCardDetails = false; // Mostrar u ocultar los detalles de la tarjeta

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      backgroundColor: Color(0xFF2B3147),
      body: SafeArea(
        child: Column(
          children: [
            // Header section
            Container(
              padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
              color: Color(0xFF2B3147),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'BanSoftware',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Irving Zambrano',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: appState.fontSize + 8,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '\$ 8,640.00',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: appState.fontSize + 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'SALDO',
                    style: TextStyle(
                        color: Colors.white70, fontSize: appState.fontSize - 2),
                  ),
                ],
              ),
            ),
            // Main content
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFE5E9F5),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    const IncreaseButtons(),
                    // Quick actions
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildActionButton(
                            context,
                            Icons.swap_horiz,
                            'Transferir',
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const TransferPage()),
                            ),
                            Colors.blue,
                          ),
                          _buildActionButton(
                            context,
                            Icons.receipt_long,
                            'Retiro',
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const WithdrawalPage()),
                            ),
                            Colors.orange,
                          ),
                          _buildActionButton(
                            context,
                            Icons.payment,
                            'Pagos',
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PaymentsPage()),
                            ),
                            Colors.green,
                          ),
                          _buildActionButton(
                            context,
                            Icons.more_horiz,
                            'Más',
                            () => showModalBottomSheet(
                              context: context,
                              builder: (context) => Container(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      leading: Icon(Icons.settings),
                                      title: Text('Configurar'),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.logout),
                                      title: Text('Cerrar sesión'),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.account_circle),
                                      title: Text('Mi cuenta'),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const AccountPage()),
                                        );
                                      },
                                    ),
                                    // Añadir la opción de Notificaciones
                                    ListTile(
                                      leading: Icon(Icons.notifications),
                                      title: Text('Notificaciones'),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const NotificationsPage()),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Colors.purple,
                          ),
                        ],
                      ),
                    ),

                    // Cards section
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Tarjetas',
                              style: TextStyle(
                                  fontSize: appState.fontSize + 2,
                                  fontWeight: FontWeight.bold)),
                          _buildCard('Visa Card', '**3245', '\$2,200', 'visa',
                              appState),
                          _buildCard('Master Card', '**6539', '\$550',
                              'mastercard', appState),
                        ],
                      ),
                    ),
                    // Movements section
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Movimientos',
                                  style: TextStyle(
                                      fontSize: appState.fontSize + 2,
                                      fontWeight: FontWeight.bold)),
                              TextButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) => Container(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Historial de Movimientos',
                                            style: TextStyle(
                                                fontSize: appState.fontSize + 4,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 16),
                                          _buildMovement('Tuti', '-\$400',
                                              Icons.shopping_cart, appState),
                                          _buildMovement('Matrícula', '-\$120',
                                              Icons.school, appState),
                                          _buildMovement(
                                              'Transferencia',
                                              '-\$250',
                                              Icons.swap_horiz,
                                              appState),
                                          _buildMovement('Pago servicios',
                                              '-\$80', Icons.receipt, appState),
                                          _buildMovement('Depósito', '+\$1000',
                                              Icons.add_circle, appState),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                child: Text('ver más',
                                    style:
                                        TextStyle(fontSize: appState.fontSize)),
                              ),
                            ],
                          ),
                          _buildMovement(
                              'Tuti', '-\$400', Icons.shopping_cart, appState),
                          _buildMovement(
                              'Matrícula', '-\$120', Icons.school, appState),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardItem(BuildContext context, String title, String number,
      String amount, String type) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCard = title; // Asigna la tarjeta seleccionada
          showCardNumber = false;
          showCardDetails = false;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.network(
                    type == 'visa'
                        ? 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Visa_Inc._logo.svg/2560px-Visa_Inc._logo.svg.png'
                        : 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Mastercard-logo.svg/1280px-Mastercard-logo.svg.png',
                    height: 30,
                    width: 50,
                  ),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(number, style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
            Text(
              amount,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  // Método para mostrar los detalles de la tarjeta seleccionada
  Widget _buildCardDetails(BuildContext context, AppState appState) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            'Detalles de ${selectedCard ?? ''}',
            style: TextStyle(
              fontSize: appState.fontSize + 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                showCardNumber ? 'Número: 1234 5678 9101 1121' : 'Número: ****',
                style: TextStyle(fontSize: appState.fontSize),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    showCardNumber = !showCardNumber;
                  });
                },
                child: Text(
                  showCardNumber ? 'Ocultar' : 'Mostrar',
                  style: TextStyle(fontSize: appState.fontSize),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                showCardDetails
                    ? 'Vencimiento: 12/26\nCVV: 123'
                    : 'Detalles ocultos',
                style: TextStyle(fontSize: appState.fontSize),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    showCardDetails = !showCardDetails;
                  });
                },
                child: Text(
                  showCardDetails ? 'Ocultar' : 'Mostrar',
                  style: TextStyle(fontSize: appState.fontSize),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, IconData icon, String title,
      VoidCallback onPressed, Color backgroundColor) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: CircleBorder(),
            padding: EdgeInsets.all(20), // Más grande para accesibilidad
          ),
          child: Icon(icon, size: 30, color: Colors.white),
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildCard(String name, String number, String amount, String type,
      AppState appState) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.network(
                  type == 'visa'
                      ? 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Visa_Inc._logo.svg/2560px-Visa_Inc._logo.svg.png'
                      : 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Mastercard-logo.svg/1280px-Mastercard-logo.svg.png',
                  height: appState.buttonSize * 0.3,
                  width: appState.buttonSize * 0.6,
                ),
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: appState.fontSize)),
                  Text(number,
                      style: TextStyle(
                          color: Colors.grey, fontSize: appState.fontSize - 2)),
                ],
              ),
            ],
          ),
          Text(amount,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: appState.fontSize)),
        ],
      ),
    );
  }

  Widget _buildMovement(
      String name, String amount, IconData icon, AppState appState) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon,
                    color: Color(0xFF2B3147), size: appState.buttonSize * 0.4),
              ),
              SizedBox(width: 15),
              Text(name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: appState.fontSize)),
            ],
          ),
          Text(amount,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: amount.startsWith('-') ? Colors.red : Colors.green,
                  fontSize: appState.fontSize)),
        ],
      ),
    );
  }
}
