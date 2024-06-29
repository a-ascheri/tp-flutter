class Pokemon {
  final String name;
  final String url;
  int id;
  String imageUrl;
  List<String> types = [];

  Pokemon({required this.name, required this.url, required this.id, required this.imageUrl});

  factory Pokemon.fromJson(Map<String, dynamic> json, int id) {
    return Pokemon(
      name: json['name'],
      url: json['url'],
      id: id,
      imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png',
    );
  }
}