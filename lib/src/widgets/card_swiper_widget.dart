import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:peliculas/src/models/movie_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Pelicula> peliculas;

  const CardSwiper({super.key, required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.only(top: 20.0),
      child: Swiper(
        itemCount: peliculas.length,
        itemBuilder: (context, index) {
          return _tarjeta(context, peliculas[index]);
        },
        layout: SwiperLayout.STACK,
        itemWidth: screenSize.width * 0.7,
        itemHeight: screenSize.height * 0.5,
      ),
    );
  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula) {
    pelicula.uniqueId = '${pelicula.id}-swiper';
    
    final card = Hero(
      tag: pelicula.uniqueId!,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: FadeInImage(
          image: NetworkImage(pelicula.getPosterImg()),
          placeholder: const AssetImage('assets/img/no-image.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'detalle', arguments: pelicula);
      },
      child: card,
    );
  }
}
