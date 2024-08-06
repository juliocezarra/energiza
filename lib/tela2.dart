import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SolarPanelScreen(),
    );
  }
}

class SolarPanelScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: Text(''),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Center(
        child: Card(
          color: const Color.fromARGB(255, 42, 221, 48).withOpacity(0.2),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/solar_panel.png', // Caminho da imagem da placa solar
                      width: 80,
                      height: 80,
                    ),
                    SizedBox(width: 16),
                    Text(
                      'Placa Solar NJ9',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text('Status de limpeza'),
                LinearProgressIndicator(
                  value: 0.5, // Progresso da limpeza
                  backgroundColor: Colors.red[100],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ),
                SizedBox(height: 16),
                Text('Rentabilidade'),
                SizedBox(height: 200, child: Center(child: Text('Gráfico aqui'))), // Placeholder para o gráfico
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green, // Define a cor do ícone selecionado para verde
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
