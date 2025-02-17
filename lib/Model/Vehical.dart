
import 'package:cloud_firestore/cloud_firestore.dart';

class Vehicle {
  final String id;
  final String name;
  final int mileage;
  final int year;

  Vehicle({
    required this.id,
    required this.name,
    required this.mileage,
    required this.year,
  });

  factory Vehicle.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Vehicle(
      id: doc.id,
      name: data['name'] ?? '',
      mileage: data['mileage']?.toInt() ?? 0,
      year: data['year']?.toInt() ?? 0,
    );
  }
}