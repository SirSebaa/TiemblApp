import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:tiemblapp/models/earthquake_model.dart';
import 'package:tiemblapp/services/services.dart';

class EarthquakeService {

  // https://api.gael.cloud/general/public/sismos
  final _baseUrl = 'api.gael.cloud';

  Future<List<Earthquake>?> getEarthquakes() async{
    final url = Uri.https(_baseUrl, '/general/public/sismos');
    try {
      final resp = await http.get(url);
      final List<dynamic> decodedResp = json.decode(resp.body);

      List<Earthquake> earthquakes = decodedResp
                              .map((event) => Earthquake.fromMap(event))
                              .toList();
      return earthquakes;
    }
    catch ( e ) {
      if( e is TimeoutException) {
        NotificationService.showSnackbar('Tenemos problemas para conectarnos. Asegúrese de que tiene conexión a internet.');
        return null;
      }
      else if ( e is SocketException) {
        NotificationService.showSnackbar('Tenemos problemas para conectarnos. Asegúrese de que tiene conexión a internet.');
        return null;
      }
      else{
        NotificationService.showSnackbar('Error al procesar la solicitud. Código 001');
        print(e);
        return null;
      }
    }
  }
}