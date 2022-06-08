import 'package:flutter/material.dart';
import 'package:tiemblapp/models/earthquake_model.dart';
import 'package:tiemblapp/services/services.dart';

class HomeProvider extends ChangeNotifier {

  List<Earthquake> onDisplayEarthquakes = [];
  EarthquakeService earthquakeService = EarthquakeService();

  // Cuando se crea la instancia del provider se ejecuta
  // la función señalada.
  HomeProvider(){
    getOnDisplayEarthquakes();
  }

  // Esta función llama al service para traer la data
  // y asignarla a la variable que se usará en otra sección
  // de la aplicación.
  getOnDisplayEarthquakes() async{

    final data = await earthquakeService.getEarthquakes();

    if( data != null ){
      onDisplayEarthquakes = data;
    }

    // Notifica a los widgets que utilizan alguna de
    // las variables modificadas para que se refresquen.
    notifyListeners();
  }

}