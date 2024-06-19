import 'package:app_stre_pro_flutter/screen/Contenidos.dart';
import 'package:app_stre_pro_flutter/screen/ListConScreen.dart';
import 'package:app_stre_pro_flutter/screen/RegistroScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Login());
}

class Login extends StatelessWidget {
  const Login({super.key});

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
          color: Colors.white, // Fondo del cuadro
          borderRadius: BorderRadius.circular(12.0), // Bordes redondeados
        ),
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CorreoField(),
              const SizedBox(height: 16.0),
              ContraseniaField(),
              const SizedBox(height: 16.0),
              LoginButton(context),
              const SizedBox(height: 16.0),
              RegistroButton(context),
            ],
          ),
        ),
      ),
    ),
  );
}

final TextEditingController _correoController = TextEditingController();
final TextEditingController _contraseniaController = TextEditingController();

Widget CorreoField() {
  return TextFormField(
    controller: _correoController,
    decoration: const InputDecoration(
      hintText: 'Ingresar el correo electrónico',
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
      hintText: 'Ingresar la contraseña',
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

Widget LoginButton(context) {
  return ElevatedButton(
    onPressed: () {
      login(context);
    },
    child: const Text(
      'Iniciar Sesión',
      style: TextStyle(color: Colors.white), 
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.black, 
    ),
  );
}

Widget RegistroButton(context) {
  return ElevatedButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Registro()),
      );
    },
    child: const Text(
      'Registrarse',
      style: TextStyle(color: Colors.white),  
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.black, 
    ),
  );
}

void AlertaLogin(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Credenciales Correctas'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListaCon()),
              );
            },
            child: const Text('Ver Pliculas'),
          ),
        ],
      );
    },
  );
}

Future<void> login(BuildContext context) async {
  try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _correoController.text,
      password: _contraseniaController.text
    );
    // Si el inicio de sesión es exitoso, mostrar el diálogo
    AlertaLogin(context);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
}
