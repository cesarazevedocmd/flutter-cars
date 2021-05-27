class CarType {
  String _type;

  CarType._(this._type);

  String getType() => _type;

  static final classic = CarType._("classicos");
  static final sport = CarType._("esportivos");
  static final lux = CarType._("luxo");
}
