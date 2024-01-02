import 'dart:convert';

List<MutualFundHoldingReportsModel> mutualFundHoldingReportsModelFromJson(String str) => List<MutualFundHoldingReportsModel>.from(json.decode(str).map((x) => MutualFundHoldingReportsModel.fromJson(x)));

String mutualFundHoldingReportsModelToJson(List<MutualFundHoldingReportsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MutualFundHoldingReportsModel {
    String? folioNumber;
    List<Scheme>? schemes;
    String? id;

    MutualFundHoldingReportsModel({
        this.folioNumber,
        this.schemes,
        this.id,
    });

    factory MutualFundHoldingReportsModel.fromJson(Map<String, dynamic> json) => MutualFundHoldingReportsModel(
        folioNumber: json["folio_number"],
        schemes: json["schemes"] == null ? [] : List<Scheme>.from(json["schemes"]!.map((x) => Scheme.fromJson(x))),
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "folio_number": folioNumber,
        "schemes": schemes == null ? [] : List<dynamic>.from(schemes!.map((x) => x.toJson())),
        "_id": id,
    };
}

class Scheme {
    String? isin;
    String? name;
    String? type;
    Holdings? holdings;
    InvestedValue? marketValue;
    InvestedValue? investedValue;
    InvestedValue? payout;
    Nav? nav;
    String? id;
    String? growthPercentage;
    String? avgNavValue;
    MasterData? masterData;

    Scheme({
        this.isin,
        this.name,
        this.type,
        this.holdings,
        this.marketValue,
        this.investedValue,
        this.payout,
        this.nav,
        this.id,
        this.growthPercentage,
        this.avgNavValue,
        this.masterData,
    });

    factory Scheme.fromJson(Map<String, dynamic> json) => Scheme(
        isin: json["isin"],
        name: json["name"],
        type: json["type"],
        holdings: json["holdings"] == null ? null : Holdings.fromJson(json["holdings"]),
        marketValue: json["market_value"] == null ? null : InvestedValue.fromJson(json["market_value"]),
        investedValue: json["invested_value"] == null ? null : InvestedValue.fromJson(json["invested_value"]),
        payout: json["payout"] == null ? null : InvestedValue.fromJson(json["payout"]),
        nav: json["nav"] == null ? null : Nav.fromJson(json["nav"]),
        id: json["_id"],
        growthPercentage: json["growthPercentage"],
        avgNavValue: json["avgNavValue"],
        masterData: json["masterData"] == "" ? null : MasterData.fromJson(json["masterData"]),
    );

    Map<String, dynamic> toJson() => {
        "isin": isin,
        "name": name,
        "type": type,
        "holdings": holdings?.toJson(),
        "market_value": marketValue?.toJson(),
        "invested_value": investedValue?.toJson(),
        "payout": payout?.toJson(),
        "nav": nav?.toJson(),
        "_id": id,
        "growthPercentage": growthPercentage,
        "avgNavValue": avgNavValue,
        "masterData": masterData?.toJson(),
    };
}

class Holdings {
    DateTime? asOn;
    double? units;
    double? redeemableUnits;
    String? id;

    Holdings({
        this.asOn,
        this.units,
        this.redeemableUnits,
        this.id,
    });

    factory Holdings.fromJson(Map<String, dynamic> json) => Holdings(
        asOn: json["as_on"] == null ? DateTime.now() : DateTime.parse(json["as_on"]),
        units: json["units"]?.toDouble(),
        redeemableUnits: json["redeemable_units"]?.toDouble(),
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "as_on": asOn?.toIso8601String(),
        "units": units,
        "redeemable_units": redeemableUnits,
        "_id": id,
    };
}

class InvestedValue {
    DateTime? asOn;
    double? amount;

    InvestedValue({
        this.asOn,
        this.amount,
    });

    factory InvestedValue.fromJson(Map<String, dynamic> json) => InvestedValue(
        asOn: json["as_on"] == null ? null : DateTime.parse(json["as_on"]),
        amount: json["amount"] == null ? 0.0 : json["amount"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "as_on": asOn?.toIso8601String(),
        "amount": amount,
    };
}

class MasterData {
    String? id;
    int? amfiCode;
    String? amc;
    String? type;
    String? category;
    String? scheme;
    String? isinPayoutOrGrowth;
    String? benchmark;

    MasterData({
        this.id,
        this.amfiCode,
        this.amc,
        this.type,
        this.category,
        this.scheme,
        this.isinPayoutOrGrowth,
        this.benchmark,
    });

    factory MasterData.fromJson(Map<String, dynamic> json) => MasterData(
        id: json["_id"],
        amfiCode: json["amfi_code"],
        amc: json["amc"],
        type: json["type"],
        category: json["category"],
        scheme: json["scheme"],
        isinPayoutOrGrowth: json["ISIN_Payout_or_Growth"],
        benchmark: json["Benchmark"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "amfi_code": amfiCode,
        "amc": amc,
        "type": type,
        "category": category,
        "scheme": scheme,
        "ISIN_Payout_or_Growth": isinPayoutOrGrowth,
        "Benchmark": benchmark,
    };
}

class Nav {
    DateTime? asOn;
    double? value;
    String? id;

    Nav({
        this.asOn,
        this.value,
        this.id,
    });

    factory Nav.fromJson(Map<String, dynamic> json) => Nav(
        asOn: json["as_on"] == null ? null : DateTime.parse(json["as_on"]),
        value: json["value"]?.toDouble(),
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "as_on": asOn?.toIso8601String(),
        "value": value,
        "_id": id,
    };
}
