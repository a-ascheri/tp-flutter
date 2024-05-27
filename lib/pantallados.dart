import 'package:flutter/material.dart';

class pantallaDos extends StatefulWidget {
  const pantallaDos({super.key});

  @override
  State<pantallaDos> createState() => _pantallaDosState();
}

class _pantallaDosState extends State<pantallaDos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Titulo Pantalla 2"),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Text("pantalla 2"),
      ),
    );
  }
}