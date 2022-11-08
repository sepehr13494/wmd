import 'package:flutter/material.dart';

class EachAssetViewModel {
  final Color? color;
  final String name;
  final String price;
  final String percentage;

  EachAssetViewModel({
    this.color,
    required this.name,
    required this.price,
    required this.percentage,
  });
}
