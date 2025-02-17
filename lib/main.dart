import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Repository/VehicalRepository.dart';
import 'View/vehical_list.dart';
import 'ViewModel/VehicalViewModel.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => VehicleViewModel(VehicleRepository()),
        ),
      ],
      child: MaterialApp(
        title: 'Eco Vehicles',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const VehicleListView(),
      ),
    );
  }
}