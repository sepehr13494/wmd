import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/text_with_info.dart';

class EachTextField extends StatelessWidget {
  final String title;
  final bool hasInfo;
  final void Function()? onInfoTap;
  final Widget child;
  final bool showRequired;

  const EachTextField(
      {Key? key,
      required this.title,
      this.hasInfo = true,
      this.onInfoTap,
      this.showRequired = false,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWithInfo(
            title: title, hasInfo: hasInfo, showRequired: showRequired),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}
