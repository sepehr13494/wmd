import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/liability_overview/domain/entities/get_liablility_overview_entity.dart';

class LiabilitiesPagination extends StatefulWidget {
  final List<GetLiablilityOverviewEntity> liabilities;
  const LiabilitiesPagination({
    Key? key,
    required this.liabilities,
  }) : super(key: key);

  @override
  AppState<LiabilitiesPagination> createState() =>
      _LiabilitiesPaginationState();
}

class _LiabilitiesPaginationState extends AppState<LiabilitiesPagination> {
  int count = 0;
  final int initial = 5;
  final int add = 5;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    if (widget.liabilities.length > initial) {
      count = initial;
    } else {
      count = widget.liabilities.length;
    }
  }

  void loadMore() {
    setState(() {
      if (widget.liabilities.length > count + add) {
        count = count + add;
      } else {
        count = widget.liabilities.length;
      }
    });
  }

  @override
  Widget buildWidget(BuildContext context, textTheme, appLocalizations) {
    return Column(
      children: [
        ...List.generate(count, (index) {
          final item = widget.liabilities[index];
          return _buildLiability(context, item, index);
        }),
        if (count == widget.liabilities.length && count > initial)
          InkWell(
            onTap: () {
              setState(() {
                init();
              });
            },
            child: Card(
              child: SizedBox(
                width: double.maxFinite,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      appLocalizations.common_button_viewLess,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
              ),
            ),
          ),
        if (count < widget.liabilities.length)
          InkWell(
            onTap: () {
              loadMore();
            },
            child: Card(
              child: SizedBox(
                width: double.maxFinite,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      appLocalizations.common_button_viewMore,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  InkWell _buildLiability(
      BuildContext context, GetLiablilityOverviewEntity item, int index) {
    return InkWell(
      onTap: () {
        // context.goNamed(AppRoutes.li,
        //     queryParams: {'assetId': item.assetId, 'type': item.type});
      },
      child: Card(
        color: index % 2 == 0
            ? null
            : Theme.of(context).brightness == Brightness.dark
                ? AppColors.darkCardColorForDarkTheme
                : AppColors.darkCardColorForLightTheme,
        child: ResponsiveWidget(
            mobile: LiabilityCardMobile(item: item),
            tablet: LiabilityCardTablet(item: item),
            desktop: LiabilityCardTablet(item: item)),
      ),
    );
  }
}

class LiabilityCardMobile extends StatelessWidget {
  final GetLiablilityOverviewEntity item;
  const LiabilityCardMobile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class LiabilityCardTablet extends StatelessWidget {
  final GetLiablilityOverviewEntity item;
  const LiabilityCardTablet({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
