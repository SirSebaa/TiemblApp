import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:simple_moment/simple_moment.dart';

// Aquí se crea un modelo en base a la data que se espera recibir.
// Hay que definir bien cuáles datos vendrán siempre y cuales son
// opcionales, hay que tener cuidado con los opcionales para evitar
// referenciar valores nulos.
class Earthquake {
    Earthquake({
        required this.fecha,
        required this.latitud,
        required this.longitud,
        required this.profundidad,
        required this.magnitud,
        required this.agencia,
        required this.refGeografica,
        required this.fechaUpdate,
    });

    final DateTime fecha;
    final String latitud;
    final String longitud;
    final String profundidad;
    final String magnitud;
    final String agencia;
    final String refGeografica;
    final DateTime fechaUpdate;
    
    // Aqui se crean getters para facilitar el procesamiento y uso
    // de los datos en otras secciones de la aplicación.
    get dateFormat {
      final dateFormat = Moment.fromDateTime(fecha);
      return dateFormat.format("yyyy-MM-dd hh:mm");
    }

    get upodateFormat {
      final dateFormat = Moment.fromDateTime(fechaUpdate);
      return dateFormat.format("yyyy-MM-dd hh:mm");
    }

    get magnitudeColor {
      try {
        final split = magnitud.split(' ');
        final magnitude = double.parse(split[0]);
        if( magnitude < 3 ){
          return Colors.green[300];
        }
        else if (magnitude < 4 ){
          return Colors.orange[300];
        }
        else {
          return Colors.red[300];
        }
      } catch (e) {
        return Colors.grey[300];
      }
    }

    //  .fromJson y .fromMap sirven para crear objetos de este modelo
    //  desde un json o un mapa, hay que tener cuidado con posibles valores
    //  nulos cuando sea necesario.
    factory Earthquake.fromJson(String str) => Earthquake.fromMap(json.decode(str));

    factory Earthquake.fromMap(Map<String, dynamic> json) => Earthquake(
        fecha: DateTime.parse(json["Fecha"]),
        latitud: json["Latitud"],
        longitud: json["Longitud"],
        profundidad: json["Profundidad"],
        magnitud: json["Magnitud"],
        agencia:json["Agencia"],
        refGeografica: json["RefGeografica"],
        fechaUpdate: DateTime.parse(json["FechaUpdate"]),
    );

    // toMap sirve para crear un mapa desde un objeto de este modelo.
    // El proceso contrario a .fromMap
    Map<String, dynamic> toMap() => {
        "Fecha": fecha.toIso8601String(),
        "Latitud": latitud,
        "Longitud": longitud,
        "Profundidad": profundidad,
        "Magnitud": magnitud,
        "Agencia": agencia,
        "RefGeografica": refGeografica,
        "FechaUpdate": fechaUpdate.toIso8601String(),
    };
}
