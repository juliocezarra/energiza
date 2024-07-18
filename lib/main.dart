import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Solar Panel App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Device> devices = [
    Device(
      name: 'Placa Solar N09',
      image: 'assets/solar_panel.png',
      status: '100',
      isOn: true,
    ),
    Device(
      name: 'Placa Solar N09 - 2',
      image: 'assets/solar_panel.png',
      status: '100',
      isOn: false,
    ),
    Device(
      name: 'Lâmpada P1',
      image: 'assets/pngwing 4.png',
      status: '50',
      isOn: false,
    ),
    Device(
      name: 'Fita Led J2',
      image: 'assets/pngwing 5.png',
      status: '100',
      isOn: false,
    ),
    Device(
      name: 'Lâmpada P1 - 2',
      image: 'assets/pngwing 4.png',
      status: '100',
      isOn: false,
    ),
    Device(
      name: 'Lâmpada P1',
      image: 'assets/pngwing 4.png',
      status: '50',
      isOn: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
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

class Device {
  final String name;
  final String image;
  final String status;
  bool isOn;

  Device({
    required this.name,
    required this.image,
    required this.status,
    required this.isOn,
  });
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
        color: Colors.green.withOpacity(0.2), // Definindo a cor de fundo com baixa opacidade
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
                widget.device.isOn ? Icons.power_settings_new : Icons.power_off,
                color: widget.device.isOn ? Colors.green : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
