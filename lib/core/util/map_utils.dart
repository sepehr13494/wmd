bool compareMaps(Map<String, dynamic> map1, Map<String, dynamic> map2) {
  for (var entry in map1.entries) {
    var key = entry.key;
    var value = entry.value;

    if (!map2.containsKey(key) || map2[key] != value) {
      return false;
    }
  }

  return true;
}
