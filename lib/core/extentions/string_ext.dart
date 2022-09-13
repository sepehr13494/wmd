import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension StringExt on String{
  String addZeroToStart({int maxDigits = 2}){
    if(length < maxDigits){
      return "${"0"*(maxDigits-length)}$this";
    }else{
      return this;
    }
  }

  String convertMoney(double money, {int digits = 0}){
    String s = '';
    for(int i=0 ; i<digits ; i++){
      s += "0";
    }
    return NumberFormat("#,##0${digits == 0 ? '' : '.$s'}", "en_US").format(money);
  }

  String stringifyError(String error){
    return error.replaceAll('"', "")
        .replaceAll("{", "")
        .replaceAll("}", "")
        .replaceAll("[", "")
        .replaceAll("]", "");
  }
}