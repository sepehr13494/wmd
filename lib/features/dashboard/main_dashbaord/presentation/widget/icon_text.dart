import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/util/colors.dart';

class IconText extends AppStatelessWidget {
  final String image;
  final String text;
  final String type;
  const IconText({
    Key? key,
    required this.image,
    required this.text,
    this.type = "default",
  }) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Container(
      // constraints: const BoxConstraints(minWidth: 264, maxWidth: 264),
      alignment: Alignment.center,
      child: Column(
        children: [
          Padding(
            padding:
                EdgeInsets.fromLTRB(10, 10, 10, type == "security" ? 0 : 10),
            child: SizedBox(
              height: 150,
              width: 150,
              child: image.split('.').last == 'svg'
                  ? SvgPicture.asset(image,
                      height: type == "security" ? 80 : 120,
                      width: type == "security" ? 80 : 120,
                      fit: BoxFit.scaleDown)
                  : Image.asset(
                      image,
                      height: 120,
                      width: 120,
                      fit: BoxFit.fitWidth,
                    ),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.fromLTRB(20, type == "security" ? 0 : 15, 20, 15),
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
