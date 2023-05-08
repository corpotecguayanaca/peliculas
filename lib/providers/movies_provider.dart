import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/movie_model.dart';

class PeliculasProvider {
  String _apiKey ='86576607d5f84df06f56e7c21b80b806';
  String _url = 'api.themoviedb.org';
  String _language = 'es-VE';

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
    });

    final respuesta = await http.get(url);

    final decodedData = json.decode(respuesta.body);

    final peliculas = Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }

}