import 'dart:math';

import 'package:flutter/material.dart';

extension ExString on String {
  String removeZero() {
    final list = split('.');
    if (list.length > 1) {
      if (list[1].characters.first == "0") {
        return list.first;
      }
    }
    return this;
  }

  String getCompact({String? sign = "\$"}) {
    if (isEmpty) {
      return "${sign}0";
    }
    final numb = double.tryParse(this) ?? 0;
    return numb.getCompact(sign: sign);
  }
}

extension Ex on double {
  String cR() {
    return roundV3(decimals: 1).toString().removeZero(); //when desc
    //return this.toString(); //when desc
    //return this.round().toString(); //this works great when increasing
  }

  String getCompact({String? sign = "\$"}) {
    final numb = this;
    late String result;
    if (numb > 1000000000000) {
      result = "${(numb / 1000000000000).cR()}T";
    } else if (numb > 1000000000) {
      result = "${(numb / 1000000000).cR()}B";
    } else if (numb > 1000000) {
      result = "${(numb / 1000000).cR()}M";
    } else if (numb > 1000) {
      result = "${(numb / 1000).cR()}K";
    } else {
      result = (numb).cR().toString();
    }
    return sign != null ? sign + result : result;
  }

  double roundV2({int decimals = 1}) {
    num mod = pow(10.0, decimals);
    return ((this * mod).round().toDouble() / mod);
  }

  double roundV3({int decimals = 1}) {
    // Step 1 - Prime IMPORTANT Function Parameters ...
    int iCutIndex = 0;
    String sDeciClipdNTR = "";
    num nMod = pow(10.0, decimals);
    String sNTR = toString();
    int iLastDigitNTR = 0, i2ndLastDigitNTR = 0;
    // Step 2 - Calculate Decimal Cut Index (i.e. string cut length) ...
    int iDeciPlaces = (decimals + 2);
    if (sNTR.contains('.')) {
      iCutIndex = sNTR.indexOf('.') + iDeciPlaces;
    } else {
      sNTR = sNTR + '.';
      iCutIndex = sNTR.indexOf('.') + iDeciPlaces;
    }

    // Step 3 - Cut input double to length of requested Decimal Places ...
    if (iCutIndex > sNTR.length) {
      // Check that decimal cutting is possible ...
      sNTR = sNTR +
          ("0" *
              iDeciPlaces); // ... and fix (lengthen) the input double if it is too short.
      sDeciClipdNTR = sNTR.substring(
          0, iCutIndex); // ... then cut string at indicated 'iCutIndex' !!
    } else {
      sDeciClipdNTR = sNTR.substring(
          0, iCutIndex); // Cut string at indicated 'iCutIndex' !!
    }

    // Step 4 - Extract the Last and 2nd Last digits of the cut input double.
    int iLenSDCNTR = sDeciClipdNTR.length;
    iLastDigitNTR = int.parse(
        sDeciClipdNTR.substring(iLenSDCNTR - 1)); // Extract the last digit !!
    (decimals == 0)
        ? i2ndLastDigitNTR =
            int.parse(sDeciClipdNTR.substring(iLenSDCNTR - 3, iLenSDCNTR - 2))
        : i2ndLastDigitNTR =
            int.parse(sDeciClipdNTR.substring(iLenSDCNTR - 2, iLenSDCNTR - 1));

    // Step 5 - Execute the FINAL (Accurate) Rounding Process on the cut input double.
    double dAccuRound = 0;
    if (iLastDigitNTR == 5 && ((i2ndLastDigitNTR + 1) % 2 != 0)) {
      dAccuRound = double.parse(sDeciClipdNTR.substring(0, iLenSDCNTR - 1));
    } else {
      if (iLastDigitNTR < 5) {
        dAccuRound = double.parse(sDeciClipdNTR.substring(0, iLenSDCNTR - 1));
      } else {
        if (decimals == 0) {
          sDeciClipdNTR = sNTR.substring(0, iCutIndex - 2);
          dAccuRound = double.parse(sDeciClipdNTR) + 1; // Finally - Round UP !!
        } else {
          double dModUnit = 1 / nMod;
          sDeciClipdNTR = sNTR.substring(0, iCutIndex - 1);
          dAccuRound =
              double.parse(sDeciClipdNTR) + dModUnit; // Finally - Round UP !!
        }
      }
    }

    // Step 6 - Run final QUALITY CHECK !!
    double dResFin = double.parse(dAccuRound.toStringAsFixed(decimals));

    // Step 7 - Return result to function call ...
    return dResFin;
  }
}
