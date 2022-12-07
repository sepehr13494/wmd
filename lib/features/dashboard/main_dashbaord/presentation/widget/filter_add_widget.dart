import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wmd/core/presentation/routes/app_routes.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/local_storage.dart';
import 'package:wmd/injection_container.dart';

class FilterAddPart extends AppStatelessWidget {
  const FilterAddPart({Key? key}) : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    final bool isMobile = ResponsiveHelper(context: context).isMobile;
    return Row(
      children: [
        Text("Wealth Overview", style: textTheme.headlineSmall),
        const Spacer(),
        Row(
          children: [
            SizedBox(
              height: 32,
              child: OutlinedButton(
                onPressed: () {},
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    children: [
                      const Icon(Icons.filter_alt, size: 15),
                      isMobile
                          ? const SizedBox()
                          : Row(
                              children: const [
                                SizedBox(width: 8),
                                Text("Filter"),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              height: 32,
              child: ElevatedButton(
                onPressed: () {
                  context.pushNamed(AppRoutes.addAssetsView);
                },
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    children: [
                      const Icon(Icons.add_circle, size: 15),
                      isMobile
                          ? const SizedBox()
                          : Row(
                              children: const [
                                SizedBox(width: 8),
                                Text("Add"),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
