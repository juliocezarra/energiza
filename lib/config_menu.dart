import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Solar Panel App',
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navegar para a tela anterior
          },
        ),
        title: Text('Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center( // Adicione o Center aqui
              child: Text(
                'Casa',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 24.0),
            Text(
              'Configurações',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            _SettingsItem(
              title: 'Meus aparelhos',
              icon: Icons.devices,
            ),
            _SettingsItem(
              title: 'Novo Aparelho',
              icon: Icons.add,
            ),
            _SettingsItem(
              title: 'Novo Perfil',
              icon: Icons.person_add,
            ),
            _SettingsItem(
              title: 'Idioma',
              icon: Icons.language,
            ),
            _SettingsItem(
              title: 'Problemas?',
              icon: Icons.help,
            ),
            _SettingsItem(
              title: 'Atualizações',
              icon: Icons.update,
            ),
            _SettingsItem(
              title: 'Sair',
              icon: Icons.exit_to_app,
              color: Colors.red,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
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

class _SettingsItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color? color;

  const _SettingsItem({
    Key? key,
    required this.title,
    required this.icon,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        // Navegar para a tela correspondente
      },
    );
  }
}