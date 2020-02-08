import 'package:flutter/material.dart';
import 'ui/homepage.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),  
    theme: ThemeData(
        hintColor: Colors.white,
        backgroundColor: Colors.white,
        appBarTheme: AppBarTheme(color: Colors.white)),
  ));
}
