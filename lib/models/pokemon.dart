class Pokemon {
  String name;
  final int id;
  final String imageUrl;
  List<String> types;

  Pokemon({
    required this.name,
    required this.id,
    required this.imageUrl,
    this.types = const [], // provide a default value
  });

  factory Pokemon.fromJson(Map<String, dynamic> json, int id) {
    return Pokemon(
      name: json['name'],
      id: id,
      imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'imageUrl': imageUrl,
      'types': types.join(', '), // Convertir la lista de tipos a una cadena
    };
  }

  factory Pokemon.fromMap(Map<String, dynamic> map) {
    return Pokemon(
      name: map['name'],
      id: map['id'],
      imageUrl: map['imageUrl'],
      types: (map['types'] as String).split(', '), // Convertir la cadena de tipos a una lista
    );
  }
}