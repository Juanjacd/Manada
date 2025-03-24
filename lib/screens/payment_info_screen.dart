import 'package:flutter/material.dart';

class PaymentInfoScreen extends StatelessWidget {
  const PaymentInfoScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Costo y Formas de Pago")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Costo del Paseo:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("El costo del paseo es de \$15.00 por 30 minutos."),
            SizedBox(height: 20),
            Text(
              "Formas de Pago:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("• Tarjeta de crédito/débito"),
            Text("• Efectivo"),
            Text("• Transferencia bancaria"),
          ],
        ),
      ),
    );
  }
}
