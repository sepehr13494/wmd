import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/info_icon.dart';

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
          child: const InfoIcon(),
        ) : const SizedBox()
      ],
    );
  }
}
