import 'dart:convert';
import 'dart:io';

void main() async {
  await readFileAndConvert("input/en.arb", 'output/app_en.arb');
  await readFileAndConvert("input/ar.arb", 'output/app_ar.arb');
}

Future<void> readFileAndConvert(String filePath, String outPath) async {
  var input = await File(filePath).readAsString();
  var myObj = jsonDecode(input);

  var newMap = {};

  for (var item in myObj.keys) {
    var temp = myObj[item];
    item = item.replaceAll(".", "_");
    item = item.replaceAll(":", "_");
    item = item.replaceAll("-", "_");
    item = item.replaceAll("(", "");
    item = item.replaceAll(")", "");
    item = item.replaceAll("+", "_plus_");
    item = item.replaceAll("-", "_minus_");
    newMap[item] = temp;
  }

  var out = File(outPath).openWrite();
  out.write(jsonEncode(newMap));
  out.close();
}
