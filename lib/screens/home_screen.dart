import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:tiemblapp/models/earthquake_model.dart';
import 'package:tiemblapp/providers/home_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final List<String> items = [
  'Más reciente primero',
  'Más antiguo primero'
];
String selectedValue = 'Más reciente primero';

  @override
  Widget build(BuildContext context) {

    final homeProvider = Provider.of<HomeProvider>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Últimos sismos registrados'),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: Column(
            children: [
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Ordenar por: ',
                    style: TextStyle(fontWeight: FontWeight.bold),),
                  CustomDropdownButton2(
                    buttonWidth: size.width * 0.5,
                    dropdownWidth: size.width * 0.5,
                    hint: 'Selecciona el orden',
                    dropdownItems: items,
                    value: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value!;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              EarthquakeCards( 
                earthquakes: homeProvider.onDisplayEarthquakes,
                sortValue: selectedValue
              ),
            ],
          )
        ),
      ),
    );
  }
}

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

