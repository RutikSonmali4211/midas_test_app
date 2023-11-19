

import 'dart:convert';

OtherAssetsModel otherAssetsModelFromJson(String str) => OtherAssetsModel.fromJson(json.decode(str));

String otherAssetsModelToJson(OtherAssetsModel data) => json.encode(data.toJson());

class OtherAssetsModel {
    int currentValue;
    DateTime lastUpdatedDate;
    List<Investment> investment;
   
    OtherAssetsModel({
        required this.currentValue,
        required this.lastUpdatedDate,
        required this.investment,
    });

    factory OtherAssetsModel.fromJson(Map<String, dynamic> json) => OtherAssetsModel(
        currentValue: json["currentValue"],
        lastUpdatedDate: DateTime.parse(json["lastUpdatedDate"]),
        investment: List<Investment>.from(json["investment"].map((x) => Investment.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "currentValue": currentValue,
        "lastUpdatedDate": lastUpdatedDate.toIso8601String(),
        "investment": List<dynamic>.from(investment.map((x) => x.toJson())),
    };
}

class Investment {
    String id;
    String userId;
    String type;
    Data data;
    String status;
    DateTime createdDate;
    DateTime updatedDate;
    int v;

    Investment({
        required this.id,
        required this.userId,
        required this.type,
        required this.data,
        required this.status,
        required this.createdDate,
        required this.updatedDate,
        required this.v,
    });

    factory Investment.fromJson(Map<String, dynamic> json) => Investment(
        id: json["_id"],
        userId: json["userId"],
        type: json["type"],
        data: Data.fromJson(json["data"]),
        status: json["status"],
        createdDate: DateTime.parse(json["createdDate"]),
        updatedDate: DateTime.parse(json["updatedDate"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "type": type,
        "data": data.toJson(),
        "status": status,
        "createdDate": createdDate.toIso8601String(),
        "updatedDate": updatedDate.toIso8601String(),
        "__v": v,
    };
}

class Data {
    String assetName;
    int currentPrice;
    int purchasePrice;
    DateTime purchaseDate;

    Data({
        required this.assetName,
        required this.currentPrice,
        required this.purchasePrice,
        required this.purchaseDate,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        assetName: json["assetName"],
        currentPrice: int.parse(json["currentPrice"].toString()),
        purchasePrice: int.parse(json["purchasePrice"].toString()),
        purchaseDate: DateTime.parse(json["purchaseDate"].toString()),
    );

    Map<String, dynamic> toJson() => {
        "assetName": assetName,
        "currentPrice": currentPrice,
        "purchasePrice": purchasePrice,
        "purchaseDate": purchaseDate.toIso8601String(),
    };
}






// class OtherAssets {
//   final String name;
//   final String currentValue;
//   final String purchasePrice;
//   final String purchaseDate;

//   OtherAssets({
//     required this.name,
//     required this.currentValue,
//     required this.purchasePrice,
//     required this.purchaseDate,
//   });
// }
