import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mini_commander/data/implementations/local_implementation/local_system_operation_provider.dart';
import 'package:flutter_mini_commander/presentation/screens/main_screen/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Mini Commander',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: RepositoryProvider(
        create: (context) => LocalSystemOperationProvider(),
        lazy: false,
        child: const MainScreen(),
      ),
    );
  }
}
