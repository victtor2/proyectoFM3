import 'package:appfirebase/main.dart';
import 'package:appfirebase/screens/CatalogoScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Login());
}

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
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
      appBar: AppBar(
        title: const Text('LOGIN'),
      ),
      body: Cuerpo(context),
    );
  }
}

Widget Cuerpo(BuildContext context) {
  return Container(
    width: double.infinity, // Para que ocupe todo el ancho disponible
    height: double.infinity, // Para que ocupe toda la altura disponible
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF1D1E33), Color(0xFF111328)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Icon(
          Icons.login, // Cambiado a Icons.login
          size: 100,
          color: Colors.white,
        ),
        const SizedBox(height: 20),
        const Text(
          "BIENVENIDO",
          style: TextStyle(
            fontSize: 28,
            color: Colors.white,
          ),
        ),
        Usuario(),
        Password(),
        const SizedBox(height: 50),
        BotonLogin(context),
      ],
    ),
  );
}

final TextEditingController _correo = TextEditingController();
Widget Usuario() {
  return Container(
    padding: const EdgeInsets.all(20.0),
    child: TextField(
      controller: _correo,
      decoration: InputDecoration(
        hintText: "Ingrese su Correo",
        prefixIcon: Icon(Icons.email),
        filled: true,
        fillColor: Colors.white.withOpacity(0.8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    ),
  );
}

final TextEditingController _contrasenia = TextEditingController();
Widget Password() {
  return Container(
    padding: const EdgeInsets.all(20.0),
    child: TextField(
      controller: _contrasenia,
      obscureText: true,
      decoration: InputDecoration(
        hintText: "Ingrese su Contraseña",
        prefixIcon: Icon(Icons.lock),
        filled: true,
        fillColor: Colors.white.withOpacity(0.8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    ),
  );
}

Widget BotonLogin(context) {
  return (FilledButton(
      onPressed: () {
        login(context);
      },
      child: Text("Iniciar Sesion")));
}

Future<void> login(context) async {
  try {
    if (_correo.text != null) {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _correo.text, password: _contrasenia.text);

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Catalogo()));
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
}
