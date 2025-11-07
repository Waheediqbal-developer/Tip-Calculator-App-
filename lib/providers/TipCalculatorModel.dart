import 'package:flutter/material.dart';

class Tipcalculatormodel extends ChangeNotifier {
  int _personCount = 1;
  double _tipPercentage = 0.0;
  double _billTotal = 0.0;

  //getters 
  double get billTotal => _billTotal;
  double get tipPercentage => _tipPercentage;
  int get personCount => _personCount;


  //Methods 

  void updateBillTotal (double billTotal){
    _billTotal = billTotal;
    notifyListeners();
  }

  void updateTipPercentage(double tipPercentage){
    _tipPercentage = tipPercentage;
    notifyListeners();
  }

  void updatePersonCount (int personCount){
    _personCount = personCount;
    notifyListeners();
  }

  double get totalPerPerson {
    return ((_billTotal * _tipPercentage) + (_billTotal)) / _personCount;
  }

  void increment(){
    _personCount++;
    notifyListeners();
  }

  void decrement(){
    if(_personCount > 1){
      _personCount--;
      notifyListeners();
    }
  }
}