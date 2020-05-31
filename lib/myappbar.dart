import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:workingproject/database.dart';
import 'package:workingproject/drawer.dart';
import 'package:workingproject/variables.dart';
import 'package:workingproject/homepage.dart';


class MyAppBar extends StatelessWidget {

  final double barHeight = 66.0;
  const MyAppBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
//          Container(child: Padding(
//            padding: const EdgeInsets.all(16.0),
//            child: IconButton(
//              icon: Icon(FontAwesomeIcons.bars,color: Colors.white),
//              tooltip: 'Options',
//              onPressed: (){
//
//
//
//              },
//              ),
//          ),),

          Container(
          margin: EdgeInsets.all(69),
          alignment: Alignment.center,
            child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              ' ',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontSize: 20.0
              ),
            ),

          ),),

//          Container(child: Padding(
//            padding: const EdgeInsets.all(10.0),
//            child: Icon(
//              FontAwesomeIcons.userCircle, color: Colors.white,),
//          ),),

        ],
      ),
    );
  }
}


