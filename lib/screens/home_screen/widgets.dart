import 'package:flutter/material.dart';

import '../../models/earthquake_model.dart';

class EarthquakeCards extends StatelessWidget {

  final List<Earthquake> earthquakes;
  final String sortValue;

  const EarthquakeCards({ 
    Key? key,
    required this.earthquakes,
    required this.sortValue
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    // Muestra un círculo de estilo "cargando"
    // mientras el provider consigue la data.
    while( earthquakes.isEmpty ){
      return SizedBox(
        width: size.width,
        height: size.height * 0.4,
        child: const Center(
          child: CircularProgressIndicator()
        )
      );
    }

    // Ordena la data por fecha dependiendo de la opción
    // seleccionada en el dropdown del HomeScreen
    if(sortValue == 'Más reciente primero'){
      earthquakes.sort((a, b) => b.fecha.compareTo(a.fecha));
    }
    else if (sortValue == 'Más antiguo primero'){
      earthquakes.sort((a, b) => a.fecha.compareTo(b.fecha));

    }

    // Este builder genera tarjeta con los datos de cada item
    // que trae el provider y las ordena verticalmente.
    return ListView.builder(
      itemCount: earthquakes.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index){
        final earthquake = earthquakes[index];
        return GestureDetector(
          // Se detecta el gesto de "tap" para navegar a la pantalla EarthquakeScreen
          // enviando el objeto Earthquake de la tarjeta seleccionada.
          onTap: () => Navigator.pushNamed(context, 'earthquake', arguments: earthquake),
          child: Container(
            decoration: BoxDecoration(
              // Se utiliza un getter del modelo Earthquake que devuelve un color
              // dependiendo del número de la magnitud.
              color: earthquake.magnitudeColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.black,
                width: 1
              )
            ),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 20,),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black,
                      width: 0
                    )
                  ),
                  child: Column(
                    children: [
                      const Text('Magnitud',
                        style: TextStyle(fontWeight: FontWeight.bold,)),
                      const SizedBox(height: 10,),
                      Text(earthquake.magnitud,
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    ],
                  )
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text('Fecha: ',
                              style: TextStyle(fontWeight: FontWeight.bold),),
                            // Se utiliza un getter del modelo Earthquake que retorna
                            // la fecha en un formato más amigable.
                            Text(earthquake.dateFormat),
                          ],
                        ),
                        const SizedBox(height: 5,),
                        Row(
                          children: [
                            const Text('Lugar: ',
                            style: TextStyle(fontWeight: FontWeight.bold),),
                            Expanded(
                              child: Text(earthquake.refGeografica,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: false,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        const Text('Presione para ver más...',
                          style: TextStyle(fontSize: 14, color: Colors.black),)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}