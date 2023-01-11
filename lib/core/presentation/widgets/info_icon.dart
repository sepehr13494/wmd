import 'package:flutter/material.dart';

class InfoIcon extends StatelessWidget {
  final IconData? icon;
  const InfoIcon({
    Key? key,
    this.icon = Icons.info_outline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: Theme.of(context).primaryColor,
      size: 15,
    );
  }
}
