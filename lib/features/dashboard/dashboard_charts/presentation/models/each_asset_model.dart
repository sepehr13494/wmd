import 'package:flutter/material.dart';

class EachAssetViewModel {
  final Color? color;
  final String name;
  final String price;
  final double value;
  final String percentage;

  EachAssetViewModel({
    this.color,
    required this.name,
    required this.price,
    required this.value,
    required this.percentage,
  });
}
