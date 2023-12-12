import 'package:catalogo_bratz/colors.dart';
import 'package:catalogo_bratz/home_screen.dart';
import 'package:flutter/material.dart';





void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: kBgClr,
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

