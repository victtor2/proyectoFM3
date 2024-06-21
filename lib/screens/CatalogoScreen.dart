import 'package:appfirebase/main.dart';
import 'package:appfirebase/screens/FormularioScreen.dart';
import 'package:appfirebase/screens/video_player_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  runApp(Catalogo());
}

class Catalogo extends StatelessWidget {
  const Catalogo({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Lista(),
    );
  }
}

//////////////////////////////////////////////////////
class Lista extends StatefulWidget {
  @override
  _ListaState createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  List<Map<dynamic, dynamic>> pelisList = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    
    DatabaseReference pelisRef = FirebaseDatabase.instance.ref('pelis');
    pelisRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      updateEstrenosList(data);
    });
  }

  void updateEstrenosList(dynamic data) {
    List<Map<dynamic, dynamic>> tempList = [];

    data.forEach((key, element) {
      //////////////////////////////////////////
      /// Se asigna la clave y valor a la lista temporal
      //////////////////////////////////////////
      tempList.add({
        "id": element['id'],
        "nombre": element['nombre'],
        "resena": element['resena'],
        "link": element['link'], 
      });
    });

    setState(() {
      pelisList = tempList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Cuerpo()
     
    );
  }

  Widget Cuerpo() {
    return ListView.builder(
      itemCount: pelisList.length,
      itemBuilder: (context, index) {
        return ListTile(
          //////////////////////////////////////
          /// Se manda a imprimir los valores solicitados
          //////////////////////////////////////
          title: Text('${pelisList[index]["id"]}'),
          subtitle: Text('${pelisList[index]["nombre"]}'),
          /*resena: Text('${pelisList[index]["resena"]}'),*/
          onTap: () {
            // Navegar a la pantalla del reproductor de video
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VideoPlayerScreen(videoUrl: pelisList[index]["link"]),
              ),
            );
          },
        );
      },
    );
  }
}


/*class Catalogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Catalog',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MovieCatalogScreen(),
    );
  }
}

class MovieCatalogScreen extends StatelessWidget {
  final List<Movie> movies = [
    Movie(
      title: 'Intensamente2',
      description: 'Seres diferentes para cada caracter',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTx4V-3tetOO0PQN0n-XlAarm7d1M9-Iaf7Ow&s',
    ),
    
    Movie(
      title: 'TOP GUN 3',
      description: 'Maverick do it again!',
      imageUrl: 'https://cdn.avpasion.com/wp-content/uploads/2022/08/ver-top-gun-maverick-online.jpg',
    ),
    // Añade más películas según sea necesario
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tu Catalogo de Peliculas'),
        actions: [
          BotonNueva(context), 
        ],
      ),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return MovieCard(movie: movie);
        },
      ),
    );
  }
}

class Movie {
  final String title;
  final String description;
  final String imageUrl;

  Movie({required this.title, required this.description, required this.imageUrl});
}

class MovieCard extends StatelessWidget {
  final Movie movie;

  MovieCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl: movie.imageUrl,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(movie.description),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


Widget BotonNueva(context){
  return(
    FilledButton(onPressed: (){
      Navigator.push(context, 
      MaterialPageRoute(builder: (context) => const Formulario())
      );
    }, child:Text("Agregar Estreno"))
  );
}*/