import 'dart:convert';

CardsModel cardsModelFromJson(String str) =>
    CardsModel.fromJson(json.decode(str));

String cardsModelToJson(CardsModel data) => json.encode(data.toJson());

class CardsModel {
  String id;
  String userId;
  int cardNo;
  int balance;
  String cardName;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  CardsModel({
    required this.id,
    required this.userId,
    required this.cardNo,
    required this.balance,
    required this.cardName,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CardsModel.fromJson(Map<String, dynamic> json) => CardsModel(
        id: json["_id"],
        userId: json["user_id"],
        cardNo: json["card_no"],
        balance: json["balance"],
        cardName: json["card_name"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_id": userId,
        "card_no": cardNo,
        "balance": balance,
        "card_name": cardName,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
