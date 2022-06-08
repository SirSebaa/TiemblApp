import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:tiemblapp/models/earthquake_model.dart';
import 'package:tiemblapp/services/services.dart';

class EarthquakeService {

  // Se guarda la base de la url con la que se trabajará.
  final _baseUrl = 'api.gael.cloud';

  Future<List<Earthquake>?> getEarthquakes() async{
    // Se crea el objeto de tipo Uri y se le agrega la dirección específica
    // de la url hacia donde apuntará la petición.
    final url = Uri.https(_baseUrl, '/general/public/sismos');
    try {
      // Se hace la petición con el método deseado (en este caso GET)
      // y se decodifica el json obtenido.
      final resp = await http.get(url);
      final List<dynamic> decodedResp = json.decode(resp.body);

      // Se genera una lista de objetos de tipo Earthquake para que sea
      // más cómodo de manipular en donde se necesite.
      List<Earthquake> earthquakes = decodedResp
                              .map((event) => Earthquake.fromMap(event))
                              .toList();
      return earthquakes;
    }
    // Se capturan las excepciones y se muestra una notificación al usuario.
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