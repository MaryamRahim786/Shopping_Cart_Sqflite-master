import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_cartt/Model/cart_model.dart';
import 'package:shopping_cartt/db_helper.dart';

class CartProvider with ChangeNotifier {
//!initialize dbHelper class
  DBHelper db = DBHelper();

  //For Counter
  int _counter = 0;
  //Getter Method
  int get counter => _counter;

  double _totalPrice = 0.0;
  //Getter Method
  double get totallPrice => _totalPrice;

  //!for cart provider
  //!Initilize cart
  late Future<List<Cart>> _cart;
//!Getter method to get cart
  Future<List<Cart>> get cart => _cart;

  Future<List<Cart>> getData() async {
    _cart = db.getCardList();
    return _cart;
  }

  //!Shared Preferneces

  void _setProfItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cart_item', _counter);
    prefs.setDouble('total_price', _totalPrice);
    notifyListeners();
  }

  void _getProfItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt('cart_item') ?? 0;
    prefs.getDouble('total_price') ?? 0.0;
    notifyListeners();
  }
//todos COMMENTS
//?COMMENTS
//^COMMENTS
//&COMMENTS

  //!FOR INCREMENT
  void addCounter() {
    _counter++;
    _setProfItems();
    notifyListeners();
  }

  //!For DECREMENT
  void removeCounter() {
    _counter--;
    _setProfItems();
    notifyListeners();
  }

  //!get counter
  int getCounter() {
    _getProfItems();
    return _counter;
  }

//!FOR TOTAL PRICE
  //!FOR INCREMENT
  void addTotalPrice(double productPrice) {
    _totalPrice = _totalPrice + productPrice;
    _setProfItems();
    notifyListeners();
  }

  //!For DECREMENT
  void removeTotalPrice(double productPrice) {
    _totalPrice = _totalPrice - productPrice;
    _setProfItems();
    notifyListeners();
  }

  //!get counter
  double getTotalPrice() {
    _getProfItems();
    return _totalPrice;
  }
}
