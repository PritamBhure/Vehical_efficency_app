import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Model/Vehical.dart';
import '../Repository/VehicalRepository.dart';

class VehicleViewModel extends ChangeNotifier {
  final VehicleRepository _repository;
  List<Vehicle> _vehicles = [];
  bool _isLoading = false;
  String? _error;

  VehicleViewModel(this._repository);

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<Vehicle> get vehicles => _vehicles;

  Color getVehicleColor(Vehicle vehicle) {
    final age = DateTime.now().year - vehicle.year;

    if (vehicle.mileage >= 15 && age <= 5) return Colors.green;
    if (vehicle.mileage >= 15 && age > 5) return Colors.amber;
    return Colors.red;
  }

  Future<void> fetchVehicles() async {
    try {
      _isLoading = true;
      notifyListeners();

      final vehiclesStream = _repository.getVehicles();
      vehiclesStream.listen((vehicles) {
        _vehicles = vehicles;
        _error = null;
        _isLoading = false;
        notifyListeners();
      }, onError: (error) {
        _error = error.toString();
        _isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
}