// To parse this JSON data, do
//
//     final netWorthModel = netWorthModelFromJson(jsonString);

import 'dart:convert';

List<NetWorthModel> netWorthModelFromJson(String str) => List<NetWorthModel>.from(jsonDecode(str).map((x) => NetWorthModel.fromJson(x)));

String netWorthModelToJson(List<NetWorthModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NetWorthModel {
    int revenue;
    DateTime date;
    String id;

    NetWorthModel({
        required this.revenue,
        required this.date,
        required this.id,
    });

    factory NetWorthModel.fromJson(Map<String, dynamic> json) => NetWorthModel(
        revenue: json["revenue"],
        date: DateTime.parse(json["date"]),
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "revenue": revenue,
        "date": date.toIso8601String(),
        "_id": id,
    };
}
