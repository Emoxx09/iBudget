import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:workingproject/homepage.dart';
import 'package:workingproject/database.dart';
import 'database_helpers.dart';

double balance = 0;
double spent = 0;



main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final PrimaryColor = const Color(0xFFFFFFF);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(40, 41, 41, 1),
      ),
      home: HomePage(),
    );
  }
}