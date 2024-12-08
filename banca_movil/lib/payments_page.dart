import 'package:flutter/material.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({super.key});

  @override
  _PaymentsPageState createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  // Variables para controlar el estado de las selecciones
  bool _isServiceSelected = false;
  bool _isAccountSelected = false;
  String? _selectedService;
  String? _accountNumber;
  double _amountToPay = 0.0;

  // Opciones de servicios
  final List<String> _services = ['Luz', 'Agua', 'Internet', 'Gas'];

  // Controladores de texto para ingresar número de cuenta
  final TextEditingController _accountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          // Centrar el contenido en la pantalla
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Si no se ha seleccionado ninguna opción, mostrar las opciones como lista
              if (!_isServiceSelected && !_isAccountSelected) ...[
                _buildOptionList(),
              ],

              // Si se selecciona un servicio
              if (_isServiceSelected) ...[
                _buildServiceSelection(),
              ],

              // Si se selecciona ingresar número de cuenta
              if (_isAccountSelected) ...[
                _buildAccountNumberInput(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // Opción de mostrar lista de botones grandes con iconos
  Widget _buildOptionList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildOptionButton(
          icon: Icons.home_repair_service,
          label: 'Seleccionar Servicio',
          onPressed: () {
            setState(() {
              _isServiceSelected = true;
              _isAccountSelected = false;
            });
          },
        ),
        const SizedBox(height: 40),
        _buildOptionButton(
          icon: Icons.account_balance,
          label: 'Ingresar Número de Cuenta',
          onPressed: () {
            setState(() {
              _isServiceSelected = false;
              _isAccountSelected = true;
            });
          },
        ),
      ],
    );
  }

  // Botón con icono y texto grande
  Widget _buildOptionButton(
      {required IconData icon,
      required String label,
      required VoidCallback onPressed}) {
    return ElevatedButton.icon(
      icon: Icon(icon, size: 60), // Icono más grande
      label:
          Text(label, style: const TextStyle(fontSize: 24)), // Texto más grande
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        minimumSize: const Size(250, 80), // Botón más grande
      ),
      onPressed: onPressed,
    );
  }

  // Mostrar selección de servicio
  Widget _buildServiceSelection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('Seleccione un Servicio', style: TextStyle(fontSize: 24)),
        const SizedBox(height: 20),
        DropdownButton<String>(
          value: _selectedService,
          hint: const Text('Seleccione el servicio',
              style: TextStyle(fontSize: 18)),
          onChanged: (String? newValue) {
            setState(() {
              _selectedService = newValue;
              // Monto a pagar según el servicio
              switch (_selectedService) {
                case 'Luz':
                  _amountToPay = 200.0;
                  break;
                case 'Agua':
                  _amountToPay = 150.0;
                  break;
                case 'Internet':
                  _amountToPay = 500.0;
                  break;
                case 'Gas':
                  _amountToPay = 120.0;
                  break;
                default:
                  _amountToPay = 0.0;
              }
            });
          },
          items: _services.map((service) {
            return DropdownMenuItem<String>(
              value: service,
              child: Text(service, style: const TextStyle(fontSize: 20)),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
        if (_selectedService != null) ...[
          Text('Monto a pagar: \$$_amountToPay',
              style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              _showPaymentConfirmation(context);
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(250, 80), // Hacer el botón grande
              padding: const EdgeInsets.symmetric(vertical: 20),
            ),
            child: const Text('Confirmar Pago', style: TextStyle(fontSize: 24)),
          ),
        ],
      ],
    );
  }

  // Mostrar campo para ingresar número de cuenta
  Widget _buildAccountNumberInput() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('Ingrese el número de cuenta',
            style: TextStyle(fontSize: 24)),
        const SizedBox(height: 20),
        TextField(
          controller: _accountController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Número de cuenta',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            hintStyle: TextStyle(fontSize: 18),
          ),
        ),
        const SizedBox(height: 20),
        const Text('Monto a pagar', style: TextStyle(fontSize: 24)),
        TextField(
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Monto',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            hintStyle: TextStyle(fontSize: 18),
          ),
          onChanged: (value) {
            setState(() {
              _amountToPay = double.tryParse(value) ?? 0.0;
            });
          },
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () {
            _showPaymentConfirmation(context);
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(250, 80), // Hacer el botón grande
            padding: const EdgeInsets.symmetric(vertical: 20),
          ),
          child: const Text('Confirmar Pago', style: TextStyle(fontSize: 24)),
        ),
      ],
    );
  }

  // Función para mostrar el mensaje de confirmación
  void _showPaymentConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmación de Pago'),
          content: Text(
              '¿Está seguro de que desea realizar este pago de \$$_amountToPay?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _showSuccessMessage(context);
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  // Función para mostrar el mensaje de éxito
  void _showSuccessMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pago Exitoso'),
          content: Text('Su pago de \$$_amountToPay se realizó con éxito.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _resetPaymentForm(); // Reinicia el estado después de realizar el pago
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  // Función para reiniciar el formulario después de un pago exitoso
  void _resetPaymentForm() {
    setState(() {
      _isServiceSelected = false;
      _isAccountSelected = false;
      _selectedService = null;
      _amountToPay = 0.0;
      _accountController.clear();
    });
  }
}
