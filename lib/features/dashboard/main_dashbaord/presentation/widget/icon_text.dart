import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wmd/core/util/app_stateless_widget.dart';
import 'package:wmd/core/util/colors.dart';

class IconText extends AppStatelessWidget {
  final String image;
  final String text;
  const IconText({
    Key? key,
    required this.image,
    required this.text,
  }) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Container(
      constraints: const BoxConstraints(minWidth: 264, maxWidth: 264),
      alignment: Alignment.center,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 32),
            child: SizedBox(
              height: 150,
              width: 150,
              child: SvgPicture.asset(
                image,
                height: 120,
                width: 120,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: Text(
              text,
              style: textTheme.labelMedium
                  ?.apply(color: AppColors.dashBoardGreyTextColor)
                  .copyWith(fontSize: 14, height: 1.2),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
