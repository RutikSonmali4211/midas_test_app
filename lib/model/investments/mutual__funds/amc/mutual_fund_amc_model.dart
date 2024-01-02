import 'dart:convert';

List<MutualFundAmcModel> mutualFundAmcModelFromJson(String str) =>
    List<MutualFundAmcModel>.from(
        json.decode(str).map((x) => MutualFundAmcModel.fromJson(x)));

String mutualFundAmcModelToJson(List<MutualFundAmcModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MutualFundAmcModel {
  String id;
  int amfiCode;
  String amc;
  String type;
  String category;
  String scheme;
  String isinPayoutOrGrowth;
  String benchmark;
  String? isinDivReinvestment;
  bool? flag;

  MutualFundAmcModel({
    required this.id,
    required this.amfiCode,
    required this.amc,
    required this.type,
    required this.category,
    required this.scheme,
    required this.isinPayoutOrGrowth,
    required this.benchmark,
    this.isinDivReinvestment,
    this.flag,
  });

  factory MutualFundAmcModel.fromJson(Map<String, dynamic> json) =>
      MutualFundAmcModel(
        id: json["_id"],
        amfiCode: json["amfi_code"] ?? "",
        amc: json["amc"] ?? "",
        type: json["type"] ?? "",
        category: json["category"] ?? "",
        scheme: json["scheme"] ?? "",
        isinPayoutOrGrowth: json["ISIN_Payout_or_Growth"] ?? "",
        benchmark: json["Benchmark"] ?? "",
        isinDivReinvestment: json["ISIN_Div_Reinvestment"] ?? "",
        flag: json["flag"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "amfi_code": amfiCode,
        "amc": amc,
        "type": type,
        "category": category,
        "scheme": scheme,
        "ISIN_Payout_or_Growth": isinPayoutOrGrowth,
        "Benchmark": benchmark,
        "ISIN_Div_Reinvestment": isinDivReinvestment,
        "flag": flag,
      };
}
