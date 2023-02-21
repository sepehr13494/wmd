import 'package:flutter/material.dart';
import 'package:wmd/core/presentation/widgets/responsive_helper/responsive_helper.dart';

import '../models/color_title_obj.dart';

class ColorsWithTitlesWidget extends StatelessWidget {
  final List<ColorTitleObj> colorTitles;
  final int axisColumnCount;
  const ColorsWithTitlesWidget({Key? key, required this.colorTitles, required this.axisColumnCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, snap) {
          return Wrap(
            children: List.generate(colorTitles.length, (index) {
              final item = colorTitles.elementAt(index);
              return SizedBox(
                width: snap.maxWidth / axisColumnCount,
                child: Padding(
                  padding:
                  const EdgeInsets.fromLTRB(20, 4, 20, 4),
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
          );
        }
    );
  }
}
