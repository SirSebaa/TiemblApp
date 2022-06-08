import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:simple_moment/simple_moment.dart';

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

    factory Earthquake.fromJson(String str) => Earthquake.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

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
