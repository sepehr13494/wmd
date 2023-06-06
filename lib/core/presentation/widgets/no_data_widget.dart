import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SvgPicture.asset("assets/images/no_result.svg",width: 30,height: 30,),
          Text(AppLocalizations.of(context).common_glossary_noDataFoundHeading,style: Theme.of(context).textTheme.titleMedium,),
          Text(AppLocalizations.of(context).common_glossary_noDataFoundSubHeading),
        ].map((e) => Padding(padding: const EdgeInsets.all(4),child: e,)).toList(),
      ),
    );
  }
}
