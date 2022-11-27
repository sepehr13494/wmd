import 'package:flutter/material.dart';

class InfoIcon extends StatelessWidget {
  const InfoIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.info_outline,color: Theme.of(context).primaryColor,size: 15,);
  }
}