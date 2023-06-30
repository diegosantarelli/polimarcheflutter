import 'package:flutter/material.dart';
import 'package:polimarcheflutter/screens/home/homeDown_screen.dart';
import 'package:polimarcheflutter/screens/home/homeUp_screen.dart';

class HomeScreenTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: HomeScreenUp(),
          ),
          HomeScreenDown(),
        ],
      ),
    );
  }
}