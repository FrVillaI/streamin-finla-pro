import 'package:app_stre_pro_flutter/screen/ListConScreen.dart';
import 'package:app_stre_pro_flutter/screen/PerfilScreen.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(Contenidos());
}

class Contenidos extends StatelessWidget {
  const Contenidos({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int indice=0;
  @override
  Widget build(BuildContext context) {
    /////////////////////////////////
    List <Widget> screens =[
      const ListaCon(),
     Perfil()
    ];
    //////////////////////////////
    return Scaffold(
      body:  screens[indice],
      //////////////////////////////////////////////////////////////////
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indice,
        onTap: ( valor ) {
          setState(() {
            indice = valor;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart_outlined), label: "Peliculas"),
          BottomNavigationBarItem(icon: Icon(Icons.sensor_occupied_sharp), label: "Perfil"),
        ],
        ),
        //////////////////////////////////////////////////////////
    );
  }
}
