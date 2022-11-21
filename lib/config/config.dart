enum Flavor { DEV, QA, PROD }

class Config {
  Flavor flavor;
  String SERVER_URL;
  String API_SUFFIX;
  String API_URL;

  static late Config _instance;

  factory Config() {
    return _instance;
  }

  factory Config.initialize(flavor, config) {
    _instance = Config._internal(flavor, config);
    return instance;
  }

  factory Config.initializeFromMap(Map<String, dynamic> config) {
    late Flavor flavor;
    if (config['flavor'] == "DEV") {
      flavor = Flavor.DEV;
    }
    if (config['flavor'] == "QA") {
      flavor = Flavor.QA;
    }
    if (config['flavor'] == "PROD") {
      flavor = Flavor.PROD;
    }
    _instance = Config._internalFromMap(flavor, config);
    return _instance;
  }

  Map<String, dynamic> toMap() {
    late String flavor;
    if (this.flavor == Flavor.DEV) {
      flavor = "DEV";
    }
    if (this.flavor == Flavor.QA) {
      flavor = "QA";
    }
    if (this.flavor == Flavor.PROD) {
      flavor = "PROD";
    }
    return {
      "SERVER_URL": SERVER_URL,
      "API_URL": SERVER_URL + API_SUFFIX,
      "flavor": flavor,
    };
  }

  Config._internal(this.flavor, config)
      : this.SERVER_URL = config.SERVER_URL,
        this.API_SUFFIX = config.API_SUFFIX,
        this.API_URL = config.SERVER_URL + config.API_SUFFIX {
    print("${this.flavor} - $config");
  }

  Config._internalFromMap(this.flavor, config)
      : this.SERVER_URL = config['SERVER_URL'],
        this.API_SUFFIX = config['API_SUFFIX'],
        this.API_URL = config['SERVER_URL'] + config['API_SUFFIX'] {
    if (config['flavor'] == "DEV") {
      flavor = Flavor.DEV;
    }
    if (config['flavor'] == "QA") {
      flavor = Flavor.QA;
    }
    if (config['flavor'] == "PROD") {
      flavor = Flavor.PROD;
    }
  }

  static Config get instance {
    return _instance;
  }

  bool isProduction() => flavor == Flavor.PROD;

  bool isDevelopment() => flavor == Flavor.DEV;

  bool isQA() => flavor == Flavor.QA;
}
