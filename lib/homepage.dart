import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workingproject/drawer.dart';
import 'package:workingproject/main.dart';
import 'myflexibleappbar.dart';
import 'myappbar.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert';
import 'package:workingproject/database_helpers.dart';
import 'package:workingproject/myflexibleappbar.dart';

DateTime date_time = DateTime.now();
final GlobalKey scaffoldKey = new GlobalKey();
double x = 0.0;
double y = 0.0;
double z = 0.0;
double zz = 0.0;
double fareSpent = 0.00;
double foodSpent = 0.00;
double schoolWorksSpent = 0.00;
double personalSpent = 0.00;

String categoryClicked;

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
TextEditingController _c = new TextEditingController();
TextEditingController _d = new TextEditingController();
String selectedCategory = "Fare";
List<String> _locations = ["Fare", "Food", "Schoolwork", "Personal"];

class HomePage extends StatefulWidget {
  HomePage() : super();
  @override
  _HomePageState createState() => _HomePageState();
}

class DecimalTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final regEx = RegExp(r"^\d*\.?\d*");
    String newString = regEx.stringMatch(newValue.text) ?? "";
    return newString == newValue.text ? newValue : oldValue;
  }
}

class CurrencyPtBrInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    double value = double.parse(newValue.text);
    final formatter = new NumberFormat("#,##0.00", "pt_BR");
    String newText = "R\$ " + formatter.format(value / 100);

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}

class _HomePageState extends State<HomePage> {
  var username;
  var password;

  String _text = "initial";

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext contexte) {
    setState(() {
      refresh();
    });
    return Scaffold(
      backgroundColor: Color.fromRGBO(40, 41, 41, 1),
      drawer: AppDrawer(),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: MyAppBar(),
            pinned: false,
            iconTheme: new IconThemeData(color: Colors.white),
            expandedHeight: 210.0,
            flexibleSpace: FlexibleSpaceBar(
              background: MyFlexiableAppBar(),
            ),
          ),
          Builder(builder: (contextx) {
            return SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0, left: 15),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Container(
                                child: Row(
                              children: <Widget>[
//                                    SizedBox(
//                                      width: 10,
//                                    ),
                                Container(
                                  child: Text(
                                    date_time == null
                                        ? months[DateTime.now().month] +
                                            " ${DateTime.now().day} ${DateTime.now().year}"
                                        : months[date_time.month] +
                                            " ${date_time.day} ${date_time.year}",
                                    style: const TextStyle(
                                        color: Color.fromRGBO(245, 247, 247, 1),
                                        fontFamily: 'Poppins',
                                        fontSize: 16.0),
                                  ),
                                ),
                              ],
                            )),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: IconButton(
                              icon: Icon(Icons.autorenew),
                              tooltip: 'Reload',
                              color: Colors.white,
                              onPressed: () {
                                setState(() {
                                  addBalance(0);

                                  refresh();
                                  reassemble();
                                });
                                balance += 0;
                              },
                            ),
                          ),
                          Container(
                              child: new Column(children: <Widget>[
                            Container(
                              child: Text(
                                "Balance: " + balance.toStringAsFixed(2),
                                style: const TextStyle(
                                    color: Color.fromRGBO(245, 247, 247, 1),
                                    fontFamily: 'Poppins',
                                    fontSize: 16.0),
                              ),
                            ),
                          ])),
                        ],
                      ),
                    ),
                  ),
                  new Container(
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ButtonTheme(
                            minWidth: 137,
                            child: RaisedButton(
                              child: Text('Add Allowance',
                                  style: TextStyle(color: Colors.black)),
                              color: Color.fromRGBO(245, 246, 247, 1.0),
                              splashColor: Color.fromRGBO(230, 235, 237, 1.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              onPressed: () {
                                _c.text = '';
                                showDialog(
                                  context: contexte,
                                  builder: (context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      elevation: 16,
                                      backgroundColor:
                                          Color.fromRGBO(40, 41, 41, 1),
                                      child: Container(
                                        height: 300.0,
                                        width: 360.0,
                                        child: ListView(
                                          children: <Widget>[
                                            SizedBox(height: 20),
                                            Center(
                                              child: Text(
                                                "Add Allowance",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 20),
                                            Container(
                                                margin: EdgeInsets.all(60),
                                                child: Theme(
                                                  data: new ThemeData(
                                                    primaryColor: Colors.grey,
                                                    primaryColorDark:
                                                        Colors.black,
                                                  ),
                                                  child: new TextField(
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                    inputFormatters: [
                                                      DecimalTextInputFormatter()
                                                    ],
                                                    controller: _c,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    textAlign: TextAlign.center,
                                                    decoration:
                                                        new InputDecoration(
                                                          hintText: "value",
                                                          fillColor: Colors.white,
                                                          hoverColor: Colors.white,
                                                          focusColor: Colors.white,
                                                          hintStyle: TextStyle(
                                                              fontSize: 16,
                                                              color: Colors
                                                                  .white70),
                                                          enabledBorder: UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Colors.white30),
                                                          ),
                                                          focusedBorder: UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Colors.white),
                                                          ),),
                                                  ),
                                                )),
                                            Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: FlatButton(
                                                          child: Text('CANCEL',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                          color: Color.fromRGBO(
                                                              40, 41, 41, 1),
                                                          splashColor:
                                                              Color.fromRGBO(
                                                                  230,
                                                                  235,
                                                                  237,
                                                                  1.0),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6.0)),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          })),
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: FlatButton(
                                                          child: Text('OK',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                          color: Color.fromRGBO(
                                                              40, 41, 41, 1),
                                                          splashColor:
                                                              Color.fromRGBO(
                                                                  230,
                                                                  235,
                                                                  237,
                                                                  1.0),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6.0)),
                                                          onPressed: () {
                                                            setState(() {
                                                              addBalance(
                                                                  double.parse(
                                                                      _c.text));
                                                            });

                                                            _popUp(contextx,
                                                                "Allowance Added!", 2);
                                                            balance +=
                                                                double.parse(
                                                                    _c.text);
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          })),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ButtonTheme(
                            minWidth: 137,
                            child: RaisedButton(
                              child: Text('Spend Money',
                                  style: TextStyle(color: Colors.black)),
                              color: Color.fromRGBO(245, 246, 247, 1.0),
                              splashColor: Color.fromRGBO(230, 235, 237, 1.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              onPressed: () {
                                _c.text = '';
                                _d.text = '';
                                print(selectedCategory);
                                showDialog(
                                  context: contexte,
                                  builder: (context) {
                                    return Dialog(
                                      backgroundColor:
                                          Color.fromRGBO(40, 41, 41, 1),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      elevation: 16,
                                      child: Container(
                                        height: 430.0,
                                        width: 360.0,
                                        child: ListView(
                                          children: <Widget>[
                                            SizedBox(height: 20),
                                            Center(
                                              child: Text(
                                                "Spend Money",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 20),
                                            new StatefulBuilder(
                                              builder: (context, setState) {
                                                return Center(
                                                  child: Theme(
                                                      data: Theme.of(context)
                                                          .copyWith(
                                                        canvasColor:
                                                            Color.fromRGBO(
                                                                54, 54, 54, 1),
                                                      ),
                                                      child: new DropdownButton<
                                                              String>(
                                                          items: _locations.map(
                                                              (String val) {
                                                            return new DropdownMenuItem<
                                                                String>(
                                                              value: val,
                                                              child: new Text(
                                                                  val,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white)),
                                                            );
                                                          }).toList(),
                                                          hint: Text(
                                                              selectedCategory,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                          onChanged:
                                                              (String newVal) {
                                                            setState(() {
                                                              selectedCategory =
                                                                  newVal;
                                                              print(
                                                                  selectedCategory);
                                                            });
                                                          })),
                                                );
                                              },
                                            ),
                                            Container(
                                                margin: EdgeInsets.only(
                                                    left: 60,
                                                    right: 60,
                                                    top: 36,
                                                    bottom: 6),
                                                child: new Theme(
                                                  data: new ThemeData(
                                                    primaryColor: Colors.grey,
                                                    primaryColorDark:
                                                        Colors.black,
                                                  ),
                                                  child: new TextField(
                                                    cursorColor: Colors.white,
                                                    maxLength: 11,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                    controller: _d,
                                                    textAlign: TextAlign.center,
                                                    decoration:
                                                        new InputDecoration(
                                                          hintText: "short description",
                                                            counter: Offstage(),
                                                          fillColor: Colors.white,
                                                          hoverColor: Colors.white,
                                                          focusColor: Colors.white,
                                                          hintStyle: TextStyle(
                                                              fontSize: 16,
                                                              color: Colors
                                                                  .white70),
                                                          enabledBorder: UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Colors.white30),
                                                          ),
                                                          focusedBorder: UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Colors.white),
                                                          ),),
                                                  ),
                                                )),
                                            Container(
                                                margin: EdgeInsets.only(
                                                    left: 60,
                                                    right: 60,
                                                    top: 6,
                                                    bottom: 36),
                                                child: new Theme(
                                                  data: new ThemeData(
                                                    primaryColor: Colors.grey,
                                                    primaryColorDark:
                                                        Colors.black,
                                                  ),
                                                  child: new TextField(
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                    inputFormatters: [
                                                      DecimalTextInputFormatter()
                                                    ],
                                                    controller: _c,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    textAlign: TextAlign.center,
                                                    decoration:
                                                        new InputDecoration(
                                                          hintText: "value",
                                                          fillColor: Colors.white,
                                                          hoverColor: Colors.white,
                                                          focusColor: Colors.white,
                                                          hintStyle: TextStyle(
                                                              fontSize: 16,
                                                              color: Colors
                                                                  .white70),
                                                          enabledBorder: UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Colors.white30),
                                                          ),
                                                          focusedBorder: UnderlineInputBorder(
                                                            borderSide: BorderSide(color: Colors.white),
                                                          ),),
                                                  ),
                                                )),
                                            Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: FlatButton(
                                                          child: Text('CANCEL',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                          color: Color.fromRGBO(
                                                              40, 41, 41, 1),
                                                          splashColor:
                                                              Color.fromRGBO(
                                                                  230,
                                                                  235,
                                                                  237,
                                                                  1.0),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6.0)),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          })),
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: FlatButton(
                                                          child: Text('OK',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                          color: Color.fromRGBO(
                                                              40, 41, 41, 1),
                                                          splashColor:
                                                              Color.fromRGBO(
                                                                  230,
                                                                  235,
                                                                  237,
                                                                  1.0),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6.0)),
                                                          onPressed: () {
                                                            if (double.parse(
                                                                    _c.text) >
                                                                balance) {
                                                              _popUp(contextx,
                                                                  "Insufficient Balance!", 1);
                                                            } else {
                                                              setState(() {
                                                                _spend(
                                                                    selectedCategory,
                                                                    double.parse(
                                                                        _c.text));
                                                              });
                                                              spent +=
                                                                  double.parse(
                                                                      _c.text);
                                                              balance -=
                                                                  double.parse(
                                                                      _c.text);

                                                              fareSpent =
                                                                  fareSpent;
                                                              foodSpent =
                                                                  foodSpent;
                                                              schoolWorksSpent =
                                                                  schoolWorksSpent;
                                                              personalSpent =
                                                                  personalSpent;

                                                              if (selectedCategory ==
                                                                  "Fare") {
                                                                fareSpent +=
                                                                    double.parse(
                                                                        _c.text);
                                                              } else if (selectedCategory ==
                                                                  "Food") {
                                                                foodSpent +=
                                                                    double.parse(
                                                                        _c.text);
                                                              } else if (selectedCategory ==
                                                                  "Schoolwork") {
                                                                schoolWorksSpent +=
                                                                    double.parse(
                                                                        _c.text);
                                                              } else if (selectedCategory ==
                                                                  "Personal") {
                                                                personalSpent +=
                                                                    double.parse(
                                                                        _c.text);
                                                              }
                                                              x = fareSpent /
                                                                  spent;
                                                              y = foodSpent /
                                                                  spent;
                                                              z = schoolWorksSpent /
                                                                  spent;
                                                              zz =
                                                                  personalSpent /
                                                                      spent;
                                                              _popUp(contextx,
                                                                  "Money Spent!", 2);
                                                            }
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          })),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  StatefulBuilder(builder: (context, setState) {
                    return Center(
                        child: Column(
                      children: <Widget>[
                        InkWell(
                          onTap: (){
                            categoryClicked = "Fare";
                            print(categoryClicked);
//                            print(DateTime.now().hour.toString() + " " + DateTime.now().minute.toString());
                            showSpendingDialog(context, 0);
                          },
                          child: myCardDetails("images/fare.png", "Fare", x,
                              fareSpent.toString()),
                        ),
                        InkWell(
                          onTap: () {
                            categoryClicked = "Food";
                            print(categoryClicked);
                            showSpendingDialog(context, 0);
                          },
                          child: myCardDetails("images/food.png", "Food", y,
                              foodSpent.toString()),
                        ),
                        InkWell(
                          onTap: () {
                            categoryClicked = "Schoolwork";
                            print(categoryClicked);
                            showSpendingDialog(context, 0);
                          },
                          child: myCardDetails("images/schoolwork.png",
                              "Schoolwork", z, schoolWorksSpent.toString()),
                        ),
                        InkWell(
                          onTap: () {
                            categoryClicked = "Personal";
                            print(categoryClicked);
                            showSpendingDialog(context, 0);
                          },
                          child: myCardDetails("images/personal.png",
                              "Personal", zz, personalSpent.toString()),
                        ),
                      ],
                    ));
                  }),
                ],
              ),
            );
          })
        ],
      ),
//    drawer: AppDrawer(),
    );
  }
}

showSpendingDialog(BuildContext context, int choice){
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: Color.fromRGBO(40, 41, 41, 1),
        elevation: 16,
        title: Text("Spending History",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Century Gothic',
                fontWeight: FontWeight.normal,
                fontSize: 20.0)),
        content: Container(
          height: 450.0,
          width: 450.0,
          child: FutureBuilder(
            future: getCardInfo(choice),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if (snapshot.data == null){
                return Container(
                  child: Center(
                    child: Text("Loading...", style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Century Gothic',
                        fontWeight: FontWeight.normal,
                        fontSize: 16.0))
                  )
                );
              }
              else{
                String imageVal;
                if (categoryClicked == "Fare"){
                  imageVal = "images/fare.png";
                }
                else if (categoryClicked == "Food"){
                  imageVal = "images/food.png";
                }
                else if (categoryClicked == "Schoolwork"){
                  imageVal = "images/schoolwork.png";
                }
                else if (categoryClicked == "Personal"){
                  imageVal = "images/personal.png";
                }
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index){

                    return ListTile(

//                      title: cardGen(imageVal, snapshot.data[index].desc.trim(), double.parse(snapshot.data[index].spent), snapshot.data[index].timeStamp),
                        title: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: cardGen(imageVal, snapshot.data[index].desc.trim(), double.parse(snapshot.data[index].spent), snapshot.data[index].timeStamp, snapshot.data[index].date),
                        ),
                    );
                  },
                );
              }
            },
          ),
        ),
      );
    },
  );
}


cardGen(String image, String desc, double value, String timeStamp, String dateStamp) {

  return Padding(
    padding: const EdgeInsets.only(top: 7, bottom: 7, left: 0, right: 0),
    child: Material(
      color: Color.fromRGBO(40, 41, 41, 1),
      elevation: 10.0,
      borderRadius: BorderRadius.circular(13.0),
      shadowColor: Color.fromRGBO(255, 255, 255, 0.0),
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Row(
          children: <Widget>[
            Container(
              width: 60,
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Image(
                        height: 50.0,
                        image: AssetImage(image),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                  ],
                )),

            Container(
              height: 50,
              width: 90,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          height: 30,
                          child: Text(desc,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Century Gothic',
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14.0)
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          child: Text(" - \u20B1" + value.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromRGBO(237, 104, 104, 1),
                                  fontFamily: 'Century Gothic',
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16.0)
                          ),
                        ),
                      ],
                    ),
                  ],
                )),

            Container(
              height: 50,
              width: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(dateStamp,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Century Gothic',
                              fontWeight: FontWeight.normal,
                              fontSize: 14.0)
                      ),
                    ),

                    SizedBox(
                      height: 12.0,
                    ),
                    Container(
                      child: Text(timeStamp,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Century Gothic',
                              fontWeight: FontWeight.normal,
                              fontSize: 15.0)
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                  ],
                )),
          ],
        ),
      ),
    ),
  );
}

Future getCardInfo(int choice) async{
  DatabaseHelper helper = DatabaseHelper.instance;
  List data1 = await helper.getAllRecords("spendingHistory");
  List<CardInfo> cardInfo = [];
  DateTime date = DateTime.now();
  for (var i in data1){
    Transaction1 transaction = Transaction1.fromMap(i);
    if (choice == 0){
      if (date.year.toString() + "0" + date.month.toString() + date.day.toString() != transaction.dateStamp.trim() || categoryClicked != transaction.category.trim()){
        continue;
      }
    }
    else if (choice == 1){
      if (dateTime.year.toString() + "0" + dateTime.month.toString() + dateTime.day.toString() != transaction.dateStamp.trim() || categoryClicked != transaction.category.trim()){
        continue;
      }
    }else if (choice == 2){
      if ((months[dateTime.month] != transaction.month.trim() && dateTime.year.toString() != transaction.year.trim()) || categoryClicked != transaction.category.trim()){
        continue;
      }
    }else if (choice == 3){
      if (dateTime.year.toString() != transaction.year.trim() || categoryClicked != transaction.category.trim()){
        continue;
      }
    }
    String deyt = transaction.month + "/" + transaction.day + "/" + transaction.year;
    CardInfo cardd = CardInfo(transaction.dateStamp, transaction.spent, transaction.category, transaction.description, transaction.time, deyt);
    cardInfo.add(cardd);
  }

  return cardInfo;
}


class CardInfo{
  final String dateStamp;
  final String spent;
  final String category;
  final String desc;
  final String timeStamp;
  final String date;

  CardInfo(this.dateStamp, this.spent, this.category, this.desc,  this.timeStamp, this.date);
}

Widget myCardDetails(
    String imageVal, String categoryName, double data, String categoryVal) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Material(
      color: Color.fromRGBO(40, 41, 41, 1),
      elevation: 10.0,
      borderRadius: BorderRadius.circular(13.0),
      shadowColor: Color.fromRGBO(255, 255, 255, 0.0),
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: myCurrencies(imageVal, categoryName, data, categoryVal),
      ),
    ),
  );
}

Center myCurrencies(
    String imageVal, String categoryName, double data, String categoryVal) {
  return Center(
      child: Column(
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          myLeadingDetails(imageVal),
          myGraphDetails(data, categoryName),
          myCurrenciesDetails(categoryVal),
        ],
      )
    ],
  ));
}

Widget myLeadingDetails(String imageVal) {
  return Container(
      child: Row(
    children: <Widget>[
      Container(
        child: Image(
          height: 50.0,
          image: AssetImage(imageVal),
        ),
      ),
      SizedBox(
        width: 10.0,
      ),
    ],
  ));
}

Widget myGraphDetails(double data, String categoryName) {
  Color color;
  if (categoryName == "Fare") {
    color = Color.fromRGBO(89, 211, 255, 1);
  } else if (categoryName == "Food") {
    color = Color.fromRGBO(248, 255, 130, 1);
  } else if (categoryName == "Schoolwork") {
    color = Color.fromRGBO(255, 125, 125, 1);
  } else if (categoryName == "Personal") {
    color = Color.fromRGBO(105, 255, 141, 1);
  }

  return Container(
      child: Column(
    children: <Widget>[
      Container(
        child: Text(
          categoryName,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'CenturyGothic',
              fontWeight: FontWeight.bold,
              fontSize: 16.0),
        ),
      ),
      Container(
        child: LinearPercentIndicator(
          width: 80.0,
          lineHeight: 14.0,
          percent: data,
          backgroundColor: Colors.white,
          progressColor: color,
        ),
      ),
    ],
  ));
}

Widget myCurrenciesDetails(
  String currencyVal,
) {
  return Container(
      child: Column(
    children: <Widget>[
      Container(
        child: Text("\u20B1" + currencyVal,
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w800,
                fontSize: 16.0)),
      ),
    ],
  ));
}

_spend(String category, double amount) async {
  Transaction1 transaction = Transaction1();
  var date = DateTime.now();

  transaction.dateStamp =
      date.year.toString() + "0" + date.month.toString() + date.day.toString();
  transaction.id = "NULL";
  transaction.day = date.day.toString();
  transaction.month = months[date.month];
  transaction.year = date.year.toString();
  transaction.allowance = "00.00";
  transaction.spent = amount.toString();
  transaction.saved = "00.00";
  transaction.fare = "00.00";
  transaction.food = "00.00";
  transaction.schoolwork = "00.00";
  transaction.personal = "00.00";
  transaction.time = DateTime.now().hour.toString() + ":" + DateTime.now().minute.toString();

  if (category == "Fare") {
    transaction.fare = amount.toString();
    transaction.category = "Fare";
  }
  if (category == "Food") {
    transaction.food = amount.toString();
    transaction.category = "Food";
  }
  if (category == "Schoolwork") {
    transaction.schoolwork = amount.toString();
    transaction.category = "Schoolwork";
  }
  if (category == "Personal") {
    transaction.personal = amount.toString();
    transaction.category = "Personal";
  }
  transaction.description = _d.text.trim();

  DatabaseHelper helper = DatabaseHelper.instance;
  String line = await helper.insertSpend(transaction);
  String line1 = await helper.insertSpendHistory(transaction);
}

addBalance(double amount) async {
  Transaction1 transaction = Transaction1();
  var date = DateTime.now();

  transaction.dateStamp =
      date.year.toString() + "0" + date.month.toString() + date.day.toString();
  transaction.id = "00";
  transaction.day = date.day.toString();
  transaction.month = months[date.month];
  transaction.year = date.year.toString();
  transaction.allowance = amount.toString();
  transaction.spent = "00.00";
  transaction.saved = amount.toString();
  transaction.fare = "00.00";
  transaction.food = "00.00";
  transaction.schoolwork = "00.00";
  transaction.personal = "00.00";

  DatabaseHelper helper = DatabaseHelper.instance;
  String line = await helper.insertAdd(transaction);
}

Future<Transaction1> getBalance() async {
  Transaction1 transaction = Transaction1();
  var date = DateTime.now();

  transaction.dateStamp =
      date.year.toString() + "0" + date.month.toString() + date.day.toString();
  transaction.id = "00";
  transaction.day = date.day.toString();
  transaction.month = months[date.month];
  transaction.year = date.year.toString();
  transaction.allowance = "00.00";
  transaction.spent = "00.00";
  transaction.saved = "00.00";
  transaction.fare = "00.00";
  transaction.food = "00.00";
  transaction.schoolwork = "00.00";
  transaction.personal = "00.00";

  DatabaseHelper helper = DatabaseHelper.instance;
  Transaction1 line = await helper.getBalance(transaction);
  return line;
}

_undoTransaction(String category, double amount) async {
  Transaction1 transaction = Transaction1();
  var date = DateTime.now();

  transaction.dateStamp =
      date.year.toString() + "0" + date.month.toString() + date.day.toString();
  transaction.id = "NULL";
  transaction.day = date.day.toString();
  transaction.month = months[date.month];
  transaction.year = date.year.toString();
  transaction.allowance = "00.00";
  transaction.spent = "-" + amount.toString();
  transaction.saved = "00.00";
  transaction.fare = "00.00";
  transaction.food = "00.00";
  transaction.schoolwork = "00.00";
  transaction.personal = "00.00";
  transaction.time = DateTime.now().hour.toString() + ":" + DateTime.now().minute.toString();

  if (category == "Fare") {
    transaction.fare = "-" + amount.toString();
    transaction.category = "Fare";
  }
  if (category == "Food") {
    transaction.food = "-" + amount.toString();
    transaction.category = "Food";
  }
  if (category == "Schoolwork") {
    transaction.schoolwork = "-" + amount.toString();
    transaction.category = "Schoolwork";
  }
  if (category == "Personal") {
    transaction.personal = "-" + amount.toString();
    transaction.category = "Personal";
  }
  transaction.description = _d.text.trim();

  DatabaseHelper helper = DatabaseHelper.instance;
  await helper.insertSpend(transaction);
  await helper.deleteSpendHistory(transaction);
}

_popUp(BuildContext context, String text, int choice) {
  Scaffold.of(context).removeCurrentSnackBar();
  if (choice == 1){
    SnackBar alertSnackBar = SnackBar(
        duration: const Duration(seconds: 7),
        content: Text(
              text,
              textAlign: TextAlign.center,
            ),);
    Scaffold.of(context).showSnackBar(alertSnackBar);
  }
  else{
    SnackBar alertSnackBar = SnackBar(
      content: Text(text),
      action: SnackBarAction(
        label: 'Undo', // or some operation you would like
        onPressed: () {
          if (text == "Money Spent!"){
            _undoTransaction(selectedCategory, double.parse(_c.text));
            spent -= double.parse(_c.text);
            balance += double.parse(_c.text);

            if (selectedCategory ==
                "Fare") {
              fareSpent -=
                  double.parse(
                      _c.text);
            } else if (selectedCategory ==
                "Food") {
              foodSpent -=
                  double.parse(
                      _c.text);
            } else if (selectedCategory ==
                "Schoolwork") {
              schoolWorksSpent -=
                  double.parse(
                      _c.text);
            } else if (selectedCategory ==
                "Personal") {
              personalSpent -=
                  double.parse(
                      _c.text);
            }
            refresh();
          }
          else{
            addBalance(double.parse("-" + _c.text));
            balance -= double.parse(_c.text);
          }
        },
      ),
    );
    Scaffold.of(context).showSnackBar(alertSnackBar);
  }
}

refresh() async {
  Transaction1 line = await getBalance();
  balance = double.parse(line.allowance);
  spent = double.parse(line.spent);
  fareSpent = double.parse(line.fare);
  foodSpent = double.parse(line.food);
  schoolWorksSpent = double.parse(line.schoolwork);
  personalSpent = double.parse(line.personal);

  x = fareSpent / spent;
  y = foodSpent / spent;
  z = schoolWorksSpent / spent;
  zz = personalSpent / spent;

  x1 = chartFareSpent /
      double.parse(line.spent);
  y1 = chartFoodSpent /
      double.parse(line.spent);
  z1 = chartSchoolWorksSpent /
      double.parse(line.spent);
  zz1 =
      chartPersonalSpent /
          double.parse(line.spent);
}
