import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
//import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:workingproject/homepage.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:workingproject/indicator.dart';
import 'package:workingproject/main.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:workingproject/database_helpers.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

int touchedIndex;
String _selectedCategory = "View by day";
DateTime dateTime = DateTime.now();
String dateCategory =
    months[dateTime.month] + " ${dateTime.day} ${dateTime.year}";
int choice = 1;


double chartBalance = balance;
double chartSpent = spent;
double chartFareSpent = fareSpent;
double chartFoodSpent = foodSpent;
double chartSchoolWorksSpent = schoolWorksSpent;
double chartPersonalSpent = personalSpent;
double x1 = 0.0;
double y1 = 0.0;
double z1 = 0.0;
double zz1 = 0.0;

TextEditingController _c = new TextEditingController();


class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 243,
        child: Drawer(
            child: Container(
          color: Color.fromRGBO(38, 39, 41, 1.0),
          child: ListView(
            children: <Widget>[
              _createHeader(),
              ListTile(
                  title: Text(
                    "Transaction History",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'CenturyGothic',
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0),
                  ),
                  leading: Icon(Icons.history, color: Colors.white),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HistoryRoute()),
                    );
                  }),
              ListTile(
                  title: Text(
                    "Settings",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'CenturyGothic',
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0),
                  ),
                  leading: Icon(Icons.settings, color: Colors.white),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsRoute()),
                    );
                  }),
            ],
          ),
        )));
  }
}

class SettingsRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Settings"),
      ),
      body: Center(
          child: Container(
        decoration: new BoxDecoration(
          color: Color.fromRGBO(40, 41, 41, 1),
        ),
      )),
    );
  }
}

showDp(){
  Container(
    height: 300,
    child: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.dateAndTime,
        onDateTimeChanged: (dateTime) {

        }
    ),
  );
}

class HistoryRoute extends StatelessWidget {
  List<String> _locations = [
    "View by day",
    "View by month",
    "View by year",
  ];
  DateTime maxDeyt = DateTime.parse("2222-05-31 00:00:00.000000");
  DateTime minDeyt = DateTime.parse("2020-01-01 00:00:00.000000");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(40, 41, 41, 1),
        appBar: AppBar(
          elevation: 0,
          title: Text("History"),
        ),
        body: PageView(
          children: <Widget>[
            CustomScrollView(
              slivers: <Widget>[

                new StatefulBuilder(
                    builder: (context, setState){
                      return SliverList(
                          delegate: SliverChildListDelegate(
                            <Widget>[
                              Center(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: <Widget>[
                                                Container(
                                                  width: 150,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      DropdownButton<String>(
                                                          icon: Icon(Icons.arrow_drop_down,
                                                              color: Colors.white),
                                                          iconSize: 30,
                                                          underline: SizedBox(),
                                                          items: _locations.map((String val) {
                                                            return new DropdownMenuItem<String>(
                                                              value: val,
                                                              child: new Text(val,
                                                                  style:
                                                                  TextStyle(color: Colors.black)),
                                                            );
                                                          }).toList(),
                                                          hint: Text(_selectedCategory,
                                                              textAlign: TextAlign.right,
                                                              style: TextStyle(color: Colors.white)),
                                                          onChanged: (String newVal) {
                                                            setState(() {
                                                              _selectedCategory = newVal;

                                                              if (_selectedCategory == "View by day") {
                                                                dateTime = DateTime.now();
                                                                dateCategory = months[dateTime.month] +
                                                                    " ${dateTime.day} ${dateTime.year}";
                                                                choice = 1;
                                                              } else if (_selectedCategory ==
                                                                  "View by month") {
                                                                dateTime = DateTime.now();
                                                                dateCategory = months[dateTime.month] +
                                                                    " ${dateTime.year}";
                                                                choice = 2;
                                                              } else if (_selectedCategory ==
                                                                  "View by year") {
                                                                dateTime = DateTime.now();
                                                                dateCategory = "${dateTime.year}";
                                                                choice = 3;
                                                              }
                                                              print(_selectedCategory);
                                                            });
                                                          })
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 1.0,
                                                  height: 30.0,
                                                  child: const DecoratedBox(
                                                    decoration: const BoxDecoration(
                                                        color: Colors.white
                                                    ),
                                                  ),
                                                ),

                                                const SizedBox(
                                                  height: 18,
                                                  width: 20,
                                                ),

                                                Container(
                                                  width: 170,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[

                                                      Text(
                                                        dateCategory,
                                                        style: const TextStyle(
                                                            color: Color.fromRGBO(245, 247, 247, 1),
                                                            fontFamily: 'Poppins',
                                                            fontSize: 16.0),
                                                      ),

                                                      IconButton(
                                                        icon: Icon(FontAwesomeIcons.calendarDay),
                                                        alignment: Alignment.center,
                                                        iconSize: 21,
                                                        tooltip: 'Change date',
                                                        color: Colors.white,
                                                        onPressed: () async{

                                                          if (_selectedCategory == "View by month"){
                                                            showMonthPicker(
                                                              context: context,
                                                              firstDate: DateTime(DateTime.now().year - 1, 5),
                                                              lastDate: DateTime(DateTime.now().year + 1, 9),
                                                              initialDate: dateTime,
                                                              locale: Locale("en"),
                                                            ).then((date) {
                                                              if (date != null) {
                                                                setState(() {
                                                                  dateTime = date;
                                                                  dateCategory = months[dateTime.month] +
                                                                      " ${dateTime.year}";
                                                                });
                                                              }
                                                            });
                                                          }
                                                          else if (_selectedCategory == "View by year"){
//                                                    DateTime date = await yearPicker(context);
//                                                    if (date != null){
//                                                      setState((){
//                                                        dateTime = date;
//                                                        dateCategory = "${dateTime.year}";
//                                                      });
//                                                    }
                                                            _c.text = dateCategory;
                                                            showDialog(
                                                              context: context,
                                                              builder: (context) {
                                                                return AlertDialog(
                                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                                                  backgroundColor: Color.fromRGBO(40, 41, 41, 1),
                                                                  elevation: 16,
                                                                  title: Text("Set Year",
                                                                      textAlign: TextAlign.center,
                                                                      style: TextStyle(
                                                                          color: Colors.white,
                                                                          fontFamily: 'Century Gothic',
                                                                          fontWeight: FontWeight.normal,
                                                                          fontSize: 20.0)),
                                                                  content: Container(
                                                                    width: 400,
                                                                    height: 200,
                                                                    child: Center(
                                                                      child: Column(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                        children: <Widget>[
                                                                          SizedBox(
                                                                            height: 50,
                                                                          ),

                                                                          Container(
                                                                            width: 100,
                                                                            height: 40,
                                                                            child: TextFormField(
                                                                              controller: _c,
                                                                              maxLength: 4,
                                                                              style: TextStyle(
                                                                                color: Colors.white,
                                                                              ),
                                                                              textAlign: TextAlign.center,
                                                                              decoration: const InputDecoration(
                                                                                icon: Icon(FontAwesomeIcons.calendar, color: Colors.white,),
                                                                                fillColor: Colors.white,
                                                                                hoverColor: Colors.white,
                                                                                focusColor: Colors.white,
                                                                                hintStyle: TextStyle(
                                                                                    fontSize: 16,
                                                                                    color: Colors
                                                                                        .white),
                                                                                enabledBorder: UnderlineInputBorder(
                                                                                  borderSide: BorderSide(color: Colors.white70),
                                                                                ),
                                                                                focusedBorder: UnderlineInputBorder(
                                                                                  borderSide: BorderSide(color: Colors.white),
                                                                                ),
                                                                              ),
                                                                              onSaved: (String value) {
                                                                                // This optional block of code can be used to run
                                                                                // code when the user saves the form.
                                                                              },
                                                                              validator: (String value) {
                                                                                return value.contains('@') ? 'Do not use the @ char.' : null;
                                                                              },
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height: 30,
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                                                                          print(DateTime.now());
                                                                                          dateTime = DateTime.parse(_c.text + '-01-01 00:00:00.000000');
                                                                                          dateCategory = _c.text;
                                                                                        });

                                                                                        Navigator.of(
                                                                                            context)
                                                                                            .pop();
                                                                                      })),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )
                                                                    ,
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                          }
                                                          else if (_selectedCategory == "View by day"){
                                                            DateTime date = await dayPicker(context);
                                                            if (date != null){
                                                              setState((){
                                                                dateTime = date;
                                                                dateCategory = months[dateTime.month] + " ${dateTime.day} ${dateTime.year}";
                                                              });
                                                            }

                                                          }
//                                          showDatePicker(
//                                              context: context,
//                                              initialDate: date_time == null
//                                                  ? DateTime.now()
//                                                  : date_time,
//                                              firstDate: DateTime(2000),
//                                              lastDate: DateTime(2222))
//                                              .then((date) {
//                                            setState(() {
//                                              date_time = date;
//                                            });
//                                          });
//                                setState(() {
//
//                                });
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                ),

                                                const SizedBox(
                                                  width: 1.0,
                                                  height: 30.0,
                                                  child: const DecoratedBox(
                                                    decoration: const BoxDecoration(
                                                        color: Colors.white
                                                    ),
                                                  ),
                                                ),

                                                Container(
                                                  width: 60,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      IconButton(icon: new Image.asset("images/go-icon.png"),
                                                          alignment: Alignment.center,
                                                          iconSize: 21,
                                                          tooltip: 'Sync Chart',
                                                          color: Colors.white,
                                                          onPressed: () async{
                                                            Transaction1 line = await getBalanceNow();
                                                            if (line == null){
                                                              _popUp(context);
                                                            }
                                                            else{
                                                              setState((){

                                                                if (_selectedCategory == "View by day"){
                                                                  print (line.allowance);
                                                                  chartBalance = double.parse(line.allowance);
                                                                  chartSpent = double.parse(line.spent);
                                                                  chartFareSpent = double.parse(line.fare);
                                                                  chartFoodSpent = double.parse(line.food);
                                                                  chartSchoolWorksSpent = double.parse(line.schoolwork);
                                                                  chartPersonalSpent = double.parse(line.personal);

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
                                                                else{
                                                                  chartBalance = double.parse(line.sumAllowance);
                                                                  chartSpent = double.parse(line.sumSpent);
                                                                  chartFareSpent = double.parse(line.sumFare);
                                                                  chartFoodSpent = double.parse(line.sumFood);
                                                                  chartSchoolWorksSpent = double.parse(line.sumSchoolwork);
                                                                  chartPersonalSpent = double.parse(line.sumPersonal);

                                                                  x1 = chartFareSpent /
                                                                      double.parse(line.sumSpent);
                                                                  y1 = chartFoodSpent /
                                                                      double.parse(line.sumSpent);
                                                                  z1 = chartSchoolWorksSpent /
                                                                      double.parse(line.sumSpent);
                                                                  zz1 =
                                                                      chartPersonalSpent /
                                                                          double.parse(line.sumSpent);
                                                                }
                                                              });
                                                            }
                                                          }
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ]
                                      )
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 20,
                              ),

                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Allowance: ",
                                      style: const TextStyle(
                                          color: Color.fromRGBO(245, 247, 247, 1),
                                          fontFamily: 'CenturyGothic',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                    Text(
                                      "\u20B1",
                                      style: const TextStyle(
                                          color: Color.fromRGBO(245, 247, 247, 1),
                                          fontFamily: 'Poppins',
                                          fontSize: 20.0),
                                    ),
                                    Text(
                                      chartBalance.toString(),
                                      style: const TextStyle(
                                          color: Color.fromRGBO(245, 247, 247, 1),
                                          fontFamily: 'CenturyGothic',
                                          fontSize: 20.0),
                                    ),
                                  ],
                                ),
                              ),


                              SizedBox(
                                height: 10,
                              ),

                              Container(
                                child: Container(
//                                width: double.infinity,
//                                height: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      AspectRatio(
                                        aspectRatio: 1.3,
                                        child: Container(
                                          color: Color.fromRGBO(40, 41, 41, 2),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              const SizedBox(
                                                height: 18,
                                              ),
                                              Expanded(
                                                child: AspectRatio(
                                                  aspectRatio: 1,
                                                  child: PieChart(
                                                    PieChartData(
                                                        pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                                                          setState(() {
                                                            if (pieTouchResponse.touchInput is FlLongPressEnd ||
                                                                pieTouchResponse.touchInput is FlPanEnd) {
                                                              touchedIndex = -1;
                                                            } else {
                                                              touchedIndex = pieTouchResponse.touchedSectionIndex;
                                                            }
                                                          });
                                                        }),
                                                        borderData: FlBorderData(
                                                          show: false,
                                                        ),
                                                        sectionsSpace: 0,
                                                        centerSpaceRadius: 80,
                                                        sections: showingSections()),
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: const <Widget>[
                                                  Indicator(
                                                    color: Color.fromRGBO(89, 211, 255, 1),
                                                    text: 'Fare',
                                                    isSquare: true,
                                                  ),
                                                  SizedBox(
                                                    height: 4,
                                                  ),
                                                  Indicator(
                                                    color: Color.fromRGBO(248, 255, 130, 1),
                                                    text: 'Food',
                                                    isSquare: true,
                                                  ),
                                                  SizedBox(
                                                    height: 4,
                                                  ),
                                                  Indicator(
                                                    color: Color.fromRGBO(255, 125, 125, 1),
                                                    text: 'Schoolwork',
                                                    isSquare: true,
                                                  ),
                                                  SizedBox(
                                                    height: 4,
                                                  ),
                                                  Indicator(
                                                    color: Color.fromRGBO(105, 255, 141, 1),
                                                    text: 'Personal',
                                                    isSquare: true,
                                                  ),
                                                  SizedBox(
                                                    height: 18,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),


                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
//                                      Center(
//                                        child: Column(
//                                          mainAxisSize: MainAxisSize.max,
//                                          mainAxisAlignment: MainAxisAlignment.end,
//                                          crossAxisAlignment: CrossAxisAlignment.start,
////                                        children: <Widget>[
////                                          Indicator(
////                                            color: Color.fromRGBO(89, 211, 255, 1),
////                                            text: 'Fare' + "\t",
////                                            isSquare: true,
////                                          ),
////                                          Text(
////                                              "\t\t\t\t\t\u20B1" + chartFareSpent.toString(), style: TextStyle(fontSize: 16, color: Colors.white)
////                                          ),
////                                          SizedBox(
////                                            height: 10,
////                                          ),
////                                          Indicator(
////                                            color: Color.fromRGBO(224, 227, 14, 1),
////                                            text: 'Food' + "\t",
////                                            isSquare: true,
////                                          ),
////                                          Text(
////                                              "\t\t\t\t\t\u20B1" + chartFoodSpent.toString(), style: TextStyle(fontSize: 16, color: Colors.white)
////                                          ),
////                                          SizedBox(
////                                            height: 10,
////                                          ),
////                                          Indicator(
////                                            color: Color.fromRGBO(255, 125, 125, 1),
////                                            text: 'Schoolwork' + "\t",
////                                            isSquare: true,
////                                          ),
////                                          Text(
////                                              "\t\t\t\t\t\u20B1" + chartSchoolWorksSpent.toString(), style: TextStyle(fontSize: 16, color: Colors.white)
////                                          ),
////                                          SizedBox(
////                                            height: 10,
////                                          ),
////                                          Indicator(
////                                            color: Color.fromRGBO(105, 255, 141, 1),
////                                            text: 'Personal' + "\t",
////                                            isSquare: true,
////                                          ),
////                                          Text(
////                                              "\t\t\t\t\t\u20B1" + chartPersonalSpent.toString(), style: TextStyle(fontSize: 16, color: Colors.white)
////                                          ),
////                                          SizedBox(
////                                            height: 10,
////                                          ),
////                                          Indicator(
////                                            color: Colors.black,
////                                            text: 'Expense' + "\t",
////                                            isSquare: true,
////                                          ),
////                                          Text(
////                                              "\t\t\t\t\t\u20B1" + chartSpent.toString(), style: TextStyle(fontSize: 16, color: Colors.white)
////                                          ),
////                                          SizedBox(
////                                            height: 18,
////                                          ),
////                                        ],
//
//
//
//                                        ),
//                                      ),
//                                      Column(
//                                        mainAxisSize: MainAxisSize.max,
//                                        mainAxisAlignment: MainAxisAlignment.end,
//                                        crossAxisAlignment: CrossAxisAlignment.start,
////                                        children: <Widget>[
////
////                                          Indicator(
////                                            color: Colors.white,
////                                            text: 'Savings' + "\t",
////                                            isSquare: true,
////                                          ),
////                                          Text(
////                                              "\t\t\t\t\t\u20B1" + chartBalance.toString(), style: TextStyle(fontSize: 16, color: Colors.white)
////                                          ),
////                                          SizedBox(
////                                            height: 10,
////                                          ),
////                                          Indicator(
////                                            color: Colors.grey,
////                                            text: 'Allowance' + "\t",
////                                            isSquare: true,
////                                          ),
////                                          Text(
////                                              "\t\t\t\t\t\u20B1" + (chartBalance + chartSpent).toString(), style: TextStyle(fontSize: 16, color: Colors.white)
////                                          ),
////                                          SizedBox(
////                                            height: 10,
////                                          ),
////                                          Indicator(
////                                            color: Color.fromRGBO(40, 41, 41, 1),
////                                            text: '',
////                                            isSquare: true,
////                                          ),
////                                          SizedBox(
////                                            height: 10,
////                                          ),
////                                          Indicator(
////                                            color: Color.fromRGBO(40, 41, 41, 1),
////                                            text: '',
////                                            isSquare: true,
////                                          ),
////                                          SizedBox(
////                                            height: 10,
////                                          ),
////                                          Indicator(
////                                            color: Color.fromRGBO(40, 41, 41, 1),
////                                            text: '',
////                                            isSquare: true,
////                                          ),
////                                          SizedBox(
////                                            height: 10,
////                                          ),
////                                          Indicator(
////                                            color: Color.fromRGBO(40, 41, 41, 1),
////                                            text: '',
////                                            isSquare: true,
////                                          ),
////                                          SizedBox(
////                                            height: 10,
////                                          ),
////                                          SizedBox(
////                                            height: 38,
////                                          ),
////                                        ],
//                                      ),
                                        ],
                                      ),


                                      myCardDetails("images/savings.png", "Savings", 1, (chartBalance - chartSpent).toString()),

                                      myCardDetails("images/expense.png", "Expense", 1, chartSpent.toString()),
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ));
                    }
                )

              ],
            ),
            CustomScrollView(
              slivers: <Widget>[

                new StatefulBuilder(
                    builder: (context, setState){
                      return SliverList(
                          delegate: SliverChildListDelegate(
                            <Widget>[
                              Center(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: <Widget>[
                                                Container(
                                                  width: 150,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      DropdownButton<String>(
                                                          icon: Icon(Icons.arrow_drop_down,
                                                              color: Colors.white),
                                                          iconSize: 30,
                                                          underline: SizedBox(),
                                                          items: _locations.map((String val) {
                                                            return new DropdownMenuItem<String>(
                                                              value: val,
                                                              child: new Text(val,
                                                                  style:
                                                                  TextStyle(color: Colors.black)),
                                                            );
                                                          }).toList(),
                                                          hint: Text(_selectedCategory,
                                                              textAlign: TextAlign.right,
                                                              style: TextStyle(color: Colors.white)),
                                                          onChanged: (String newVal) {
                                                            setState(() {
                                                              _selectedCategory = newVal;

                                                              if (_selectedCategory == "View by day") {
                                                                dateTime = DateTime.now();
                                                                dateCategory = months[dateTime.month] +
                                                                    " ${dateTime.day} ${dateTime.year}";
                                                                choice = 1;
                                                              } else if (_selectedCategory ==
                                                                  "View by month") {
                                                                dateTime = DateTime.now();
                                                                dateCategory = months[dateTime.month] +
                                                                    " ${dateTime.year}";
                                                                choice = 2;
                                                              } else if (_selectedCategory ==
                                                                  "View by year") {
                                                                dateTime = DateTime.now();
                                                                dateCategory = "${dateTime.year}";
                                                                choice = 3;
                                                              }
                                                              print(_selectedCategory);
                                                            });
                                                          })
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 1.0,
                                                  height: 30.0,
                                                  child: const DecoratedBox(
                                                    decoration: const BoxDecoration(
                                                        color: Colors.white
                                                    ),
                                                  ),
                                                ),

                                                const SizedBox(
                                                  height: 18,
                                                  width: 20,
                                                ),

                                                Container(
                                                  width: 170,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[

                                                      Text(
                                                        dateCategory,
                                                        style: const TextStyle(
                                                            color: Color.fromRGBO(245, 247, 247, 1),
                                                            fontFamily: 'Poppins',
                                                            fontSize: 16.0),
                                                      ),

                                                      IconButton(
                                                        icon: Icon(FontAwesomeIcons.calendarDay),
                                                        alignment: Alignment.center,
                                                        iconSize: 21,
                                                        tooltip: 'Change date',
                                                        color: Colors.white,
                                                        onPressed: () async{

                                                          if (_selectedCategory == "View by month"){
                                                            showMonthPicker(
                                                              context: context,
                                                              firstDate: DateTime(DateTime.now().year - 1, 5),
                                                              lastDate: DateTime(DateTime.now().year + 1, 9),
                                                              initialDate: dateTime,
                                                              locale: Locale("en"),
                                                            ).then((date) {
                                                              if (date != null) {
                                                                setState(() {
                                                                  dateTime = date;
                                                                  dateCategory = months[dateTime.month] +
                                                                      " ${dateTime.year}";
                                                                });
                                                              }
                                                            });
                                                          }
                                                          else if (_selectedCategory == "View by year"){
//                                                    DateTime date = await yearPicker(context);
//                                                    if (date != null){
//                                                      setState((){
//                                                        dateTime = date;
//                                                        dateCategory = "${dateTime.year}";
//                                                      });
//                                                    }
                                                            _c.text = dateCategory;
                                                            showDialog(
                                                              context: context,
                                                              builder: (context) {
                                                                return AlertDialog(
                                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                                                  backgroundColor: Color.fromRGBO(40, 41, 41, 1),
                                                                  elevation: 16,
                                                                  title: Text("Set Year",
                                                                      textAlign: TextAlign.center,
                                                                      style: TextStyle(
                                                                          color: Colors.white,
                                                                          fontFamily: 'Century Gothic',
                                                                          fontWeight: FontWeight.normal,
                                                                          fontSize: 20.0)),
                                                                  content: Container(
                                                                    width: 400,
                                                                    height: 200,
                                                                    child: Center(
                                                                      child: Column(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                        children: <Widget>[
                                                                          SizedBox(
                                                                            height: 50,
                                                                          ),

                                                                          Container(
                                                                            width: 100,
                                                                            height: 40,
                                                                            child: TextFormField(
                                                                              controller: _c,
                                                                              maxLength: 4,
                                                                              style: TextStyle(
                                                                                color: Colors.white,
                                                                              ),
                                                                              textAlign: TextAlign.center,
                                                                              decoration: const InputDecoration(
                                                                                icon: Icon(FontAwesomeIcons.calendar, color: Colors.white,),
                                                                                fillColor: Colors.white,
                                                                                hoverColor: Colors.white,
                                                                                focusColor: Colors.white,
                                                                                hintStyle: TextStyle(
                                                                                    fontSize: 16,
                                                                                    color: Colors
                                                                                        .white),
                                                                                enabledBorder: UnderlineInputBorder(
                                                                                  borderSide: BorderSide(color: Colors.white70),
                                                                                ),
                                                                                focusedBorder: UnderlineInputBorder(
                                                                                  borderSide: BorderSide(color: Colors.white),
                                                                                ),
                                                                              ),
                                                                              onSaved: (String value) {
                                                                                // This optional block of code can be used to run
                                                                                // code when the user saves the form.
                                                                              },
                                                                              validator: (String value) {
                                                                                return value.contains('@') ? 'Do not use the @ char.' : null;
                                                                              },
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height: 30,
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                                                                          print(DateTime.now());
                                                                                          dateTime = DateTime.parse(_c.text + '-01-01 00:00:00.000000');
                                                                                          dateCategory = _c.text;
                                                                                        });

                                                                                        Navigator.of(
                                                                                            context)
                                                                                            .pop();
                                                                                      })),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )
                                                                    ,
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                          }
                                                          else if (_selectedCategory == "View by day"){
                                                            DateTime date = await dayPicker(context);
                                                            if (date != null){
                                                              setState((){
                                                                dateTime = date;
                                                                dateCategory = months[dateTime.month] + " ${dateTime.day} ${dateTime.year}";
                                                              });
                                                            }

                                                          }
//                                          showDatePicker(
//                                              context: context,
//                                              initialDate: date_time == null
//                                                  ? DateTime.now()
//                                                  : date_time,
//                                              firstDate: DateTime(2000),
//                                              lastDate: DateTime(2222))
//                                              .then((date) {
//                                            setState(() {
//                                              date_time = date;
//                                            });
//                                          });
//                                setState(() {
//
//                                });
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                ),

                                                const SizedBox(
                                                  width: 1.0,
                                                  height: 30.0,
                                                  child: const DecoratedBox(
                                                    decoration: const BoxDecoration(
                                                        color: Colors.white
                                                    ),
                                                  ),
                                                ),

                                                Container(
                                                  width: 60,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      IconButton(icon: new Image.asset("images/go-icon.png"),
                                                          alignment: Alignment.center,
                                                          iconSize: 21,
                                                          tooltip: 'Sync Chart',
                                                          color: Colors.white,
                                                          onPressed: () async{
                                                            Transaction1 line = await getBalanceNow();
                                                            if (line == null){
                                                              _popUp(context);
                                                            }
                                                            else{
                                                              setState((){

                                                                if (_selectedCategory == "View by day"){
                                                                  chartBalance = double.parse(line.allowance);
                                                                  chartSpent = double.parse(line.spent);
                                                                  chartFareSpent = double.parse(line.fare);
                                                                  chartFoodSpent = double.parse(line.food);
                                                                  chartSchoolWorksSpent = double.parse(line.schoolwork);
                                                                  chartPersonalSpent = double.parse(line.personal);

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
                                                                else{
                                                                  chartBalance = double.parse(line.sumAllowance);
                                                                  chartSpent = double.parse(line.sumSpent);
                                                                  chartFareSpent = double.parse(line.sumFare);
                                                                  chartFoodSpent = double.parse(line.sumFood);
                                                                  chartSchoolWorksSpent = double.parse(line.sumSchoolwork);
                                                                  chartPersonalSpent = double.parse(line.sumPersonal);

                                                                  x1 = chartFareSpent /
                                                                      double.parse(line.sumSpent);
                                                                  y1 = chartFoodSpent /
                                                                      double.parse(line.sumSpent);
                                                                  z1 = chartSchoolWorksSpent /
                                                                      double.parse(line.sumSpent);
                                                                  zz1 =
                                                                      chartPersonalSpent /
                                                                          double.parse(line.sumSpent);
                                                                }
                                                              });
                                                            }
                                                          }
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ]
                                      )
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 20,
                              ),

                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Allowance: ",
                                      style: const TextStyle(
                                          color: Color.fromRGBO(245, 247, 247, 1),
                                          fontFamily: 'CenturyGothic',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                    Text(
                                      "\u20B1",
                                      style: const TextStyle(
                                          color: Color.fromRGBO(245, 247, 247, 1),
                                          fontFamily: 'Poppins',
                                          fontSize: 20.0),
                                    ),
                                    Text(
                                      chartBalance.toString(),
                                      style: const TextStyle(
                                          color: Color.fromRGBO(245, 247, 247, 1),
                                          fontFamily: 'CenturyGothic',
                                          fontSize: 20.0),
                                    ),
                                  ],
                                ),
                              ),


                              SizedBox(
                                height: 10,
                              ),


                              SizedBox(
                                height: 10,
                              ),

                              Column(
                                children: <Widget>[
                                  StatefulBuilder(builder: (context, setState) {
                                    return Center(
                                        child: Column(
                                          children: <Widget>[

                                            InkWell(
                                              onTap: (){
                                                categoryClicked = "Fare";
                                                print(categoryClicked);
//                            print(DateTime.now().hour.toString() + " " + DateTime.now().minute.toString());
                                                showSpendingDialog(context, choice);
                                              },
                                              child: myCardDetails("images/fare.png", "Fare", x1,
                                                  chartFareSpent.toString()),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                categoryClicked = "Food";
                                                print(categoryClicked);
                                                showSpendingDialog(context, choice);
                                              },
                                              child: myCardDetails("images/food.png", "Food", y1,
                                                  chartFoodSpent.toString()),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                categoryClicked = "Schoolwork";
                                                print(categoryClicked);
                                                showSpendingDialog(context, choice);
                                              },
                                              child: myCardDetails("images/schoolwork.png",
                                                  "Schoolwork", z1, chartSchoolWorksSpent.toString()),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                categoryClicked = "Personal";
                                                print(categoryClicked);
                                                showSpendingDialog(context, choice);
                                              },
                                              child: myCardDetails("images/personal.png",
                                                  "Personal", zz1, chartPersonalSpent.toString()),
                                            ),
                                          ],
                                        ));
                                  }),
                                ],
                              ),
                            ],
                          ));
                    }
                )

              ],
            ),
          ],
        ));
  }
}


showYearDialog(BuildContext context){
  String deyt = "";
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: Color.fromRGBO(40, 41, 41, 1),
        elevation: 16,
        title: Text("Set Year",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Century Gothic',
                fontWeight: FontWeight.normal,
                fontSize: 20.0)),
        content: Container(
          width: 400,
          height: 200,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),

                Container(
                  width: 100,
                  height: 40,
                  child: TextFormField(
                    controller: _c,
                    maxLength: 4,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      icon: Icon(FontAwesomeIcons.calendar, color: Colors.white,),
                      fillColor: Colors.white,
                      hoverColor: Colors.white,
                      focusColor: Colors.white,
                      hintStyle: TextStyle(
                          fontSize: 16,
                          color: Colors
                              .white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    onSaved: (String value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    validator: (String value) {
                      return value.contains('@') ? 'Do not use the @ char.' : null;
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                              setState(){
                                deyt = _c.text;
                              }
                              Navigator.of(
                                  context)
                                  .pop();
                            })),
                  ],
                ),
              ],
            ),
          )
          ,
        ),
      );
    },
  );
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
  }else if (categoryName == "Expense") {
    color = Color.fromRGBO(100, 25, 227, 1);
  }else if (categoryName == "Savings") {
    color = Color.fromRGBO(199, 196, 204, 1);
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
    String currencyVal) {
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


List<PieChartSectionData> showingSections() {
  return List.generate(4, (i) {
    final isTouched = i == touchedIndex;
    final double fontSize = isTouched ? 25 : 16;
    final double radius = isTouched ? 80 : 60;
    switch (i) {
      case 0:
        return PieChartSectionData(
          color: Color.fromRGBO(89, 211, 255, 1),
          value: chartFareSpent,
          title: (chartFareSpent/chartSpent*100).toStringAsFixed(2) + '%',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
        );
      case 1:
        return PieChartSectionData(
          color: Color.fromRGBO(224, 227, 14, 1),
          value: chartFoodSpent,
          title: (chartFoodSpent/chartSpent*100).toStringAsFixed(2) + '%',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
        );
      case 2:
        return PieChartSectionData(
          color: Color.fromRGBO(255, 125, 125, 1),
          value: chartSchoolWorksSpent,
          title: (chartSchoolWorksSpent/chartSpent*100).toStringAsFixed(2) + '%',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
        );
      case 3:
        return PieChartSectionData(
          color: Color.fromRGBO(105, 255, 141, 1),
          value: chartPersonalSpent,
          title: (chartPersonalSpent/chartSpent*100).toStringAsFixed(2) + '%',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
        );
      default:
        return null;
    }
  });
}

Widget _createHeader() {
  return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
//      decoration: BoxDecoration(
//          image: DecorationImage(
//              fit: BoxFit.fill,
//              image:  AssetImage('images/black-abstract-background.png'))
//      ),
      child: Stack(children: <Widget>[
        Positioned(
            bottom: 12.0,
            left: 16.0,
            child: Text(" ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500))),
      ]));
}

datePickerr(int choice, BuildContext context) async{

    DateTime newDateTime = await showRoundedDatePicker(
      context: context,
      theme: ThemeData.dark(),
    );


}

_popUp(BuildContext context){
  Scaffold.of(context).removeCurrentSnackBar();
  String deyt;
  if (_selectedCategory == "View by day"){
    deyt = months[dateTime.month] + " ${dateTime.day} ${dateTime.year}";
  }
  else if (_selectedCategory == "View by month"){
    deyt = months[dateTime.month] + " ${dateTime.year}";
  }
  else if (_selectedCategory == "View by year"){
    deyt = "${dateTime.year}";
  }

  SnackBar alertSnackBar = SnackBar(duration:  const Duration(seconds: 1), content: Text("No DATA available for " + deyt, textAlign: TextAlign.center,));
  Scaffold.of(context).showSnackBar(alertSnackBar);
}

Future <DateTime> yearPicker(BuildContext context) async{
  DateTime newDateTime = await showRoundedDatePicker(
    context: context,
    initialDatePickerMode: DatePickerMode.year,
    lastDate:  DateTime(DateTime.now().year + 50),
      theme: ThemeData.dark(),
  );
  return newDateTime;
}
Future <DateTime> dayPicker(BuildContext context) async{
  DateTime newDateTime = await showRoundedDatePicker(
    context: context,
    initialDate: dateTime,
    lastDate:  DateTime(DateTime.now().year + 50),
    theme: ThemeData.dark(),
  );
  return newDateTime;
}

Future<Transaction1> getBalanceNow() async {
  Transaction1 transaction = Transaction1();
  int choice;
  if (_selectedCategory == "View by day"){
    choice = 1;
  }
  else if (_selectedCategory == "View by month"){
    choice = 2;
  }
  else{
    choice = 3;
  }

  transaction.dateStamp =
      dateTime.year.toString() + "0" + dateTime.month.toString() + dateTime.day.toString();
  transaction.id = "00";
  transaction.day = dateTime.day.toString();
  transaction.month = months[dateTime.month];
  transaction.year = dateTime.year.toString();
  transaction.allowance = "00.00";
  transaction.spent = "00.00";
  transaction.saved = "00.00";
  transaction.fare = "00.00";
  transaction.food = "00.00";
  transaction.schoolwork = "00.00";
  transaction.personal = "00.00";

  DatabaseHelper helper = DatabaseHelper.instance;
  Transaction1 line = await helper.getBalanceNow(choice, transaction);
  return line;
}