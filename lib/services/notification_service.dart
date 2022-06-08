import 'package:flutter/material.dart';

class NotificationService {

  static GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackbar( String message ) {

    final snackBar = SnackBar(
      content: Text( message )
    );

    messengerKey.currentState!.showSnackBar(snackBar);
  }
}