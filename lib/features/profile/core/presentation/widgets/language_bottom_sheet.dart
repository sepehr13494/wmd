import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/util/app_localization.dart';
import 'package:wmd/core/util/firebase_analytics.dart';

class LanguageBottomSheet extends AppStatelessWidget {
  const LanguageBottomSheet({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return SizedBox(
      height: 240,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: textTheme.titleMedium!.color!.withOpacity(0.3)),
          ),
          SizedBox(
            width: double.maxFinite,
            child: Stack(
              children: [
                Center(
                    child: Text(
                  appLocalizations.profile_preferences_language,
                  style: textTheme.titleSmall,
                )),
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .color!
                          .withOpacity(0.3)),
                  padding: const EdgeInsets.all(4),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      size: 15,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                )
              ],
            ),
          ),
          Builder(builder: (context) {
            List<Locale> locales =
                AppLocalizations.supportedLocales.reversed.toList();
            return ListView.separated(
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                Locale e = locales[index];
                return InkWell(
                  onTap: () {
                    AnalyticsUtils.triggerEvent(
                        action: AnalyticsUtils.changePasswordAction,
                        params: AnalyticsUtils.changePasswordEvent);

                    context.read<LocalizationManager>().changeLang(e);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(LocalizationManager.getNameFromLocale(e)),
                        context
                                    .read<LocalizationManager>()
                                    .state
                                    .languageCode ==
                                e.languageCode
                            ? const Icon(Icons.check, color: Colors.lightBlue)
                            : const SizedBox()
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, _) => const Divider(),
              itemCount: locales.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
            );
          })
        ]
            .map((e) => Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: e,
                ))
            .toList(),
      ),
    );
  }
}
