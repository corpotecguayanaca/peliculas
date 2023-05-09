import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/movies_provider.dart';

class DataSearch extends SearchDelegate {
  final peliculasProvider = PeliculasProvider();
  String seleccion = '';
  @override
  List<Widget>? buildActions(BuildContext context) {
    // Acciones del app bar
    return [
      IconButton(
        icon: const Icon(Icons.clear), 
        onPressed: () {
          query = '';
        }),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // Icono a la izquierda del app bar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que se van a mostrar
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Sugerencias que aparecen cuando el usuario escribe
    if(query.isEmpty){
      return Container();
    }

    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: ((context, snapshot) {
        if(snapshot.hasData){
          final peliculas = snapshot.data!;
          return ListView.builder(
            itemCount: peliculas.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(peliculas[index].getPosterImg()),
                  placeholder: const AssetImage('assets/img/no-image.jpg'),
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
                title: Text(peliculas[index].title!),
                subtitle: Text(peliculas[index].originalTitle!),
                onTap: () {
                  close(context, null);
                  peliculas[index].uniqueId = '';
                  Navigator.pushNamed(
                    context, "detalle",
                    arguments: peliculas[index],
                  );
                },
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      })
    );
    
  }

}