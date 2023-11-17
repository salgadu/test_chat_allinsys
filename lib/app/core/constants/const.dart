class AppConst {
  AppConst._privateConstructor();

  static final AppConst _instance = AppConst._privateConstructor();

  factory AppConst() {
    return _instance;
  }

  static const apiUrl = 'www.allinsys.com';
  static const apiKey = "qw56ew4hbn4k8j91d331xd3b1nj89re98w";
  // static const writeApiUrl = 'us-east1-prj-infra-allinsys.cloudfunctions.net';
  static const double imageH = 18;

  static double sidePadding = 30;
  static double sideWindowWidth = 450;

  static String getDefaultStorage() {
    return "https://storage.googleapis.com/ais-content/meca/";
  }

  static Map? getCommissionManager() {
    var data = appData();
    List commission = [];
    try {
      commission = [...(data["managerComm"] ?? [])];
      commission = commission
          .where((element) =>
              (element["id"] ?? "").toString().isNotEmpty &&
              (element["fromDate"] ?? "").toString().isNotEmpty)
          .toList();
    } catch (e) {}

    commission = commission
        .where(
          (element) => DateTime.now().isAfter(
            DateTime.parse(
              element["fromDate"],
            ),
          ),
        )
        .toList();

    if (commission.isEmpty) {
      return null;
    }

    Map comm = commission.reduce(
      (value, element) {
        if (DateTime.parse(
          value["fromDate"],
        ).isAfter(
          DateTime.parse(
            element["fromDate"],
          ),
        )) {
          return value;
        } else {
          return element;
        }
      },
    );
    return comm;
  }

  static Map appData() {
    Map data;
    data = {};

    return data;
  }
}
