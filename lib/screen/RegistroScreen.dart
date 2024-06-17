import 'package:app_stre_pro_flutter/screen/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Registro());
}

class Registro extends StatelessWidget {
  const Registro({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Cuerpo(context),
    );
  }
}

Widget Cuerpo(context) {
  return Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/img/f3.jpg'),
        fit: BoxFit.cover,
      ),
    ),
    child: Center(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white, // Fondo blanco del cuadro
          borderRadius: BorderRadius.circular(12.0), // Bordes redondeados
        ),
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              NombreField(),
              const SizedBox(height: 16.0),
              EdadField(),
              const SizedBox(height: 16.0),
              CorreoField(),
              const SizedBox(height: 16.0),
              ContraseniaField(),
              const SizedBox(height: 16.0),
              RegistroButton(context),
              const SizedBox(height: 16.0),
              LoginButton(context),
            ],
          ),
        ),
      ),
    ),
  );
}

final TextEditingController _nombreController = TextEditingController();
final TextEditingController _edadController = TextEditingController();
final TextEditingController _correoController = TextEditingController();
final TextEditingController _contraseniaController = TextEditingController();

Widget NombreField() {
  return TextFormField(
    controller: _nombreController,
    decoration: const InputDecoration(
      hintText: "Ingresar su nombre",
      fillColor: Colors.white,
      filled: true,
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Por favor ingrese su nombre';
      }
      return null;
    },
  );
}

Widget EdadField() {
  return TextFormField(
    controller: _edadController,
    decoration: const InputDecoration(
      hintText: "Ingresar la edad",
      fillColor: Colors.white,
      filled: true,
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Por favor ingrese su edad';
      }
      return null;
    },
  );
}

Widget CorreoField() {
  return TextFormField(
    controller: _correoController,
    decoration: const InputDecoration(
      hintText: "Ingresar el correo electrónico",
      fillColor: Colors.white,
      filled: true,
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Por favor ingrese su correo';
      }
      return null;
    },
  );
}

Widget ContraseniaField() {
  return TextFormField(
    controller: _contraseniaController,
    decoration: const InputDecoration(
      hintText: "Ingresar la contraseña",
      fillColor: Colors.white,
      filled: true,
    ),
    obscureText: true,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Por favor ingrese su contraseña';
      }
      return null;
    },
  );
}


Widget RegistroButton(context) {
  return ElevatedButton(
    onPressed: () {
      crearUser(context);
    },
    child: const Text(
      'Registrarse',
      style: TextStyle(color: Colors.white), // Color del texto 
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.black, // Color del botón 
    ),
  );
}

void RegistroAterla(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Registro Exitoso"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
              );
            },
            child: const Text("Iniciar sesion"),
          ),
        ],
      );
    },
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

Future<void> crearUser(context) async {
  try {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _correoController.text,
      password: _contraseniaController.text,
    );
    guardarUser();
    RegistroAterla(context);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
}

Future<void> guardarUser() async {
  DatabaseReference ref = FirebaseDatabase.instance.ref("users/").push();
  String userId = ref.key!;
  await ref.set({
    "id": userId,
    "nombre": _nombreController.text,
    "edad": _edadController.text,
    "correo": _correoController.text
  });
}
