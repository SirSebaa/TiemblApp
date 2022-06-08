import 'package:flutter/material.dart';
import 'package:tiemblapp/models/earthquake_model.dart';

class EarthquakeScreen extends StatelessWidget {
  const EarthquakeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // Recibe el argumento enviado desde el HomeScreen y lo trata como
    // un objeto Earthquake.
    final Earthquake earthquake = ModalRoute.of(context)!.settings.arguments as Earthquake;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sismo registrado'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Column(
          children: [
            // Utiliza una imagen guardada en la carpeta assets.
            Image.asset('assets/sismo_pin.png',
              height: size.height * 0.2
            ),
            const SizedBox(height: 20,),
            // Genera la tarjeta con la información completa del sismo seleccionado
            // en la pantalla HomeScreen.
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.black,
                  width: 1
                )
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text('Magnitud: ',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                      Text(earthquake.magnitud,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      const Text('Fecha: ',
                        style: TextStyle(fontWeight: FontWeight.bold),),
                      Text(earthquake.dateFormat),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      const Text('Lugar: ',
                        style: TextStyle(fontWeight: FontWeight.bold),),
                      Text(earthquake.refGeografica),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      const Text('Profundidad: ',
                        style: TextStyle(fontWeight: FontWeight.bold),),
                      Text(earthquake.profundidad),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      const Text('Latitud: ',
                        style: TextStyle(fontWeight: FontWeight.bold),),
                      Text(earthquake.latitud),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      const Text('Longitud: ',
                        style: TextStyle(fontWeight: FontWeight.bold),),
                      Text(earthquake.longitud),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      const Text('Última actualización: ',
                        style: TextStyle(fontWeight: FontWeight.bold),),
                      Text(earthquake.upodateFormat),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}