import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/actor_model.dart';
import 'package:peliculas/src/models/genero_model.dart';
import 'package:peliculas/src/models/movie_model.dart';

class PeliculasProvider {
  final _apiKey ='86576607d5f84df06f56e7c21b80b806';
  final _url = 'api.themoviedb.org';
  final _language = 'es-VE';
  int _popularesPage = 0;
  final List<Pelicula> _populares = [];
  bool _cargando = false;

  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink => _popularesStreamController.add;

  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  void disposeStreams() {
    _popularesStreamController.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final respuesta = await http.get(url);

    final decodedData = json.decode(respuesta.body);

    final peliculas = Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }
  
  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key' : _apiKey,
      'language': _language,
    });

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    if(_cargando) return [];
    
    _popularesPage++;

    _cargando = true;
    
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key' : _apiKey,
      'language': _language,
      'page'    : _popularesPage.toString(),
    });

    final resp = await _procesarRespuesta(url);

    _populares.addAll(resp);
    popularesSink(_populares);

    _cargando = false;
    return resp;
  }

  Future<List<Actor>> getCast (String peliId) async {
    final url = Uri.https(_url, '3/movie/$peliId/credits', {
      'api_key' : _apiKey,
      'language': _language,
    });

    final respuesta = await http.get(url);
    final decodedData = json.decode(respuesta.body);

    final cast = Cast.fromJsonList(decodedData['cast']);

    return cast.actores;
  }

  Future<List<Genero>> getGeneros (String peliId) async {
    final url = Uri.https(_url, '3/movie/$peliId', {
      'api_key' : _apiKey,
      'language': _language,
    });

    final respuesta = await http.get(url);
    final decodedData = json.decode(respuesta.body);

    final genres = Generos.fromJsonList(decodedData['genres']);

    return genres.generos;
  }

  Future<List<Pelicula>> buscarPelicula(String query) async {
    final url = Uri.https(_url, '3/search/movie', {
      'api_key' : _apiKey,
      'language': _language,
      'query': query,
    });

    return await _procesarRespuesta(url);
  }
}