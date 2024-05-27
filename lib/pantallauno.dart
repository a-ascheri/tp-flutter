import 'package:flutter/material.dart';

class pantallaUno extends StatelessWidget {
  const pantallaUno({super.key});

  @override

  Widget build(BuildContext context) {
    String titulo = "Pantalla Uno";
    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed("dos");
                        },
                        child: contenedores("Cont 1", Colors.blue),
                      ),
                      SizedBox(height: 20.0),
                      contenedores("Cont 2", Colors.red),
                      SizedBox(height: 20.0),
                      contenedores("Cont 3", Colors.green),
                      SizedBox(height: 20.0),
                      contenedores("Cont 4", Colors.yellow),
                    ],
                  ),
                  SizedBox(width: 20.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      contenedores("Cont 5", Colors.blueAccent),
                      SizedBox(height: 20.0),
                      contenedores("Cont 6", Colors.redAccent),
                      SizedBox(height: 20.0),
                      contenedores("Cont 7", Colors.greenAccent),
                      SizedBox(height: 20.0),
                      contenedores("Cont 8", Colors.yellowAccent),
                    ],
                  ),
                ],
        ),
      ),
    );
  }

  Widget contenedores (String texto, Color colores){
    return Container(
          width: 100.0,
          height: 100.0,
          color: colores,
          child: Center(
            child: Text(texto),
          ),
        );
  }

}