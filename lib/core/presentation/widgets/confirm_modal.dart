import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/modal_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';

class ConfirmModal extends ModalWidget {
  const ConfirmModal({
    super.key,
    required super.title,
    super.body,
    super.confirmBtn,
    super.cancelBtn,
  });

  @override
  Widget buildDialogContent(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final responsiveHelper = ResponsiveHelper(context: context);

    return SingleChildScrollView(
        child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            child: Column(children: [
              buildModalHeader(context),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  title,
                  style: textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: responsiveHelper.bigger16Gap * 3.5),
                    child: Text(
                      body,
                      style: textTheme.bodyMedium!.copyWith(fontSize: 14),
                      textAlign: TextAlign.center,
                    )),
                const SizedBox(
                  height: 40,
                ),
                buildActionContainer(context),
              ]),
              const SizedBox(
                height: 40,
              ),
            ])));
  }
}
