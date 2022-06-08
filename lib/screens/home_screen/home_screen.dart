import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';

import 'package:tiemblapp/providers/home_provider.dart';
import 'package:tiemblapp/screens/home_screen/widgets.dart';

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