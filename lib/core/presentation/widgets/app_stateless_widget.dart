import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class AppStatelessWidget extends StatelessWidget {
  const AppStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return buildWidget(
        context, Theme.of(context).textTheme, AppLocalizations.of(context));
  }

  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations);
}

abstract class AppState<T extends StatefulWidget> extends State<T> {
  @override
  Widget build(BuildContext context) {
    return buildWidget(
        context, Theme.of(context).textTheme, AppLocalizations.of(context));
  }

  @protected
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations);
}

abstract class AppStateAlive<T extends StatefulWidget> extends State<T>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return buildWidget(
        context, Theme.of(context).textTheme, AppLocalizations.of(context));
  }

  @protected
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations);
}
