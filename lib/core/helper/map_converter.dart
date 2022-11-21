class MapData {
  String key;
  String value;

  MapData(this.key, this.value);
}

class MapConvert {
  static Map<String, dynamic> map(MapData data) {
    return {data.key: data.value};
  }
}
