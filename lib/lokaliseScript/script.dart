import 'dart:convert';
import 'dart:io';

void main() async {
  await readFileAndConvert("C:/Users/DearUser/StudioProjects/wmd/lib/lokaliseScript/input/en.arb", 'C:/Users/DearUser/StudioProjects/wmd/lib/lokaliseScript/output/app_en.arb');
  await readFileAndConvert("C:/Users/DearUser/StudioProjects/wmd/lib/lokaliseScript/input/ar.arb", 'C:/Users/DearUser/StudioProjects/wmd/lib/lokaliseScript/output/app_ar.arb');
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