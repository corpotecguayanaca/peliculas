import 'package:flutter/material.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  final peliculasProvider = PeliculasProvider();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    peliculasProvider.getPopulares();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Peliculas en cines"),
        backgroundColor: Colors.indigoAccent,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _swiperTarjetas(),
            _footer(context),
          ],
        ),
      ),
    );
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(
            peliculas: snapshot.data!,
          );
        } else {
          return const SizedBox(
              height: 400.0,
              child: Center(
                child: CircularProgressIndicator(),
              ));
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              "Peliculas populares",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(
                  peliculas: snapshot.data!,
                  siguentePagina: peliculasProvider.getPopulares,
                );
              } else {
                return const SizedBox(
                    height: 15.0,
                    child: Center(
                      child: Center(child: CircularProgressIndicator()),
                    ));
              }
            },
          ),
        ],
      ),
    );
  }
}
