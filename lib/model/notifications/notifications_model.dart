import 'dart:convert';

List<NotificationsModel> notificationsModelFromJson(String str) => List<NotificationsModel>.from(json.decode(str).map((x) => NotificationsModel.fromJson(x)));

String notificationsModelToJson(List<NotificationsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotificationsModel {
    String? id;
    String? code;
    String? title;
    String? body;
    String? userId;
    bool? read;
    bool? sent;
    DateTime? createdAt;
    int? v;

    NotificationsModel({
        this.id,
        this.code,
        this.title,
        this.body,
        this.userId,
        this.read,
        this.sent,
        this.createdAt,
        this.v,
    });

    factory NotificationsModel.fromJson(Map<String, dynamic> json) => NotificationsModel(
        id: json["_id"],
        code: json["code"],
        title: json["title"],
        body: json["body"],
        userId: json["userId"],
        read: json["read"],
        sent: json["sent"],
        createdAt: json["createdAt"] == null ? DateTime.now() : DateTime.parse(json["createdAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "code": code,
        "title": title,
        "body": body,
        "userId": userId,
        "read": read,
        "sent": sent,
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
    };
}
