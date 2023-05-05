import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class CardSwiper extends StatelessWidget {
  

  final List<dynamic> imagenes;

  const CardSwiper({
    super.key , 
    required this.imagenes
  });

  @override
  Widget build(BuildContext context) {
    
    final _screenSize = MediaQuery.of(context).size;
        
    return Container(
      padding: const EdgeInsets.only(top: 20.0),
      child: Swiper(
        itemCount: imagenes.length,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.network(
              "http://via.placeholder.com/350x150", 
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