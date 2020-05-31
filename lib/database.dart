import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

Database _database;

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

}

Future<Database> get database async {

  if (_database != null)
    return _database;

  // if _database is null we instantiate it
  _database = await initDB();
  return _database;
}

initDB() async {
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String path = join(documentsDirectory.path, "Budgeter.db");
  return await openDatabase(path, version: 1, onOpen: (db) {
  }, onCreate: (Database db, int version) async {
    await db.execute("CREATE TABLE Client ("
        "CREATE TABLE IF NOT EXISTS transaction(date_stamp DATE PRIMARY KEY, id INTEGER, day VARCHAR, "
        "month VARCHAR, year VARCHAR, allowance DECIMAL, spent DECIMAL, saved DECIMAL, fare DECIMAL, food DECIMAL, schoolwork DECIMAL, personal DECIMAL"
        ")");
  });
}



void main() async {
  await print(database);


  Future<void> insertDog(Transaction transaction) async {
    final Database db = await database;

    await db.insert(
      'transaction',
      transaction.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertTransaction(Transaction transaction) async {
    // Get a reference to the database.
    final Database db = await database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'transaction',
      transaction.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  await insertTransaction(trans);

  Future<List<Transaction>> transactions() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('transaction');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Transaction(
        date_stamp: maps[i]['date_stamp'],
        id: maps[i]['id'],
        day: maps[i]['day'],
        month: maps[i]['month'],
        year: maps[i]['year'],
        allowance: maps[i]['allowance'],
        spent: maps[i]['spent'],
        saved: maps[i]['saved'],
        fare: maps[i]['fare'],
        food: maps[i]['food'],
        schoolwork: maps[i]['schoolwork'],
        personal: maps[i]['personal'],
      );
    });
  }

  print(await transactions());

}

class Transaction {
  final String date_stamp;
  final int id;
  final String day;
  final String month;
  final String year;
  final double allowance;
  final double spent;
  final double saved;
  final double fare;
  final double food;
  final double schoolwork;
  final double personal;

  Transaction({this.date_stamp, this.id, this.day, this.month, this.year, this.allowance, this.spent, this.saved,
    this.fare, this.food, this.schoolwork, this.personal});

  Map<String, dynamic> toMap() {
    return {
      'date_stamp': date_stamp,
      'id': id,
      'day': day,
      'month': month,
      'year': year,
      'allowance': allowance,
      'spent': spent,
      'saved': saved,
      'fare': fare,
      'food': food,
      'schoolwork': schoolwork,
      'personal': personal,
    };
  }
}

final trans = Transaction(
  date_stamp: "2000-08-19",
  id: 00,
  day: "1",
  month: "AUG",
  year: "2000",
  allowance: 1000,
  spent: 0,
  saved: 1000,
  fare: 0,
  food: 0,
  schoolwork: 0,
  personal: 0,
);

