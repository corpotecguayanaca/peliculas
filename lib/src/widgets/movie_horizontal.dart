import 'package:flutter/material.dart';
import 'package:peliculas/src/models/movie_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  final Function siguentePagina;
  
  MovieHorizontal({
    super.key,
    required this.peliculas,
    required this.siguentePagina,
  });

  final _pageController = PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );


  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200.0) {
        siguentePagina();
      }
    });
    
    return SizedBox(
      height: screenSize.height * 0.22,
      child: PageView(
        pageSnapping: false,
        controller: _pageController,
        children: _tarjetas(context),
      ),
    );
  }
  
  List<Widget> _tarjetas(BuildContext context) {
    return peliculas.map((pelicula) {
      return Container(
        margin: const EdgeInsets.only(right: 10.0),
        child: Column(
          children: [
            ClipRRect(              
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: const AssetImage('assets/img/no-image.jpg'), 
                image: NetworkImage(pelicula.getPosterImg()),
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 5.0,),
            Text(
              pelicula.title!,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      );
    }).toList();
  }
}