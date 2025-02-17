import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ViewModel/VehicalViewModel.dart';

class VehicleListView extends StatefulWidget {
  const VehicleListView({super.key});

  @override
  State<VehicleListView> createState() => _VehicleListViewState();
}

class _VehicleListViewState extends State<VehicleListView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<VehicleViewModel>(context, listen: false).fetchVehicles();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<VehicleViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Eco-Friendly Vehicles')),
      body: _buildBody(viewModel),
      floatingActionButton: FloatingActionButton(
        onPressed: () => viewModel.fetchVehicles(),
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildBody(VehicleViewModel viewModel) {
    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (viewModel.error != null) {
      return Center(child: Text('Error: ${viewModel.error}'));
    }

    if (viewModel.vehicles.isEmpty) {
      return const Center(child: Text('No vehicles found'));
    }

    return ListView.builder(
      itemCount: viewModel.vehicles.length,
      itemBuilder: (context, index) {
        final vehicle = viewModel.vehicles[index];
        return ListTile(
          title: Text(vehicle.name),
          subtitle: Text('${vehicle.mileage} km/l • ${vehicle.year}'),
          tileColor: viewModel.getVehicleColor(vehicle),
          trailing: const Icon(Icons.arrow_forward),
        );
      },
    );
  }
}