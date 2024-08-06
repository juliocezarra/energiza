// lib/main.dart
import 'package:flutter/material.dart';
import 'config_menu.dart';
import 'login.dart';
import 'create_device.dart' as create_device;
import 'database_helper.dart' as database_helper;
import 'device.dart'; // Importa a definição correta da classe Device

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dispositivos',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/config': (context) => const ConfigMenuScreen(),
        '/create_device': (context) => const create_device.CreateDeviceScreen(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Device> devices = []; // Inicialmente vazio, será preenchido com dados do banco de dados

  @override
  void initState() {
    super.initState();
    _loadDevices();
  }

  void _loadDevices() async {
    devices = await database_helper.DatabaseHelper.instance.getDevices(); // Usando o alias
    setState(() {});
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 1) {
      Navigator.pushNamed(context, '/config');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dispositivos'),
        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/login',
              (route) => false,
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/create_device');
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: devices.length,
        itemBuilder: (context, index) {
          return DeviceCard(device: devices[index]);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
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
        onTap: _onItemTapped,
      ),
    );
  }
}

class DeviceCard extends StatefulWidget {
  final Device device;

  const DeviceCard({super.key, required this.device});

  @override
  _DeviceCardState createState() => _DeviceCardState();
}

class _DeviceCardState extends State<DeviceCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        color: Colors.green.withOpacity(0.2),
        padding: const EdgeInsets.all(26.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(widget.device.image),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.device.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      const Icon(Icons.battery_charging_full),
                      const SizedBox(width: 4.0),
                      Text(
                        '${widget.device.status}%',
                        style: const TextStyle(fontSize: 14.0),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  widget.device.isOn = !widget.device.isOn;
                });
              },
              icon: Icon(
                widget.device.isOn
                    ? Icons.power_settings_new
                    : Icons.power_off,
                color: widget.device.isOn ? Colors.green : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ConfigMenuScreen extends StatelessWidget {
  const ConfigMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
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
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/',
              (route) => false,
            );
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
      color: const Color.fromRGBO(144, 238, 144, 0.25),
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
