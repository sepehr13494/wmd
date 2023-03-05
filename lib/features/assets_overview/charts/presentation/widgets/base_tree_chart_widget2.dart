import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:treemap/treemap.dart';
import 'package:wmd/core/presentation/widgets/app_stateless_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

class BaseTreeChartWidget2<T extends TreeChartObj> extends AppStatelessWidget {
  final List<T> treeChartObjs;
  final Widget Function(T, int) itemBuilder;

  const BaseTreeChartWidget2(
      {Key? key, required this.treeChartObjs, required this.itemBuilder})
      : super(key: key);

  @override
  Widget buildWidget(BuildContext context, TextTheme textTheme,
      AppLocalizations appLocalizations) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: TreeMapLayout(
        duration: const Duration(milliseconds: 500),
        tile: Binary(),
        children: [
          TreeNode.node(
            options: TreeNodeOptions(color: Colors.white),
            children: List.generate(treeChartObjs.length, (index) {
              T treeChartObj = treeChartObjs[index];
              return TreeNode.leaf(
                value: treeChartObj.value,
                options: TreeNodeOptions(child: itemBuilder(treeChartObj,index)),
              );
            }),
          ),
        ],
      ),
    );
  }
}
