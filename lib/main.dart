import 'package:appfirebase/screens/LoginScreen.dart';
import 'package:appfirebase/screens/RegistroScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Inicio());
}

class Inicio extends StatelessWidget {
  const Inicio({super.key});

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
        title: const Text('Bienvenido a Streaming'),
      ),
      body: Cuerpo(context),
    );
  }
}

Widget Cuerpo(BuildContext context){
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
          Icons.home,
          size: 100,
          color: Colors.white,
        ),
        const SizedBox(height: 20),
        const Text(
          "STREAMING",
          style: TextStyle(
            fontSize: 28,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 50),
        BotonLogin(context),
        const SizedBox(height: 50),
        BotonRegistro(context),
      ],
    ),
  );
}

Widget BotonLogin(context){
  return(
    FilledButton(onPressed: (){
      Navigator.push(context, 
      MaterialPageRoute(builder: (context) => const Login())
      );
    }, child:Text("Ir a Login"))
  );
}

Widget BotonRegistro(context){
  return(
    ElevatedButton(
      style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.amber)),
      onPressed: (){
      Navigator.push(context,
       MaterialPageRoute(
        builder: (context) => const Registro()));
    },child: Text("Ir a Registro"))
  );
}
