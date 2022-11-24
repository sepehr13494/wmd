import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';

class AddButton extends StatelessWidget {
  final void Function() onTap;
  final bool addAsset;

  const AddButton({
    Key? key,
    required this.onTap,
    this.addAsset = true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.add_circle_outlined),
            const SizedBox(width: 8),
            Text((ResponsiveHelper(context: context).isMobile || !addAsset) ? "Add" : "Add asset")
          ],
        ));
  }
}