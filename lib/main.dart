import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Solar Panel App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
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
      image: 'assets/solar_panel.png', // Corrigi o caminho da imagem aqui
      status: '100',
      isOn: false,
    ),
    Device(
      name: 'Lâmpada P1',
      image: 'assets/solar_panel.png',
      status: '50',
      isOn: false,
    ),
    Device(
      name: 'Fita Led J2',
      image: 'assets/solar_panel.png',
      status: '100',
      isOn: false,
    ),
    Device(
      name: 'Lâmpada P1 - 2',
      image: 'assets/solar_panel.png',
      status: '100',
      isOn: false,
    ),
    Device(
      name: 'Lâmpada P1',
      image: 'assets/solar_panel.png',
      status: '50',
      isOn: false,
    ),
    Device(
      name: 'Lâmpada P1',
      image: 'assets/solar_panel.png',
      status: '50',
      isOn: false,
    ),
    Device(
      name: 'Lâmpada P1',
      image: 'assets/solar_panel.png',
      status: '50',
      isOn: false,
    ),
    Device(
      name: 'Lâmpada P1',
      image: 'assets/solar_panel.png',
      status: '50',
      isOn: false,
    ),
    Device(
      name: 'Lâmpada P1',
      image: 'assets/solar_panel.png',
      status: '50',
      isOn: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
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

  const DeviceCard({Key? key, required this.device}) : super(key: key);

  @override
  _DeviceCardState createState() => _DeviceCardState();
}

class _DeviceCardState extends State<DeviceCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Image.asset(widget.device.image),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.device.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Icon(Icons.battery_charging_full),
                      SizedBox(width: 4.0),
                      Text(
                        '${widget.device.status}%',
                        style: TextStyle(fontSize: 14.0),
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
