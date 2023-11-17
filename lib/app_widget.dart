import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Menssageiro',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      routerConfig: Modular.routerConfig,
    ); //added by extension
  }
}
