import 'package:flutter/material.dart';

class NotificationService {

  // Se crea la key que se utilizará en el scaffoldMessengerKey del MaterialApp
  static GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>();

  // Esta función sirve para mostrar un snackbar desde cualquier
  // parte de la app. La key de ScaffoldMessengerState permite
  // hacer esto sin importar el contexto en el que se encuentre.
  static showSnackbar( String message ) {

    final snackBar = SnackBar(
      content: Text( message )
    );

    messengerKey.currentState!.showSnackBar(snackBar);
  }
}