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

    while( earthquakes.isEmpty ){
      return SizedBox(
        width: size.width,
        height: size.height * 0.4,
        child: const Center(
          child: CircularProgressIndicator()
        )
      );
    }

    if(sortValue == 'Más reciente primero'){
      earthquakes.sort((a, b) => b.fecha.compareTo(a.fecha));
    }
    else if (sortValue == 'Más antiguo primero'){
      earthquakes.sort((a, b) => a.fecha.compareTo(b.fecha));

    }
    return ListView.builder(
      itemCount: earthquakes.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index){
        final earthquake = earthquakes[index];
        return GestureDetector(
          onTap: () => Navigator.pushNamed(context, 'earthquake', arguments: earthquake),
          child: Container(
            decoration: BoxDecoration(
              color: earthquake.magnitudeColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.black,
                width: 1
              )
            ),
            padding: const EdgeInsets.symmetric(vertical: 20),
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 20,),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black,
                      width: 1
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
                                softWrap: false,),
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