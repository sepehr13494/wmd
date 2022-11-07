import 'dart:math';

import 'package:countries_world_map/countries_world_map.dart';
import 'package:flutter/material.dart';
import 'package:wmd/core/util/colors.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/widget/base_asset_view.dart';

import '../models/each_asset_model.dart';

class RandomWorldMapGenrator extends StatefulWidget {
  RandomWorldMapGenrator({Key? key}) : super(key: key);

  @override
  _RandomWorldMapGenratorState createState() => _RandomWorldMapGenratorState();
}

class _RandomWorldMapGenratorState extends State<RandomWorldMapGenrator> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseAssetView(
      title: "Geographical Allocation",
      assets: [
        EachAssetViewModel(name: "Asia", price: "\$1,000,000", percentage: "51.0%"),
        EachAssetViewModel(name: "North America", price: "\$500,000", percentage: "26.0%"),
        EachAssetViewModel(name: "Africa", price: "\$200,000", percentage: "10.0%"),
        EachAssetViewModel(name: "Europe", price: "\$175,000", percentage: "9.0%"),
        EachAssetViewModel(name: "Australia", price: "\$50,000", percentage: "2.5%"),
        EachAssetViewModel(name: "South America", price: "\$25,000", percentage: "1.5%"),
      ],
      onMoreTap: (){},
      child: LayoutBuilder(
        builder: (context,snap) {
          return SizedBox(
            height: snap.maxWidth*0.65,
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

                      ),
                    ),
                  ),
                  // Creates 8% from right side so the map looks more centered.
                  Container(width: snap.maxWidth * 0.08),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}