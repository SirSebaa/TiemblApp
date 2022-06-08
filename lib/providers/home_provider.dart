import 'package:flutter/material.dart';
import 'package:tiemblapp/models/earthquake_model.dart';
import 'package:tiemblapp/services/services.dart';

class HomeProvider extends ChangeNotifier {

  List<Earthquake> onDisplayEarthquakes = [];
  EarthquakeService earthquakeService = EarthquakeService();

  HomeProvider(){
    getOnDisplayEarthquakes();
  }

  getOnDisplayEarthquakes() async{

    final data = await earthquakeService.getEarthquakes();

    if( data != null ){
      onDisplayEarthquakes = data;
    }

    notifyListeners();
  }

}