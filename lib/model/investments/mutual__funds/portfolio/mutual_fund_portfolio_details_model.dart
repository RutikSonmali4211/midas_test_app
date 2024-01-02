import 'dart:convert';

MutualFundPortfolioDetailsModel mutualFundPortfolioDetailsModelFromJson(String str) => MutualFundPortfolioDetailsModel.fromJson(json.decode(str));

String mutualFundPortfolioDetailsModelToJson(MutualFundPortfolioDetailsModel data) => json.encode(data.toJson());

class MutualFundPortfolioDetailsModel {
    String? userId;
    String? object;
    Report? report;
    Data? data;
    FilterBy? filterBy;
    String? id;
    int? v;

    MutualFundPortfolioDetailsModel({
        this.userId,
        this.object,
        this.report,
        this.data,
        this.filterBy,
        this.id,
        this.v,
    });

    factory MutualFundPortfolioDetailsModel.fromJson(Map<String, dynamic> json) => MutualFundPortfolioDetailsModel(
        userId: json["userId"],
        object: json["object"],
        report: json["report"] == null ? null : Report.fromJson(json["report"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        filterBy: json["filter_by"] == null ? null : FilterBy.fromJson(json["filter_by"]),
        id: json["_id"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "object": object,
        "report": report?.toJson(),
        "data": data?.toJson(),
        "filter_by": filterBy?.toJson(),
        "_id": id,
        "__v": v,
    };
}

class Data {
    List<List<String?>>? rows;
    List<String>? columns;
    String? id;

    Data({
        this.rows,
        this.columns,
        this.id,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        rows: json["rows"] == null ? [] : List<List<String?>>.from(json["rows"]!.map((x) => List<String?>.from(x.map((x) => x)))),
        columns: json["columns"] == null ? [] : List<String>.from(json["columns"]!.map((x) => x)),
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "rows": rows == null ? [] : List<dynamic>.from(rows!.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "columns": columns == null ? [] : List<dynamic>.from(columns!.map((x) => x)),
        "_id": id,
    };
}

class FilterBy {
    String? mfInvestmentAccount;
    dynamic tradedOnTo;
    String? id;

    FilterBy({
        this.mfInvestmentAccount,
        this.tradedOnTo,
        this.id,
    });

    factory FilterBy.fromJson(Map<String, dynamic> json) => FilterBy(
        mfInvestmentAccount: json["mf_investment_account"],
        tradedOnTo: json["traded_on_to"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "mf_investment_account": mfInvestmentAccount,
        "traded_on_to": tradedOnTo,
        "_id": id,
    };
}

class Report {
    String? type;
    Standard? standard;
    String? id;

    Report({
        this.type,
        this.standard,
        this.id,
    });

    factory Report.fromJson(Map<String, dynamic> json) => Report(
        type: json["type"],
        standard: json["standard"] == null ? null : Standard.fromJson(json["standard"]),
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "standard": standard?.toJson(),
        "_id": id,
    };
}

class Standard {
    String? name;
    String? desc;
    String? id;

    Standard({
        this.name,
        this.desc,
        this.id,
    });

    factory Standard.fromJson(Map<String, dynamic> json) => Standard(
        name: json["name"],
        desc: json["desc"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "desc": desc,
        "_id": id,
    };
}
