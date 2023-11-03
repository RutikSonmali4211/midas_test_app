// class GoalsEntity {
//   final String name;
//   final String description;
//   final String price;
//   final String date;
//   GoalsEntity({
//     required this.name,
//     required this.description,
//     required this.price,
//     required this.date,
//   });
// }


import 'dart:convert';

GoalsModel goalsModelFromJson(String str) => GoalsModel.fromJson(json.decode(str));

String goalsModelToJson(GoalsModel data) => json.encode(data.toJson());

class GoalsModel {
    String id;
    String userId;
    String goalName;
    int value;
    String description;
    DateTime targetDate;
    String status;
    DateTime updatedAt;
    int v;

    GoalsModel({
        required this.id,
        required this.userId,
        required this.goalName,
        required this.value,
        required this.description,
        required this.targetDate,
        required this.status,
        required this.updatedAt,
        required this.v,
    });

    factory GoalsModel.fromJson(Map<String, dynamic> json) => GoalsModel(
        id: json["_id"],
        userId: json["user_id"],
        goalName: json["goalName"],
        value: json["value"],
        description: json["description"],
        targetDate: DateTime.parse(json["targetDate"]),
        status: json["status"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "user_id": userId,
        "goalName": goalName,
        "value": value,
        "description": description,
        "targetDate": targetDate.toIso8601String(),
        "status": status,
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

