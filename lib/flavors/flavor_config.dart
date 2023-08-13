enum Flavor { SIMPSON, WIRE }

class FlavorValues {
  final String? bundleID;
  final String? dataAPI;
  final String? baseURL;

  FlavorValues({
    this.bundleID,
    this.dataAPI,
    this.baseURL,
  });
}

class FlavorConfig {
  final Flavor flavor;
  final String env;
  final String name;
  final FlavorValues? values;
  static FlavorConfig? _instance;

  factory FlavorConfig(
      {required Flavor flavor,
      required String name,
      required String env,
      required FlavorValues values}) {
    _instance ??= FlavorConfig._internal(flavor, name, env, values);
    return _instance!;
  }

  FlavorConfig._internal(this.flavor, this.name, this.env, this.values);

  static FlavorConfig? get instance => _instance;

  static bool isDevelopment() => _instance!.flavor == Flavor.SIMPSON;

  static bool isProduction() => _instance!.flavor == Flavor.WIRE;
}
