import 'package:app_stre_pro_flutter/screen/Formulario.dart';
import 'package:app_stre_pro_flutter/screen/LoginScreen.dart';
import 'package:app_stre_pro_flutter/screen/RegistroScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Cuerpo(),
    );
  }
}

class Cuerpo extends StatefulWidget {
  const Cuerpo({super.key});

  @override
  State<Cuerpo> createState() => _CuerpoState();
}

class _CuerpoState extends State<Cuerpo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(context),
    );
  }
}

Widget Body(context) {
  return Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/img/f3.jpg'),
        fit: BoxFit.cover,
      ),
    ),
    padding: const EdgeInsets.all(16.0),
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '¡VidiFy!',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors
                  .white, 
            ),
            textAlign: TextAlign.center,
          ),
          const Text(
            '"Tu pantalla, tu contenido, tu elección."',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors
                  .white, 
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16.0),
          LoginButton(context),
          const SizedBox(height: 16.0),
          RegistroButton(context),
          FormuButton(context)
        ],
      ),
    ),
  );
}

Widget LoginButton(context) {
  return ElevatedButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    },
    child: const Text(
      'Iniciar Sesión',
      style: TextStyle(color: Colors.white), // Color del texto
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.black, // Color del botón
    ),
  );
}

Widget RegistroButton(context) {
  return ElevatedButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Registro()),
      );
    },
    child: const Text(
      'Registrarse',
      style: TextStyle(color: Colors.white), // Color del texto blanco
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.black, // Color del botón negro
    ),
  );
}

Widget FormuButton(context) {
  return ElevatedButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Formu()),
      );
    },
    child: const Text(
      'Registrarse',
      style: TextStyle(color: Colors.white), // Color del texto blanco
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.black, // Color del botón negro
    ),
  );
}
