import 'dart:convert';

import 'package:http/http.dart' as http;

class Pokemon {
  final int id;
  final String name;
  final String url;
  List<String> types;

  Pokemon({
    required this.id,
    required this.name,
    required this.url,
    this.types = const [],
  });

  factory Pokemon.fromJson(Map<String, dynamic> json, int id) {
    return Pokemon(
      id: id,
      name: json['name'],
      url: json['url'],
    );
  }

  Future<void> fetchDetails() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      types = (data['types'] as List)
          .map((type) => type['type']['name'] as String)
          .toList();
    } else {
      throw Exception('Failed to fetch details');
    }
  }
}
