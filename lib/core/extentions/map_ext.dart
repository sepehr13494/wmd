extension MapExt on Map<String, dynamic>{
  Map<String,dynamic> addOrUpdate(Map<String,dynamic> map){
    for (var element in map.keys) {
      this[element] = map[element];
    }
    return this;
  }
}