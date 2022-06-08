import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:tiemblapp/providers/home_provider.dart';
import 'package:tiemblapp/screens/screens.dart';
import 'package:tiemblapp/services/services.dart';

void main() {
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Aquí se agregan los providers que se usarán en el proyecto.
        // Para agregar más, solo sepáralos con una coma (,).
        ChangeNotifierProvider(create: ( _ ) => HomeProvider())
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Aquí se configuran algunas cosas básicas de la aplicación
    // como el título, las rutas o los colores del tema.
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TiemblApp',
      initialRoute: 'home',
      routes: {
        'home'      : ( _ ) => const HomeScreen(),
        'earthquake': ( _ ) => const EarthquakeScreen(),
      },
      scaffoldMessengerKey: NotificationService.messengerKey,
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          color: Colors.red
        ),
        scaffoldBackgroundColor: Colors.grey[200],
        primaryColor: Colors.orange
      ),
    );
  }
}