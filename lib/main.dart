import 'package:enclase4/pantallados.dart';
import 'package:enclase4/pantallauno.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: "/",
      routes: { 
                "/"   :(context)=>pantallaUno(),
                "dos" :(context)=>pantallaDos(),
              },
    );
  }
}