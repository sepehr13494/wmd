/*
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';

class FirstFlexObj<T extends TreeChartObj> {
  final double flex;
  final List<T> items;

  FirstFlexObj({
    required this.flex,
    required this.items,
  });
}

abstract class TreeChartObj with EquatableMixin {
  final double value;

  const TreeChartObj({
    required this.value,
  });
}

class BaseTreeChartWidget<T extends TreeChartObj> extends AppStatelessWidget {
  final List<T> treeChartObjs;
  final Widget Function(T, int) itemBuilder;

  const BaseTreeChartWidget(
      {Key? key, required this.treeChartObjs, required this.itemBuilder})
      : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    List<T> realItems = treeChartObjs;
    realItems.sort(
      (a, b) => (b.value - a.value).toInt(),
    );
    final List<double> items = realItems.map((e) => e.value).toList();
    double sum = items.reduce((a, b) => a + b);
    double leftover = sum;
    List<FirstFlexObj<T>> firstFlexes = [];
    List<double> secondFlexes = [];
    items.sort(
      (a, b) => (b - a).toInt(),
    );
    print(items);
    for (int i = 0; i < items.length; i++) {
      if (((items[i]) * 2 < leftover - items[i]) && i != items.length - 1) {
        if (((items[i] + items[i + 1]) * 2 <
                leftover - (items[i] + items[i + 1])) &&
            i != items.length - 2) {
          firstFlexes.add(FirstFlexObj(
              flex: (items[i] + items[i + 1] + items[i + 2]) / leftover,
              items: [realItems[i], realItems[i + 1], realItems[i + 2]]));
          secondFlexes.add(
              (leftover - (items[i] + items[i + 1] + items[i + 2])) / leftover);
          leftover = leftover - (items[i] + items[i + 1] + items[i + 2]);
          i = i + 2;
        } else {
          firstFlexes.add(FirstFlexObj(
              flex: (items[i] + items[i + 1]) / leftover,
              items: [realItems[i], realItems[i + 1]]));
          secondFlexes.add((leftover - (items[i] + items[i + 1])) / leftover);
          leftover = leftover - (items[i] + items[i + 1]);
          i++;
        }
      } else {
        firstFlexes.add(
            FirstFlexObj(flex: items[i] / leftover, items: [realItems[i]]));
        secondFlexes.add((leftover - items[i]) / leftover);
        leftover = leftover - items[i];
      }
    }
    firstFlexes = firstFlexes.reversed.toList();
    secondFlexes = secondFlexes.reversed.toList();
    generateWidget({
      required Widget child,
      required FirstFlexObj<T> firstFlex,
      required double secondFlex,
      required int itemIndex,
    }) {
      return LayoutBuilder(
        builder: (context, snap) {
          return RowOrColumn(
            showRow: snap.maxWidth > snap.maxHeight,
            children: [
              firstFlex.flex == 0
                  ? const SizedBox()
                  : Expanded(
                      flex: (firstFlex.flex * sum).ceil(),
                      child: RowOrColumn(
                        showRow: !(snap.maxWidth > snap.maxHeight),
                        children: List.generate(
                          firstFlex.items.length,
                          (index) {
                            final flexItem = firstFlex.items[index];
                            return Expanded(
                              flex: (flexItem.value * 100).toInt(),
                              child: SizedBox(
                                width: double.maxFinite,
                                height: double.maxFinite,
                                child: itemBuilder(flexItem,itemIndex-((firstFlex.items.length - 1) - index)),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
              (secondFlex == 0 || firstFlex.flex == 0)
                  ? const SizedBox()
                  : Expanded(
                      flex: (secondFlex * sum).ceil(),
                      child: child,
                    )
            ],
          );
        },
      );
    }

    Widget finalWidget = const SizedBox();
    int realItemIndex = realItems.length - 1;
    for (int i = 0; i < firstFlexes.length; i++) {
      print("i : $i");
      finalWidget = generateWidget(
          child: finalWidget,
          firstFlex: firstFlexes[i],
          secondFlex: secondFlexes[i],
          itemIndex: realItemIndex);
      realItemIndex -= firstFlexes[i].items.length;
      print("length  : ${firstFlexes[i].items.length}");
      print("realIndex : $realItemIndex");
    }
    return finalWidget;
  }
}
*/
