import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';
import 'package:wmd/features/assets_overview/charts/presentation/models/color_title_obj.dart';


class PortfolioColorsWithTitlesWidget extends StatelessWidget {
  final List<ColorTitleObj> colorTitles;
  const PortfolioColorsWithTitlesWidget({Key? key, required this.colorTitles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return LayoutBuilder(
        builder: (context, snap) {
          final isMobile = ResponsiveHelper(context: context).isMobile;
          final int multiple = colorTitles.length < 3 ? 2 : 4;
          final double finalWidth = !isMobile ? snap.maxWidth * 0.45 : snap.maxWidth * 0.9;
          final double finalHeight = multiple * 30;
          return Center(
            child: Scrollbar(
              controller: scrollController,
              trackVisibility: true,
              thumbVisibility: true,
              child: SizedBox(
                height: finalHeight,
                child: GridView.count(
                  controller: scrollController,
                  crossAxisCount: multiple,
                  childAspectRatio: (finalHeight/multiple)/finalWidth,
                  scrollDirection: Axis.horizontal,
                  children: List.generate(colorTitles.length, (index) {
                    final item = colorTitles.elementAt(index);
                    return SizedBox(
                      width: finalWidth,
                      child: Padding(
                        padding:
                        const EdgeInsets.fromLTRB(4, 4, 4, 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: item.color,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Align(
                                alignment: AlignmentDirectional
                                    .centerStart,
                                child: Text(
                                  item.title,
                                  style: const TextStyle(
                                      fontSize: 10),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          );
        }
    );
  }
}
