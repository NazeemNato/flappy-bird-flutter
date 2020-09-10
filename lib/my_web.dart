import 'package:flappy/views/homeScreen.dart';
import 'package:flutter/material.dart';

class MyWeb extends StatelessWidget {
  const MyWeb({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flappy bird',
      debugShowMaterialGrid: false,
      home: HomeScreen(),
    );
  }
}