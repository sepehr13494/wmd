import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';

class CenterModalWidget extends StatelessWidget {
  final Widget body;
  final Widget? actions;
  final String? confirmBtn;
  final String? cancelBtn;
  final EdgeInsets contentPadding;

  const CenterModalWidget({
    super.key,
    required this.body,
    this.actions,
    this.confirmBtn,
    this.cancelBtn,
    this.contentPadding = const EdgeInsets.all(24.0),
  });

  @override
  Widget build(BuildContext context) {
    // final appTextTheme = Theme.of(context).textTheme;
    final responsiveHelper = ResponsiveHelper(context: context);
    final isMobile = responsiveHelper.isMobile;

    return BackdropFilter(
      // filter: ImageFilter.dilate(),
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      child: Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        alignment: Alignment.center,
        child: SizedBox(
          width: isMobile ? double.infinity : WIDTH_MOBILE,
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildModalHeader(context),
                  Padding(
                    padding: contentPadding,
                    child: body,
                  ),
                  if (actions == null) buildActionContainer(context),
                  if (actions != null) SizedBox(child: actions),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ///  Action Buttons Container of Modal
  Widget buildActionContainer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        // mainAxisSize: MainAxisSize.min,
        children: [
          if (cancelBtn != null)
            OutlinedButton(
              onPressed: () => Navigator.pop(context, false),
              style: OutlinedButton.styleFrom(minimumSize: const Size(100, 50)),
              child: Text(cancelBtn!),
            ),
          const SizedBox(width: 16),
          if (confirmBtn != null)
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(minimumSize: const Size(100, 50)),
              child: Text(confirmBtn!),
            ),
        ],
      ),
    );
  }

  Widget buildModalHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close)),
      ],
    );
  }
}
