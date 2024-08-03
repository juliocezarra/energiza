import 'package:flutter/material.dart';

class ConfigMenu extends StatelessWidget {
  const ConfigMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);  // Navega de volta para a HomePage
          },
        ),
        title: const Text('Perfil'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Color.fromARGB(255, 161, 161, 161)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.green),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.popUntil(context, ModalRoute.withName('/'));
          }
        },
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color? color;

  const _SettingsItem({
    required this.title,
    required this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(144, 238, 144, 0.25),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Navegar para a tela correspondente, se necessário
        },
      ),
    );
  }
}
