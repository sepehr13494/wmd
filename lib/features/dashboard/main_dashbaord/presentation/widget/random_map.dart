import 'dart:math';

import 'package:countries_world_map/countries_world_map.dart';
import 'package:flutter/material.dart';

class RandomWorldMapGenrator extends StatefulWidget {
  RandomWorldMapGenrator({Key? key}) : super(key: key);

  @override
  _RandomWorldMapGenratorState createState() => _RandomWorldMapGenratorState();
}

class _RandomWorldMapGenratorState extends State<RandomWorldMapGenrator> {
  List<Color> colors = [
    Colors.indigo.shade900,
    Colors.blue,
    Colors.pink,
    Colors.red.shade900,
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black,
  ];

  final _random = Random();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: LayoutBuilder(
          builder: (context,snap) {
            return SizedBox(
              child: InteractiveViewer(
                maxScale: 75.0,
                child: Center(
                  child: Row(
                    children: [
                      SizedBox(
                        width: snap.maxWidth * 0.92,
                        // Actual widget from the Countries_world_map package.
                        child: SimpleWorldMap(
                          callback: (c, x) {
                            print(c);
                          },
                          countryColors: SimpleWorldCountryColors(
                            iR: Theme.of(context).primaryColor
                          ),
                        ),
                      ),
                      // Creates 8% from right side so the map looks more centered.
                      Container(width: snap.maxWidth * 0.08),
                    ],
                  ),
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}