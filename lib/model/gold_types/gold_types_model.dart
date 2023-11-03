// import 'dart:convert';

// GoldTypesModel goldTypesModelFromJson(String str) =>
//     GoldTypesModel.fromJson(json.decode(str));

// String goldTypesModelToJson(GoldTypesModel data) => json.encode(data.toJson());

// class GoldTypesModel {
//   List<GoldData> goldData;
//   int totalValue;
//   DateTime lastUpdatedDate;

//   GoldTypesModel({
//     required this.goldData,
//     required this.totalValue,
//     required this.lastUpdatedDate,
//   });

//   factory GoldTypesModel.fromJson(Map<String, dynamic> json) => GoldTypesModel(
//         goldData: List<GoldData>.from(
//             json["goldData"].map((x) => GoldData.fromJson(x))),
//         totalValue: json["totalValue"],
//         lastUpdatedDate: json["lastUpdatedDate"] != null
//             ? DateTime.parse(json["lastUpdatedDate"])
//             : DateTime.now(),
//       );

//   Map<String, dynamic> toJson() => {
//         "goldData": List<dynamic>.from(goldData.map((x) => x.toJson())),
//         "totalValue": totalValue,
//         "lastUpdatedDate": lastUpdatedDate.toIso8601String(),
//       };
// }

// class GoldData {
//   String goldType;
//   int goldPrice;
//   int currentValue;
//   int qty;

//   GoldData({
//     required this.goldType,
//     required this.goldPrice,
//     required this.currentValue,
//     required this.qty,
//   });

//   factory GoldData.fromJson(Map<String, dynamic> json) => GoldData(
//         goldType: json["goldType"],
//         goldPrice: json["goldPrice"],
//         currentValue: json["currentValue"],
//         qty: json["qty"],
//       );

//   Map<String, dynamic> toJson() => {
//         "goldType": goldType,
//         "goldPrice": goldPrice,
//         "currentValue": currentValue,
//         "qty": qty,
//       };
// }
