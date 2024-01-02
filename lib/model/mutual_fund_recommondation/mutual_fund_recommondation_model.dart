import 'dart:convert';

List<MutualFundRecommondationModel> mutualFundRecommondationModelFromJson(String str) => List<MutualFundRecommondationModel>.from(json.decode(str).map((x) => MutualFundRecommondationModel.fromJson(x)));

String mutualFundRecommondationModelToJson(List<MutualFundRecommondationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MutualFundRecommondationModel {
    String? id;
    String? userId;
    String? goalId;
    String? goalName;
    String? goalTerm;
    String? fundType;
    List<Recommendation>? recommendations;
    DateTime? createdAt;

    MutualFundRecommondationModel({
        this.id,
        this.userId,
        this.goalId,
        this.goalName,
        this.goalTerm,
        this.fundType,
        this.recommendations,
        this.createdAt,
    });

    factory MutualFundRecommondationModel.fromJson(Map<String, dynamic> json) => MutualFundRecommondationModel(
        id: json["_id"],
        userId: json["user_id"],
        goalId: json["goal_id"],
        goalName: json["goalName"],
        goalTerm: json["goalTerm"],
        fundType: json["fundType"],
        recommendations: json["recommendations"] == null ? [] : List<Recommendation>.from(json["recommendations"]!.map((x) => Recommendation.fromJson(x))),
        createdAt: json["createdAt"] == null ? DateTime.now() : DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "user_id": userId,
        "goal_id": goalId,
        "goalName": goalName,
        "goalTerm": goalTerm,
        "fundType": fundType,
        "recommendations": recommendations == null ? [] : List<dynamic>.from(recommendations!.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
    };
}

class Recommendation {
    String? fundName;
    double? sipAmount;
    String? id;

    Recommendation({
        this.fundName,
        this.sipAmount,
        this.id,
    });

    factory Recommendation.fromJson(Map<String, dynamic> json) => Recommendation(
        fundName: json["fund_name"],
        sipAmount: json["sip_amount"]?.toDouble(),
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "fund_name": fundName,
        "sip_amount": sipAmount,
        "_id": id,
    };
}
