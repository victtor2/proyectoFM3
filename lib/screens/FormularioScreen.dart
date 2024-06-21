import 'package:appfirebase/main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(Formulario());
}

class Formulario extends StatelessWidget {
  const Formulario({super.key});

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
        title: const Text('Nuevo'),
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
        const SizedBox(height: 20),
        const Text(
          "ESTRENO",
          style: TextStyle(
            fontSize: 28,
            color: Colors.white,
          ),
        ),
        CampoId(),
        CampoPelicula(),
        CampoResenia(),
        CampoLink(),
        const SizedBox(height: 50),
        BotonGuardar(context),
        
      ],
    ),
  );
}

final TextEditingController _id = TextEditingController();
Widget CampoId() {
  return Container(
    padding: const EdgeInsets.all(20.0),
    child: TextField(
      controller: _id,
      decoration: InputDecoration(
        hintText: "Id del Estreno",
        filled: true,
        fillColor: Colors.white.withOpacity(0.8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    ),
  );
}

final TextEditingController _nombre = TextEditingController();
Widget CampoPelicula() {
  return Container(
    padding: const EdgeInsets.all(20.0),
    child: TextField(
      controller: _nombre,
      decoration: InputDecoration(
        hintText: "Nombre del Estreno",
        filled: true,
        fillColor: Colors.white.withOpacity(0.8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    ),
  );
}

final TextEditingController _resenia = TextEditingController();
Widget CampoResenia() {
  return Container(
    padding: const EdgeInsets.all(20.0),
    child: TextField(
      controller: _resenia,
      decoration: InputDecoration(
        hintText: "Resena del Estreno",
        filled: true,
        fillColor: Colors.white.withOpacity(0.8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    ),
  );
}

final TextEditingController _link = TextEditingController();
Widget CampoLink() {
  return Container(
    padding: const EdgeInsets.all(20.0),
    child: TextField(
      controller: _link,
      decoration: InputDecoration(
        hintText: "Resena del Estreno",
        filled: true,
        fillColor: Colors.white.withOpacity(0.8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    ),
  );
}


Widget BotonGuardar(context){
  return(
    FilledButton(onPressed: (){
      
      guardar(context);

    }, child:Text("Guardar Estreno"))
  );
}

Future<void> guardar(context) async {
  DatabaseReference ref = FirebaseDatabase.instance.ref("pelis/"+_id.text);

await ref.set({
  "id": _id.text,
  "nombre": _nombre.text,
  "resena": _resenia.text,
  "link": _link.text
  
});
}