import 'package:flutter/material.dart';
import 'package:peliculas/src/models/actor_model.dart';
import 'package:peliculas/src/models/movie_model.dart';
import 'package:peliculas/src/providers/movies_provider.dart';

class PeliculaDetalle extends StatelessWidget {
  const PeliculaDetalle({super.key});

  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula =
        ModalRoute.of(context)!.settings.arguments as Pelicula;

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _crearAppbar(pelicula),
        SliverList(
          delegate: SliverChildListDelegate([
            const SizedBox(
              height: 10.0,
            ),
            _posterTitulo(context, pelicula),
            _descripcion(context, pelicula),
            _crearCasting(context, pelicula),
          ]),
        ),
      ],
    ));
  }

  Widget _crearAppbar(Pelicula pelicula) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title!,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        background: FadeInImage(
          image: NetworkImage(pelicula.getBackdropImg()),
          placeholder: const AssetImage('assets/img/loading.gif'),
          fadeInDuration: const Duration(milliseconds: 200),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitulo(BuildContext context, Pelicula pelicula) {
    double stars = (pelicula.voteAverage! / 2);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
              image: NetworkImage(pelicula.getPosterImg()),
              height: 150.0,
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pelicula.title!,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                pelicula.originalTitle!,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  for (var i = 0; i < stars.toInt(); i++)
                    const Icon(
                      Icons.star,
                      color: Colors.amberAccent,
                    ),
                  if (stars - stars.truncate() >= 0.5)
                    const Icon(
                      Icons.star_half,
                      color: Colors.amberAccent,
                    ),
                  Text(
                    pelicula.voteAverage!.toString(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ))
        ],
      ),
    );
  }

  Widget _descripcion(BuildContext context, Pelicula pelicula) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sinopsis",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 10.0,),
          Container(
            margin: const EdgeInsets.only(left: 10.0),
            child: Text(
              pelicula.overview!,
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearCasting(BuildContext context, Pelicula pelicula) {
    final peliProvider = PeliculasProvider();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            "Cast",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        const SizedBox(height: 10.0,),
        FutureBuilder(
          future: peliProvider.getCast(pelicula.id.toString()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _crearActoresPageView(snapshot.data!);
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ],
    );
  }

  Widget _crearActoresPageView(List<Actor> actores) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        itemCount: actores.length,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1,
        ),
        itemBuilder: (context, index) {
          return _actorCard(context, actores[index]);
        },
      ),
    );
  }

  Widget _actorCard(BuildContext context, Actor actor) {
    return Container(
      margin: const EdgeInsets.only(right: 10.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: const AssetImage('assets/img/no-image.jpg'),
              image: NetworkImage(actor.getFoto()),
              fit: BoxFit.cover,
              height: 150.0,
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Text(
            actor.name!,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
