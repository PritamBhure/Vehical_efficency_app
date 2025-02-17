import 'package:cloud_firestore/cloud_firestore.dart';
import '../Model/Vehical.dart';

class VehicleRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Vehicle>> getVehicles() {
    return _firestore.collection('vehicles').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Vehicle.fromFirestore(doc)).toList());
  }
}