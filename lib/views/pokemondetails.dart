import 'package:flutter/material.dart';

class PokemonDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> pokemon;

  PokemonDetailsScreen({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 184, 11, 11),
                Color.fromRGBO(255, 20, 16, 1),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(2.5),
          child: Container(
            height: 2.5,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 123, 123, 123),
                  Colors.black,
                  Color.fromARGB(255, 123, 123, 123),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Colors.red,
              Colors.white,
            ],
            center: Alignment.center,
            radius: 0.35,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 5), // Separación de 5 px
            SizedBox(
              height: 90,  // Ajusta el tamaño según sea necesario
              width: double.infinity,
              child: Image.asset(
                'poke_background.png',
                fit: BoxFit.contain,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 275,  // Tamaño ajustado
                    width: 275,   // Tamaño ajustado
                    child: FittedBox(
                      child: Image.network(
                        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${pokemon['id']}.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),  // Fondo semitransparente
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 20.0,
                          left: -5.0,
                          child: Image.asset(
                            'pokeopen.png',
                            width: 45,
                            height: 100,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50.0), // Añade espacio a la izquierda de la columna
                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 147, 152, 160).withOpacity(0.1), // Fondo azul claro
                              border: Border.all(color: const Color.fromARGB(255, 156, 164, 178)), // Borde azul
                              borderRadius: BorderRadius.circular(20), // Bordes redondeados
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildDetailRow('Name', capitalize(pokemon['name'])), // Detalle del nombre con la primera letra en mayúscula
                                SizedBox(height: 0), // Espaciado de 20 px
                                _buildDetailRow('ID', pokemon['id'].toString()),
                                SizedBox(height: 0), // Espaciado de 20 px
                                _buildDetailRow('Types', pokemon['types'].map((type) => capitalize(type)).join(', ')), // Detalle del tipo con la primera letra en mayúscula
                                // Agrega más detalles según sea necesario
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            '$title: ',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String capitalize(String s) {
    if (s.isEmpty) {
      return s;
    }
    return s[0].toUpperCase() + s.substring(1);
  }
}
