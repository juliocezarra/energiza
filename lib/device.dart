// lib/device.dart
class Device {
  final int? id;
  final String name;
  final String image;
  final double status; // Alterado para double
  bool isOn;

  Device({
    this.id,
    required this.name,
    required this.image,
    required this.status,
    required this.isOn,
  });

  factory Device.fromMap(Map<String, dynamic> map) {
    return Device(
      id: map['id'],
      name: map['name'],
      image: map['image'],
      status: map['status']?.toDouble() ?? 0.0, // Acessa como double
      isOn: map['isOn'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'status': status, // Já é double
      'isOn': isOn ? 1 : 0,
    };
  }
}
