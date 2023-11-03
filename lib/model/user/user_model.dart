// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    String id;
    String name;
    String email;
    String mobileNumber;
    String password;
    String pan;
    DateTime startDate;
    DateTime endDate;
    List<Datum> data;
    List<Datum> financialData;
    List<TopSellingCategoryAccount> topSellingCategoryAccount;
    List<TopSellingCategoryCard> topSellingCategoryCard;
    String status;
    DateTime createdAt;
    DateTime updatedAt;
    int v;
    List<DeviceToken> deviceTokens;

    UserModel({
        required this.id,
        required this.name,
        required this.email,
        required this.mobileNumber,
        required this.password,
        required this.pan,
        required this.startDate,
        required this.endDate,
        required this.data,
        required this.financialData,
        required this.topSellingCategoryAccount,
        required this.topSellingCategoryCard,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        required this.deviceTokens,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        mobileNumber: json["mobileNumber"],
        password: json["password"],
        pan: json["pan"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        financialData: List<Datum>.from(json["financialData"].map((x) => Datum.fromJson(x))),
        topSellingCategoryAccount: List<TopSellingCategoryAccount>.from(json["topSellingCategoryAccount"].map((x) => TopSellingCategoryAccount.fromJson(x))),
        topSellingCategoryCard: List<TopSellingCategoryCard>.from(json["topSellingCategoryCard"].map((x) => TopSellingCategoryCard.fromJson(x))),
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        deviceTokens: List<DeviceToken>.from(json["deviceTokens"].map((x) => DeviceToken.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "mobileNumber": mobileNumber,
        "password": password,
        "pan": pan,
        "startDate": startDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "financialData": List<dynamic>.from(financialData.map((x) => x.toJson())),
        "topSellingCategoryAccount": List<dynamic>.from(topSellingCategoryAccount.map((x) => x.toJson())),
        "topSellingCategoryCard": List<dynamic>.from(topSellingCategoryCard.map((x) => x.toJson())),
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "deviceTokens": List<dynamic>.from(deviceTokens.map((x) => x.toJson())),
    };
}

class Datum {
    String key;
    String value;
    String id;

    Datum({
        required this.key,
        required this.value,
        required this.id,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        key: json["key"],
        value: json["value"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
        "_id": id,
    };
}

class DeviceToken {
    String deviceToken;
    bool bioMatric;
    String id;

    DeviceToken({
        required this.deviceToken,
        required this.bioMatric,
        required this.id,
    });

    factory DeviceToken.fromJson(Map<String, dynamic> json) => DeviceToken(
        deviceToken: json["deviceToken"],
        bioMatric: json["bioMatric"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "deviceToken": deviceToken,
        "bioMatric": bioMatric,
        "_id": id,
    };
}

class TopSellingCategoryAccount {
    String category;
    int amount;
    String id;

    TopSellingCategoryAccount({
        required this.category,
        required this.amount,
        required this.id,
    });

    factory TopSellingCategoryAccount.fromJson(Map<String, dynamic> json) => TopSellingCategoryAccount(
        category: json["category"],
        amount: json["amount"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "category": category,
        "amount": amount,
        "_id": id,
    };
}

class TopSellingCategoryCard {
    String category;
    String amount;
    String id;

    TopSellingCategoryCard({
        required this.category,
        required this.amount,
        required this.id,
    });

    factory TopSellingCategoryCard.fromJson(Map<String, dynamic> json) => TopSellingCategoryCard(
        category: json["category"],
        amount: json["amount"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "category": category,
        "amount": amount,
        "_id": id,
    };
}
