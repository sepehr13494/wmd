import 'package:flutter/material.dart';

class EachTextField extends StatelessWidget {
  final String title;
  final bool hasInfo;
  final void Function()? onInfoTap;
  final Widget child;

  const EachTextField(
      {Key? key,
      required this.title,
      this.hasInfo = true,
      this.onInfoTap,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(title),
            const SizedBox(width: 4),
            hasInfo? InkWell(
              onTap: onInfoTap,
              child: Icon(Icons.info_outline,color: Theme.of(context).primaryColor,size: 15,),
            ) : const SizedBox()
          ],
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}
