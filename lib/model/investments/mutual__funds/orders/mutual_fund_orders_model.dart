import 'dart:convert';

List<MutualFundOrdersModel> mutualFundOrdersModelFromJson(String str) => List<MutualFundOrdersModel>.from(json.decode(str).map((x) => MutualFundOrdersModel.fromJson(x)));

String mutualFundOrdersModelToJson(List<MutualFundOrdersModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MutualFundOrdersModel {
    String? id;
    String? userId;
    String? fund;
    String? mfpid;
    String? isin;
    int? amount;
    String? orderType;
    String? status;
    bool? paymentDone;
    bool? isSip;
    DateTime? createdAt;
    int? v;
    Payment? payment;
    String? paymentStatus;
    String? mfppid;
    double? nav;
    double? units;

    MutualFundOrdersModel({
        this.id,
        this.userId,
        this.fund,
        this.mfpid,
        this.isin,
        this.amount,
        this.orderType,
        this.status,
        this.paymentDone,
        this.isSip,
        this.createdAt,
        this.v,
        this.payment,
        this.paymentStatus,
        this.mfppid,
        this.nav,
        this.units
    });

    factory MutualFundOrdersModel.fromJson(Map<String, dynamic> json) => MutualFundOrdersModel(
        id: json["_id"],
        userId: json["user_id"]!,
        fund: json["fund"]!,
        mfpid: json["mfpid"],
        isin: json["ISIN"]!,
        amount: json["amount"],
        orderType:json["orderType"]!,
        status: json["status"]!,
        paymentDone: json["paymentDone"],
        isSip: json["isSip"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        v: json["__v"],
        payment: json["payment"] == null ? null : Payment.fromJson(json["payment"]),
        paymentStatus: json["paymentStatus"],
        mfppid: json["mfppid"],
        nav: json["nav"] == null ? 0.0 :json["nav"].toDouble(),
        units: json["units"] == null ? 0.0 :json["units"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "user_id": userId,
        "fund": fund,
        "mfpid": mfpid,
        "ISIN": isin,
        "amount": amount,
        "orderType": orderType,
        "status": status,
        "paymentDone": paymentDone,
        "isSip": isSip,
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
        "payment": payment?.toJson(),
        "paymentStatus": paymentStatus,
        "mfppid": mfppid,
        "nav":nav,
    };
}

class Payment {
    String? paymentType;
    String? status;
    int? amount;
    DateTime? debitDate;
    int? amcOrderIds;
    String? failedReason;
    String? method;
    DateTime? createdAt;
    dynamic submittedAt;
    dynamic debitConfirmedAt;
    DateTime? failedAt;
    dynamic transferInitiatedAt;
    dynamic settledAt;
    dynamic rejectedAt;
    int? fromBankAccountId;
    String? providerName;
    dynamic failureCode;
    int? id;

    Payment({
        this.paymentType,
        this.status,
        this.amount,
        this.debitDate,
        this.amcOrderIds,
        this.failedReason,
        this.method,
        this.createdAt,
        this.submittedAt,
        this.debitConfirmedAt,
        this.failedAt,
        this.transferInitiatedAt,
        this.settledAt,
        this.rejectedAt,
        this.fromBankAccountId,
        this.providerName,
        this.failureCode,
        this.id,
    });

    factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        paymentType: json["payment_type"],
        status: json["status"],
        amount: json["amount"],
        debitDate: json["debit_date"] == null ? null : DateTime.parse(json["debit_date"]),
        amcOrderIds: json["amc_order_ids"],
        failedReason: json["failed_reason"],
        method: json["method"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        submittedAt: json["submitted_at"],
        debitConfirmedAt: json["debit_confirmed_at"],
        failedAt: json["failed_at"] == null ? null : DateTime.parse(json["failed_at"]),
        transferInitiatedAt: json["transfer_initiated_at"],
        settledAt: json["settled_at"],
        rejectedAt: json["rejected_at"],
        fromBankAccountId: json["from_bank_account_id"],
        providerName: json["provider_name"],
        failureCode: json["failure_code"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "payment_type": paymentType,
        "status": status,
        "amount": amount,
        "debit_date": "${debitDate!.year.toString().padLeft(4, '0')}-${debitDate!.month.toString().padLeft(2, '0')}-${debitDate!.day.toString().padLeft(2, '0')}",
        "amc_order_ids": amcOrderIds,
        "failed_reason": failedReason,
        "method": method,
        "created_at": createdAt?.toIso8601String(),
        "submitted_at": submittedAt,
        "debit_confirmed_at": debitConfirmedAt,
        "failed_at": failedAt?.toIso8601String(),
        "transfer_initiated_at": transferInitiatedAt,
        "settled_at": settledAt,
        "rejected_at": rejectedAt,
        "from_bank_account_id": fromBankAccountId,
        "provider_name": providerName,
        "failure_code": failureCode,
        "id": id,
    };
}
