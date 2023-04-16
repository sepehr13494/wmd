import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';

class ModalWidget extends StatelessWidget {
  final String title, body, confirmBtn, cancelBtn;

  const ModalWidget({
    super.key,
    required this.title,
    this.body = '',
    this.confirmBtn = ".",
    this.cancelBtn = ".",
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Dialog(
            insetPadding:
                const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: buildDialogContent(context)));
  }

  Widget buildDialogContent(BuildContext context) {
    final appTextTheme = Theme.of(context).textTheme;
    final responsiveHelper = ResponsiveHelper(context: context);
    final isMobile = responsiveHelper.isMobile;

    return SizedBox(
      width: double.infinity,
      height: isMobile
          ? MediaQuery.of(context).size.height * 0.7
          : MediaQuery.of(context).size.height * 0.4,
      child: Column(
        children: [
          buildModalHeader(context),
          Expanded(
              flex: 2,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: responsiveHelper.bigger16Gap,
                          horizontal: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            title,
                            textAlign: TextAlign.center,
                            style: appTextTheme.titleLarge,
                          ),
                          SizedBox(height: responsiveHelper.defaultGap),
                          Text(
                            body,
                            textAlign: TextAlign.center,
                            style: appTextTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    buildActionContainer(context),
                    SizedBox(
                      height: responsiveHelper.bigger16Gap * 3,
                    )
                  ]))
        ],
      ),
    );
  }

  ///  Action Buttons Container of Modal
  Widget buildActionContainer(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        OutlinedButton(
          onPressed: () => Navigator.pop(context, false),
          style: OutlinedButton.styleFrom(minimumSize: const Size(100, 50)),
          child: Text(
            cancelBtn,
          ),
        ),
        const SizedBox(width: 20),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, true),
          style: ElevatedButton.styleFrom(minimumSize: const Size(100, 50)),
          child: Text(confirmBtn),
        ),
      ],
    );
  }

  /// Modal Header with close button
  Widget buildModalHeader(BuildContext context, {Function? onClose}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
            onPressed: () {
              if (onClose != null) {
                onClose();
              } else {
                Navigator.pop(context, false);
              }
              // onClose ?? Navigator.pop(context, false);
              // GoRouter.of(context).goNamed(AppRoutes.dashboard);
            },
            icon: Icon(
              Icons.close,
              color: Theme.of(context).primaryColor,
            )),
      ],
    );
  }
}
