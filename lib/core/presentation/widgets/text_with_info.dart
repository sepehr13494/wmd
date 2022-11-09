import 'package:flutter/material.dart';

class TextWithInfo extends StatelessWidget {
  final String title;
  final bool hasInfo;
  final dynamic onInfoTap;
  const TextWithInfo({Key? key, required this.title, this.onInfoTap, required this.hasInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title),
        const SizedBox(width: 4),
        hasInfo? InkWell(
          onTap: onInfoTap,
          child: Icon(Icons.info_outline,color: Theme.of(context).primaryColor,size: 15,),
        ) : const SizedBox()
      ],
    );
  }
}
