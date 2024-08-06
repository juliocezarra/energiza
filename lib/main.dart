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
            onPressed: () async {
              // Espera a navegação para a tela de criação/edição de dispositivo
              await Navigator.pushNamed(context, '/create_device');
              // Atualiza a lista de dispositivos após a navegação de volta
              _loadDevices();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: devices.length,
        itemBuilder: (context, index) {
          return DeviceCard(
            device: devices[index],
            onDelete: () {
              _loadDevices(); // Atualiza a lista de dispositivos após a exclusão
            },
          );
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
  final VoidCallback onDelete;

  const DeviceCard({super.key, required this.device, required this.onDelete});

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
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                await database_helper.DatabaseHelper.instance.deleteDevice(widget.device.id!);
                widget.onDelete(); // Chama o callback de exclusão
              },
            ),
          ],
        ),
      ),
    );
  }
}
