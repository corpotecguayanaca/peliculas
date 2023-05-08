import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:peliculas/src/models/movie_model.dart';

class CardSwiper extends StatelessWidget {
  

  final List<Pelicula> peliculas;

  const CardSwiper({
    super.key , 
    required this.peliculas
  });

  @override
  Widget build(BuildContext context) {
    
    final _screenSize = MediaQuery.of(context).size;
        
    return Container(
      padding: const EdgeInsets.only(top: 20.0),
      child: Swiper(
        itemCount: peliculas.length,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(peliculas[index].getPosterImg()),
              placeholder: const AssetImage('assets/img/no-image.jpg'),
              fit: BoxFit.cover,
            ),
          );
        },
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height *0.5,
      ),
    );;
  }
}