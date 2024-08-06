// lib/device.dart
class Device {
  final int? id;
  final String name;
  final String image;
  final double status; // Mudança para double
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
      status: (map['status'] as String).isNotEmpty ? double.parse(map['status']) : 0.0,
      isOn: map['isOn'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'status': status.toString(), // Convertendo de double para String
      'isOn': isOn ? 1 : 0,
    };
  }
}
