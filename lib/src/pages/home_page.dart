
import 'package:flutter/material.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
  final peliculasProvider = PeliculasProvider();
  
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Peliculas en cines"),
        backgroundColor: Colors.indigoAccent,
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: const Icon(Icons.search))
        ],
      ),
      body: Container(
        child: Column(
          children: [
            _swiperTarjetas(),
            // _footer(),
          ],
        ),
      ),
    );
  }
  
  Widget _swiperTarjetas() {
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (context, snapshot) {
        if (snapshot.hasData){
          return CardSwiper(
            peliculas: snapshot.data!,
          );
        } else {
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator(),
            )
          );
        }
        
      },  
    );
  }
  
  // Widget _footer() {
  //   return Container(
  //     width: double.infinity,
  //     child: Column(
  //       children: [
  //         Text("Peliculas populares", style: Theme,),
  //       ],
  //     ),
  //   );
  // }
}