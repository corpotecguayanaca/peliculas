import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/movie_model.dart';

class PeliculasProvider {
  final _apiKey ='86576607d5f84df06f56e7c21b80b806';
  final _url = 'api.themoviedb.org';
  final _language = 'es-VE';
  int _popularesPage = 0;
  List<Pelicula> _populares = [];
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

}