import 'package:flutter/material.dart';
import 'screens/bad_home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Fea',
      debugShowCheckedModeBanner:
          false, // Ocultar etiqueta debug para que se vea más "pro" dentro de lo feo
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.brown,
        ), // Color aburrido
        useMaterial3: true,
      ),
      home: const BadHomeScreen(),
    );
  }
}
