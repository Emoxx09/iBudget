import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:workingproject/homepage.dart';
import 'package:workingproject/database.dart';
import 'package:workingproject/main.dart';
import 'package:workingproject/homepage.dart';


class MyFlexiableAppBar extends StatefulWidget {

  @override
  _MyFlexiableAppBarState createState() => _MyFlexiableAppBarState();
}

class _MyFlexiableAppBarState extends State<MyFlexiableAppBar> {


  final double appBarHeight = 66.0;
  var months = [
    "",
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  @override
  Widget build(BuildContext context) {

    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return StatefulBuilder(
      builder: (context, setState) =>
        new Container(
          padding: new EdgeInsets.only(top: statusBarHeight),
          height: statusBarHeight + appBarHeight,
          child: new Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: new Text("You have spent ",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'CenturyGothic',
                                  fontSize: 28.0)),
                        ),
                        Container(
                          child: new Text("\u20B1" '$spent',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w800,
                                  fontSize: 36.0)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: <Widget>[
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: new Text("as of today",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'CenturyGothic',
                                    fontSize: 20.0)),
                          ),
                        ),
                      ],
                    ),
                  ),
//                  Padding(
//                    padding: const EdgeInsets.only(right: 15.0, left: 15),
//                    child: Container(
//                      child: Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        children: <Widget>[
//                          Container(
//                            child: Container(
//                                child: Row(
//                                  children: <Widget>[
////                                    SizedBox(
////                                      width: 10,
////                                    ),
//                                    Container(
//                                      child: Text(
//                                        date_time == null
//                                            ? months[DateTime.now().month] +
//                                            " ${DateTime.now().day} ${DateTime.now().year}"
//                                            : months[date_time.month] +
//                                            " ${date_time.day} ${date_time.year}",
//                                        style: const TextStyle(
//                                            color: Color.fromRGBO(245, 247, 247,1),
//                                            fontFamily: 'Poppins',
//                                            fontSize: 16.0),
//                                      ),
//                                    ),
//
//                                  ],
//                                )),
//                          ),
//                          Container(
//                            alignment: Alignment.center,
//                            child: IconButton(
//                              icon: Icon(Icons.autorenew),
//                              tooltip: 'Reload',
//                              color: Colors.white,
//                              onPressed: () {
//                                setState(() {
//                                  addBalance(0);
//
//                                  refresh();
//                                  reassemble();
//                                });
//                                balance+=0;
//
//                              },
//                            ),
//                          ),
//
//                          Container(
//                              child: new Column(children: <Widget>[
//                                Container(
//                                  child: Text("Balance: " '$balance',
//                                    style: const TextStyle(
//                                        color: Color.fromRGBO(245, 247, 247,1),
//                                        fontFamily: 'Poppins',
//                                        fontSize: 16.0),
//                                  ),
//                                ),
//                              ])),
//                        ],
//                      ),
//                    ),
//                  ),
                ],
              )),
          decoration: new BoxDecoration(
            color: Color.fromRGBO(40, 41, 41, 1),
          ),

        )
    );
  }


}
