import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil {

  static const int success = 0;
  static const int worning = 1;
  static const int error = 2;

  static void showToast (String message, int kind ){
    switch(kind) {
      case 0 : Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 12.0);
      break;

      case 1 : Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.orange,
          textColor: Colors.white,
          fontSize: 12.0);
      break;

      case 2 : Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 12.0);
      break;
    }
  }
}