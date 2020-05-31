import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:workingproject/homepage.dart';

// database table and column names
final String tableTransaction = 'transaction11';
final String columnDateStamp = '_date_stamp';
final String columnId = 'id';
final String columnDay = 'day';
final String columnMonth = 'month';
final String columnYear = 'year';
final String columnAllowance = 'allowance';
final String columnSpent = 'spent';
final String columnSaved = 'saved';
final String columnFare = 'fare';
final String columnFood = 'food';
final String columnSchoolwork = 'schoolwork';
final String columnPersonal = 'personal';
final String columnCategory = 'category';
final String columnDescription = 'description';
final String columnTime = 'time';

// data model class
class Transaction1 {

  String dateStamp;
  String id;
  String day;
  String month;
  String year;
  String allowance;
  String spent;
  String saved;
  String fare;
  String food;
  String schoolwork;
  String personal;
  String category;
  String description;
  String sumAllowance;
  String sumSpent;
  String sumSaved;
  String sumFare;
  String sumFood;
  String sumSchoolwork;
  String sumPersonal;
  String time;



  Transaction1();

  // convenience constructor to create a Word object
  Transaction1.fromMap(Map<dynamic, dynamic> map) {

    dateStamp = map[columnDateStamp].toString();
    id = map[columnId].toString();
    day = map[columnDay].toString();
    month = map[columnMonth].toString();
    year = map[columnYear].toString();
    allowance = map[columnAllowance].toString();
    spent = map[columnSpent].toString();
    saved = map[columnSaved].toString();
    fare = map[columnFare].toString();
    food = map[columnFood].toString();
    schoolwork = map[columnSchoolwork].toString();
    personal = map[columnPersonal].toString();
    category = map[columnCategory].toString();
    description = map[columnDescription].toString();
    time = map[columnTime].toString();


    sumAllowance = map["SUM (allowance)"].toString();
    sumSpent = map["SUM (spent)"].toString();
    sumSaved = map["SUM (saved)"].toString();
    sumFare = map["SUM (fare)"].toString();
    sumFood = map["SUM (food)"].toString();
    sumSchoolwork = map["SUM (schoolwork)"].toString();
    sumPersonal = map["SUM (personal)"].toString();
  }

  // convenience method to create a Map from this Transaction object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnDateStamp: dateStamp,
      columnId: id,
      columnDay: day,
      columnMonth: month,
      columnYear: year,
      columnAllowance: allowance,
      columnSpent: spent,
      columnSaved: saved,
      columnFare: fare,
      columnFood: food,
      columnSchoolwork: schoolwork,
      columnPersonal: personal,
      columnCategory: category,
      columnDescription: description,
      columnTime: time
    };

    return map;
  }
}

// singleton class to manage the database
class DatabaseHelper {

  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "MyDatabase.db";
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 1;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // open the database
  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $tableTransaction (
                $columnDateStamp STRING PRIMARY KEY,
                $columnId INTEGER NOT NULL,
                $columnDay TEXT NOT NULL,
                $columnMonth TEXT NOT NULL,
                $columnYear TEXT NOT NULL,
                $columnAllowance DECIMAL NOT NULL,
                $columnSpent DECIMAL NOT NULL,
                $columnSaved DECIMAL NOT NULL,
                $columnFare DECIMAL NOT NULL,
                $columnFood DECIMAL NOT NULL,
                $columnSchoolwork DECIMAL NOT NULL,
                $columnPersonal DECIMAL NOT NULL
              )
              
              
              ''');
    await db.execute('''
              CREATE TABLE spendingHistory (
              $columnDateStamp STRING NOT NULL,
              $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
              $columnDay TEXT NOT NULL,
              $columnMonth TEXT NOT NULL,
              $columnYear TEXT NOT NULL,
              $columnSpent DECIMAL NOT NULL,
              category STRING NOT NULL,
              description STRING,
              time STRING NOT NULL
              )
              ''');
  }

  // Database helper methods:

  Future<String> insertSpend(Transaction1 transaction) async {
    Database db = await database;

    List<Map> maps = await db.query
      (tableTransaction,
        columns: [columnDateStamp, columnId, columnDay, columnMonth, columnYear,
          columnAllowance, columnSpent, columnSaved, columnFare, columnFood, columnSchoolwork, columnPersonal],
        where: '$columnDateStamp = ' + transaction.dateStamp);
//    double add = transaction.allowance;
//    The add variable is for the altering of the data when updating something that needs to be updated in
//    the ROW without deleting OR replacing the data in that cell
    if (maps.length > 0) {
      await db.execute("UPDATE transaction11 SET spent = spent + " + transaction.spent.toString() +  ", saved = allowance - " + transaction.spent.toString() + ", fare = fare + " + transaction.fare.toString() + ", food = food + " + transaction.food.toString() + ", schoolwork = schoolwork + " + transaction.schoolwork.toString() + ", personal = personal + " + transaction.personal.toString() + " WHERE _date_stamp = " + transaction.dateStamp.toString() + ";");
    }
    else{
      return "ERROR";
    }
    return "SUCCESS";
  }

  insertSpendHistory(Transaction1 transaction) async {
    Database db = await database;

    await db.execute("INSERT INTO spendingHistory (" '$columnDateStamp, $columnId, $columnDay, $columnMonth, $columnYear, $columnSpent' + ", category, description, time) VALUES (" + transaction.dateStamp + ", " + transaction.id + ", " + '"' +  transaction.day + '"' + ", " + '"' +  transaction.month + '"' +  ", " + '"' + transaction.year + '"' +  ", " + transaction.spent + ", " + '"' + transaction.category + '"' + ", " + '"' + transaction.description + '"' + ", " + '"' + transaction.time + '"' + ");");
  }

  deleteSpendHistory(Transaction1 transaction) async {
    Database db = await database;
    print("DELETE FROM spendingHistory WHERE category = " + '"' + transaction.category.trim() + '"' + " AND description = " + '"' + transaction.description.trim() + '"' + " AND spent = " + transaction.spent.trim() + ";");
    await db.execute("DELETE FROM spendingHistory WHERE category = " + '"' + transaction.category.trim() + '"' + " AND description = " + '"' + transaction.description.trim() + '"' + " AND _date_stamp = + " + transaction.dateStamp.trim() + ";");
  }

  Future<String> insertAdd(Transaction1 transaction) async {
    Database db = await database;

    List<Map> maps = await db.query
      (tableTransaction,
        columns: [columnDateStamp, columnId, columnDay, columnMonth, columnYear,
          columnAllowance, columnSpent, columnSaved, columnFare, columnFood, columnSchoolwork, columnPersonal],
        where: '$columnDateStamp = ' + transaction.dateStamp);
//    double add = transaction.allowance;
//    The add variable is for the altering of the data when updating something that needs to be updated in
//     the ROW without deleting OR replacing the data in that cell
    if (maps.length > 0) {
      await db.execute("UPDATE transaction11 SET allowance = allowance + " + transaction.allowance.toString() + ", saved = saved + " + transaction.allowance.toString() + " WHERE _date_stamp = " + transaction.dateStamp.toString() + ";");
    }
    else{
      await db.execute("INSERT INTO transaction11 (" '$columnDateStamp, $columnId, $columnDay, $columnMonth, $columnYear, $columnAllowance, $columnSpent, $columnSaved, $columnFare, $columnFood, $columnSchoolwork, $columnPersonal' + ") VALUES (" + transaction.dateStamp + ", " + transaction.id + ", " + '"' +  transaction.day + '"' + ", " + '"' +  transaction.month + '"' +  ", " + '"' + transaction.year + '"' +  ", "  + transaction.allowance + ", " + transaction.spent + ", " + transaction.saved + ", " + transaction.fare + ", " + transaction.food + ", " + transaction.schoolwork + ", " + transaction.personal + ");");

    }
    return "SUCCESS";
  }

  Future<Transaction1> getBalance(Transaction1 transaction) async {
    Database dbClient = await database;
    // specify the column names you want in the result set
    List<Map> maps =
    await dbClient.query(
        tableTransaction, columns: [columnAllowance, columnSpent, columnSaved, columnFare, columnFood, columnSchoolwork, columnPersonal],
        where: '$columnDateStamp = ' + transaction.dateStamp);
    Transaction1 allAlbums = Transaction1();
    List<Transaction1> transact = [];
    if (maps.length > 0) {
      allAlbums = Transaction1.fromMap(maps.first);
    }
    else{
      return null;
    }
    return allAlbums;
  }

  Future<Transaction1> getBalanceNow(int choice, Transaction1 transaction) async {
    Database dbClient = await database;
    // specify the column names you want in the result set
    List<Map> maps;

    if (choice == 1){
      maps =
      await dbClient.query(
          tableTransaction, columns: [columnAllowance, columnSpent, columnSaved, columnFare, columnFood, columnSchoolwork, columnPersonal],
          where: '$columnDateStamp = ' + transaction.dateStamp);
    }
    else if (choice == 2){
    maps = await dbClient.rawQuery("SELECT SUM (" + columnAllowance + "), SUM (" + columnSpent + "), SUM (" + columnSaved + "), SUM (" + columnFare + "), SUM (" + columnFood + "), "
        "SUM (" + columnSchoolwork + "), SUM (" + columnPersonal + ") " + " FROM transaction11 WHERE " + columnMonth + " = " + '"' + transaction.month + '"' + " AND " + columnYear + " = " + '"' + transaction.year + '"');
    }
    else{
      maps = await dbClient.rawQuery("SELECT SUM (" + columnAllowance + "), SUM (" + columnSpent + "), SUM (" + columnSaved + "), SUM (" + columnFare + "), SUM (" + columnFood + "), "
          "SUM (" + columnSchoolwork + "), SUM (" + columnPersonal + ") " + " FROM transaction11 WHERE " + columnYear + " = " + '"' + transaction.year + '"');
    }

    Transaction1 allAlbums = Transaction1();
    List<Transaction1> transact = [];
    if (maps.length > 0) {
      allAlbums = Transaction1.fromMap(maps.first);
    }
    else{
      return null;
    }
    return allAlbums;
  }

  Future<List> getAllRecords(String dbTable) async {
    var dbClient = await database;
    var result = await dbClient.rawQuery("SELECT * FROM $dbTable");

    return result.toList();
  }


// TODO: queryAllWords()
// TODO: delete(int id)
// TODO: update(Word word)
}