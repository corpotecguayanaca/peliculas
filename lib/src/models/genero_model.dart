class Generos {
  List<Genero> generos = [];

  Generos.fromJsonList( List<dynamic>? jsonList ) {
    if (jsonList == null ) return;

    for (var element in jsonList) {
      final genero = Genero.fromJsonMap(element);
      generos.add(genero);
    }
  }
}

class Genero {
  int? id;
  String? name;

  Genero({
    this.id,
    this.name,
  });

  Genero.fromJsonMap(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }
}