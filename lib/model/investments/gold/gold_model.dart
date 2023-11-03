// // class GoldItems {
// //   final int id;
// //   final String title;
// //   final String currentValue;
// //   final String qty;

// //   GoldItems({
// //     required this.id,
// //     required this.title,
// //     required this.currentValue,
// //     required this.qty,
// //   });
// // }

// import 'dart:convert';

// GoldModel goldModelFromJson(String str) => GoldModel.fromJson(json.decode(str));

// String goldModelToJson(GoldModel data) => json.encode(data.toJson());

// class GoldModel {
//     int currentValue;
//     DateTime lastUpdatedDate;
//     List<Investment> investment;

//     GoldModel({
//         required this.currentValue,
//         required this.lastUpdatedDate,
//         required this.investment,
//     });

//     factory GoldModel.fromJson(Map<String, dynamic> json) => GoldModel(
//         currentValue: json["currentValue"],
//         lastUpdatedDate: DateTime.parse(json["lastUpdatedDate"]),
//         investment: List<Investment>.from(json["investment"].map((x) => Investment.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "currentValue": currentValue,
//         "lastUpdatedDate": lastUpdatedDate.toIso8601String(),
//         "investment": List<dynamic>.from(investment.map((x) => x.toJson())),
//     };
// }

// class Investment {
//     String id;
//     String userId;
//     String type;
//     Data data;
//     String status;
//     DateTime createdDate;
//     DateTime updatedDate;
//     int v;

//     Investment({
//         required this.id,
//         required this.userId,
//         required this.type,
//         required this.data,
//         required this.status,
//         required this.createdDate,
//         required this.updatedDate,
//         required this.v,
//     });

//     factory Investment.fromJson(Map<String, dynamic> json) => Investment(
//         id: json["_id"],
//         userId: json["userId"],
//         type: json["type"],
//         data: Data.fromJson(json["data"]),
//         status: json["status"],
//         createdDate: DateTime.parse(json["createdDate"]),
//         updatedDate: DateTime.parse(json["updatedDate"]),
//         v: json["__v"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "userId": userId,
//         "type": type,
//         "data": data.toJson(),
//         "status": status,
//         "createdDate": createdDate.toIso8601String(),
//         "updatedDate": updatedDate.toIso8601String(),
//         "__v": v,
//     };
// }

// class Data {
//     String shortTitle;
//     int weight;
//     String goldPurity;
//     String description;
//     int investedValue;

//     Data({
//         required this.shortTitle,
//         required this.weight,
//         required this.goldPurity,
//         required this.description,
//         required this.investedValue,
//     });

//     factory Data.fromJson(Map<String, dynamic> json) => Data(
//         shortTitle: json["shortTitle"],
//         weight: json["weight"],
//         goldPurity: json["goldPurity"],
//         description: json["description"],
//         investedValue: json["investedValue"],
//     );

//     Map<String, dynamic> toJson() => {
//         "shortTitle": shortTitle,
//         "weight": weight,
//         "goldPurity": goldPurity,
//         "description": description,
//         "investedValue": investedValue,
//     };
// }


