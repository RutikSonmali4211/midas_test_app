class Convertors {
  static List<Map<String, dynamic>> createListForSelectedDropdownData(
      Set data, Map<String, dynamic> dataMap) {
    List<Map<String, dynamic>> listOfData = data.map((key) {
      return {
        'key': key,
        'value': dataMap[key],
      };
    }).toList();
    return listOfData;
  }

  static double getInvestedAssetPercentage(int value, int totalValue) {
    double percentage =
        double.parse(((value / totalValue) * 100).toStringAsFixed(2));
    if (percentage.isNaN) {
      return 0.00;
    }
    return percentage;
  }

  static double getLinearBarValue(int value, int totalValue) {
    double percentage =
        double.parse((((value / totalValue) * 100) / 100).toStringAsFixed(4));
    if (percentage.isNaN) {
      return 0.00;
    }
    return percentage;
  }

  static Map<String, dynamic> createListForInvestmentDropdownData(
      String key, String data) {
    Map<String, dynamic> mapData = {
      'key': key,
      'value': data,
    };
    return mapData;
  }
}
