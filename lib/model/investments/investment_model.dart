// // class InvestmentItems {
// //   final String title;
// //   final int investment;
// //   final int currentValue;

// //   InvestmentItems({
// //     required this.title,
// //     required this.investment,
// //     required this.currentValue,
// //   });
// // }


// import 'dart:convert';

// InvestmentModel investmentModelFromJson(String str) => InvestmentModel.fromJson(json.decode(str));

// String investmentModelToJson(InvestmentModel data) => json.encode(data.toJson());

// class InvestmentModel {
//     List<InvestmentData> investments;
//     int totalValue;
//     DateTime lastUpdatedDate;

//     InvestmentModel({
//         required this.investments,
//         required this.totalValue,
//         required this.lastUpdatedDate,
//     });

//     factory InvestmentModel.fromJson(Map<String, dynamic> json) => InvestmentModel(
//         investments: List<InvestmentData>.from(json["investments"].map((x) => InvestmentData.fromJson(x))),
//         totalValue: json["totalValue"],
//         lastUpdatedDate: DateTime.parse(json["lastUpdatedDate"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "investments": List<dynamic>.from(investments.map((x) => x.toJson())),
//         "totalValue": totalValue,
//         "lastUpdatedDate": lastUpdatedDate.toIso8601String(),
//     };
// }

// class InvestmentData {
//     String type;
//     int currentValue;
//     int investedValue;

//     InvestmentData({
//         required this.type,
//         required this.currentValue,
//         required this.investedValue,
//     });

//     factory InvestmentData.fromJson(Map<String, dynamic> json) => InvestmentData(
//         type: json["type"],
//         currentValue: json["currentValue"],
//         investedValue: json["investedValue"],
//     );

//     Map<String, dynamic> toJson() => {
//         "type": type,
//         "currentValue": currentValue,
//         "investedValue": investedValue,
//     };
// }
