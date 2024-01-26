
import 'package:flutter/material.dart';
import 'home.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _AppState();
  
}

class _AppState extends State<MyApp>{

  

  @override
  Widget build(BuildContext context) {

    
    
    return(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage()));

  }
}