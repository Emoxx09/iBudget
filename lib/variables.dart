import 'package:scoped_model/scoped_model.dart';

class AppGlobalVarss extends Model{
  DateTime _dateTime = DateTime.now();
  double _balance = 00.00;
  double _expense = 00.00;

  double get balance => _balance;

  void changeBalance(double balance){
    this._balance = balance;
    notifyListeners();
  }
}