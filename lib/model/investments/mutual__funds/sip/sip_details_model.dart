import 'dart:convert';

List<SipDetailsModel> sipDetailsModelFromJson(String str) => List<SipDetailsModel>.from(json.decode(str).map((x) => SipDetailsModel.fromJson(x)));

String sipDetailsModelToJson(List<SipDetailsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SipDetailsModel {
    Sip? sip;
    MasterData? masterData;
    FundDetails? fundDetails;
    AmcNav? amcNav;
    double? currentValue;

    SipDetailsModel({
        this.sip,
        this.masterData,
        this.fundDetails,
        this.amcNav,
        this.currentValue,
    });

    factory SipDetailsModel.fromJson(Map<String, dynamic> json) => SipDetailsModel(
        sip: json["sip"] == null ? null : Sip.fromJson(json["sip"]),
        masterData: json["masterData"] == null ? null : MasterData.fromJson(json["masterData"]),
        fundDetails: json["fundDetails"] == null ? null : FundDetails.fromJson(json["fundDetails"]),
        amcNav: json["amcNav"] == null ? null : AmcNav.fromJson(json["amcNav"]),
        currentValue: json["currentValue"] == null ?  0.0 : json["currentValue"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "sip": sip?.toJson(),
        "masterData": masterData?.toJson(),
        "fundDetails": fundDetails?.toJson(),
        "amcNav": amcNav?.toJson(),
    };
}

class AmcNav {
    String? id;
    Meta? meta;
    List<Datum>? data;
    int? v;

    AmcNav({
        this.id,
        this.meta,
        this.data,
        this.v,
    });

    factory AmcNav.fromJson(Map<String, dynamic> json) => AmcNav(
        id: json["_id"],
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "meta": meta?.toJson(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "__v": v,
    };
}

class Datum {
    String? date;
    String? nav;
    String? id;

    Datum({
        this.date,
        this.nav,
        this.id,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        date: json["date"],
        nav: json["nav"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "date": date,
        "nav": nav,
        "_id": id,
    };
}

class Meta {
    String? fundHouse;
    String? schemeType;
    String? schemeCategory;
    int? schemeCode;
    String? schemeName;
    String? id;

    Meta({
        this.fundHouse,
        this.schemeType,
        this.schemeCategory,
        this.schemeCode,
        this.schemeName,
        this.id,
    });

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        fundHouse: json["fund_house"],
        schemeType: json["scheme_type"],
        schemeCategory: json["scheme_category"],
        schemeCode: json["scheme_code"],
        schemeName: json["scheme_name"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "fund_house": fundHouse,
        "scheme_type": schemeType,
        "scheme_category": schemeCategory,
        "scheme_code": schemeCode,
        "scheme_name": schemeName,
        "_id": id,
    };
}

class FundDetails {
    SipFrequencySpecificData? sipFrequencySpecificData;
    PFrequencySpecificData? swpFrequencySpecificData;
    PFrequencySpecificData? stpFrequencySpecificData;
    NameChanges? nameChanges;
    PFrequencyData? sipFrequencyData;
    PFrequencyData? swpFrequencyData;
    PFrequencyData? stpFrequencyData;
    String? id;
    int? fundSchemeId;
    String? name;
    String? investmentOption;
    int? minInitialInvestment;
    int? minAdditionalInvestment;
    int? initialInvestmentMultiples;
    String? amfiCode;
    String? isin;
    int? amcId;
    int? rtaId;
    int? v;

    FundDetails({
        this.nameChanges,
        this.sipFrequencyData,
        this.swpFrequencyData,
        this.stpFrequencyData,
        this.id,
        this.fundSchemeId,
        this.name,
        this.investmentOption,
        this.minInitialInvestment,
        this.minAdditionalInvestment,
        this.initialInvestmentMultiples,
        this.amfiCode,
        this.isin,
        this.amcId,
        this.rtaId,
        this.v,
    });

    factory FundDetails.fromJson(Map<String, dynamic> json) => FundDetails(
        nameChanges: json["name_changes"] == null ? null : NameChanges.fromJson(json["name_changes"]),
        sipFrequencyData: json["sip_frequency_data"] == null ? null : PFrequencyData.fromJson(json["sip_frequency_data"]),
        swpFrequencyData: json["swp_frequency_data"] == null ? null : PFrequencyData.fromJson(json["swp_frequency_data"]),
        stpFrequencyData: json["stp_frequency_data"] == null ? null : PFrequencyData.fromJson(json["stp_frequency_data"]),
        id: json["_id"],
        fundSchemeId: json["fund_scheme_id"],
        name: json["name"],
        investmentOption: json["investment_option"],
        minInitialInvestment: json["min_initial_investment"],
        minAdditionalInvestment: json["min_additional_investment"],
        initialInvestmentMultiples: json["initial_investment_multiples"],
        amfiCode: json["amfi_code"],
        isin: json["isin"],
        amcId: json["amc_id"],
        rtaId: json["rta_id"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "sip_frequency_specific_data": sipFrequencySpecificData?.toJson(),
        "swp_frequency_specific_data": swpFrequencySpecificData?.toJson(),
        "stp_frequency_specific_data": stpFrequencySpecificData?.toJson(),
        "name_changes": nameChanges?.toJson(),
        "sip_frequency_data": sipFrequencyData?.toJson(),
        "swp_frequency_data": swpFrequencyData?.toJson(),
        "stp_frequency_data": stpFrequencyData?.toJson(),
        "_id": id,
        "fund_scheme_id": fundSchemeId,
        "name": name,
        "investment_option": investmentOption,
        "min_initial_investment": minInitialInvestment,
        "min_additional_investment": minAdditionalInvestment,
        "initial_investment_multiples": initialInvestmentMultiples,
        "amfi_code": amfiCode,
        "isin": isin,
        "amc_id": amcId,
        "rta_id": rtaId,
        "__v": v,
    };
}

class NameChanges {
    List<History>? history;

    NameChanges({
        this.history,
    });

    factory NameChanges.fromJson(Map<String, dynamic> json) => NameChanges(
        history: json["history"] == null ? [] : List<History>.from(json["history"]!.map((x) => History.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "history": history == null ? [] : List<dynamic>.from(history!.map((x) => x.toJson())),
    };
}

class History {
    String? oldName;
    DateTime? oldNameValidUpto;
    String? id;

    History({
        this.oldName,
        this.oldNameValidUpto,
        this.id,
    });

    factory History.fromJson(Map<String, dynamic> json) => History(
        oldName: json["old_name"],
        oldNameValidUpto: json["old_name_valid_upto"] == null ? null : DateTime.parse(json["old_name_valid_upto"]),
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "old_name": oldName,
        "old_name_valid_upto": "${oldNameValidUpto!.year.toString().padLeft(4, '0')}-${oldNameValidUpto!.month.toString().padLeft(2, '0')}-${oldNameValidUpto!.day.toString().padLeft(2, '0')}",
        "_id": id,
    };
}

class PFrequencyData {
    String? monthly;

    PFrequencyData({
        this.monthly,
    });

    factory PFrequencyData.fromJson(Map<String, dynamic> json) => PFrequencyData(
        monthly: json["MONTHLY"],
    );

    Map<String, dynamic> toJson() => {
        "MONTHLY": monthly,
    };
}

class SipFrequencySpecificData {
    Monthly? monthly;
    Rly? quarterly;
    Rly? halfYearly;
    Rly? yearly;

    SipFrequencySpecificData({
        this.monthly,
        this.quarterly,
        this.halfYearly,
        this.yearly,
    });

    factory SipFrequencySpecificData.fromJson(Map<String, dynamic> json) => SipFrequencySpecificData(
        monthly: json["monthly"] == null ? null : Monthly.fromJson(json["monthly"]),
        quarterly: json["quarterly"] == null ? null : Rly.fromJson(json["quarterly"]),
        halfYearly: json["half_yearly"] == null ? null : Rly.fromJson(json["half_yearly"]),
        yearly: json["yearly"] == null ? null : Rly.fromJson(json["yearly"]),
    );

    Map<String, dynamic> toJson() => {
        "monthly": monthly?.toJson(),
        "quarterly": quarterly?.toJson(),
        "half_yearly": halfYearly?.toJson(),
        "yearly": yearly?.toJson(),
    };
}

class Rly {
    List<dynamic>? dates;

    Rly({
        this.dates,
    });

    factory Rly.fromJson(Map<String, dynamic> json) => Rly(
        dates: json["dates"] == null ? [] : List<dynamic>.from(json["dates"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "dates": dates == null ? [] : List<dynamic>.from(dates!.map((x) => x)),
    };
}

class Monthly {
    List<int>? dates;
    int? minInstallmentAmount;
    int? maxInstallmentAmount;
    int? amountMultiples;
    int? minInstallments;

    Monthly({
        this.dates,
        this.minInstallmentAmount,
        this.maxInstallmentAmount,
        this.amountMultiples,
        this.minInstallments,
    });

    factory Monthly.fromJson(Map<String, dynamic> json) => Monthly(
        dates: json["dates"] == null ? [] : List<int>.from(json["dates"]!.map((x) => x)),
        minInstallmentAmount: json["min_installment_amount"],
        maxInstallmentAmount: json["max_installment_amount"],
        amountMultiples: json["amount_multiples"],
        minInstallments: json["min_installments"],
    );

    Map<String, dynamic> toJson() => {
        "dates": dates == null ? [] : List<dynamic>.from(dates!.map((x) => x)),
        "min_installment_amount": minInstallmentAmount,
        "max_installment_amount": maxInstallmentAmount,
        "amount_multiples": amountMultiples,
        "min_installments": minInstallments,
    };
}

class PFrequencySpecificData {
    Monthly? monthly;
    Monthly? quarterly;
    Rly? halfYearly;
    Rly? yearly;

    PFrequencySpecificData({
        this.monthly,
        this.quarterly,
        this.halfYearly,
        this.yearly,
    });

    factory PFrequencySpecificData.fromJson(Map<String, dynamic> json) => PFrequencySpecificData(
        monthly: json["monthly"] == null ? null : Monthly.fromJson(json["monthly"]),
        quarterly: json["quarterly"] == null ? null : Monthly.fromJson(json["quarterly"]),
        halfYearly: json["half_yearly"] == null ? null : Rly.fromJson(json["half_yearly"]),
        yearly: json["yearly"] == null ? null : Rly.fromJson(json["yearly"]),
    );

    Map<String, dynamic> toJson() => {
        "monthly": monthly?.toJson(),
        "quarterly": quarterly?.toJson(),
        "half_yearly": halfYearly?.toJson(),
        "yearly": yearly?.toJson(),
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

class Sip {
    String? id;
    String? userId;
    String? object;
    String? sipId;
    String? mfInvestmentAccount;
    dynamic folioNumber;
    String? scheme;
    int? amount;
    bool? systematic;
    String? frequency;
    int? installmentDay;
    dynamic requestedActivationDate;
    int? numberOfInstallments;
    DateTime? startDate;
    DateTime? endDate;
    DateTime? nextInstallmentDate;
    DateTime? previousInstallmentDate;
    int? remainingInstallments;
    String? state;
    bool? autoGenerateInstallments;
    String? paymentMethod;
    String? paymentSource;
    String? purpose;
    dynamic sourceRefId;
    dynamic partner;
    String? gateway;
    dynamic euin;
    dynamic userIp;
    dynamic serverIp;
    String? initiatedBy;
    String? initiatedVia;
    DateTime? createdAt;
    DateTime? activatedAt;
    dynamic cancelledAt;
    dynamic cancellationScheduledOn;
    dynamic failedAt;
    dynamic completedAt;
    dynamic reason;
    int? v;

    Sip({
        this.id,
        this.userId,
        this.object,
        this.sipId,
        this.mfInvestmentAccount,
        this.folioNumber,
        this.scheme,
        this.amount,
        this.systematic,
        this.frequency,
        this.installmentDay,
        this.requestedActivationDate,
        this.numberOfInstallments,
        this.startDate,
        this.endDate,
        this.nextInstallmentDate,
        this.previousInstallmentDate,
        this.remainingInstallments,
        this.state,
        this.autoGenerateInstallments,
        this.paymentMethod,
        this.paymentSource,
        this.purpose,
        this.sourceRefId,
        this.partner,
        this.gateway,
        this.euin,
        this.userIp,
        this.serverIp,
        this.initiatedBy,
        this.initiatedVia,
        this.createdAt,
        this.activatedAt,
        this.cancelledAt,
        this.cancellationScheduledOn,
        this.failedAt,
        this.completedAt,
        this.reason,
        this.v,
    });

    factory Sip.fromJson(Map<String, dynamic> json) => Sip(
        id: json["_id"],
        userId: json["userId"],
        object: json["object"],
        sipId: json["id"],
        mfInvestmentAccount: json["mf_investment_account"],
        folioNumber: json["folio_number"],
        scheme: json["scheme"],
        amount: json["amount"],
        systematic: json["systematic"],
        frequency: json["frequency"],
        installmentDay: json["installment_day"],
        requestedActivationDate: json["requested_activation_date"],
        numberOfInstallments: json["number_of_installments"],
        startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
        endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        nextInstallmentDate: json["next_installment_date"] == null ? null : DateTime.parse(json["next_installment_date"]),
        previousInstallmentDate: json["previous_installment_date"] == null ? null : DateTime.parse(json["previous_installment_date"]),
        remainingInstallments: json["remaining_installments"],
        state: json["state"],
        autoGenerateInstallments: json["auto_generate_installments"],
        paymentMethod: json["payment_method"],
        paymentSource: json["payment_source"],
        purpose: json["purpose"],
        sourceRefId: json["source_ref_id"],
        partner: json["partner"],
        gateway: json["gateway"],
        euin: json["euin"],
        userIp: json["user_ip"],
        serverIp: json["server_ip"],
        initiatedBy: json["initiated_by"],
        initiatedVia: json["initiated_via"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        activatedAt: json["activated_at"] == null ? null : DateTime.parse(json["activated_at"]),
        cancelledAt: json["cancelled_at"],
        cancellationScheduledOn: json["cancellation_scheduled_on"],
        failedAt: json["failed_at"],
        completedAt: json["completed_at"],
        reason: json["reason"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "object": object,
        "id": sipId,
        "mf_investment_account": mfInvestmentAccount,
        "folio_number": folioNumber,
        "scheme": scheme,
        "amount": amount,
        "systematic": systematic,
        "frequency": frequency,
        "installment_day": installmentDay,
        "requested_activation_date": requestedActivationDate,
        "number_of_installments": numberOfInstallments,
        "start_date": startDate?.toIso8601String(),
        "end_date": endDate?.toIso8601String(),
        "next_installment_date": nextInstallmentDate?.toIso8601String(),
        "previous_installment_date": previousInstallmentDate?.toIso8601String(),
        "remaining_installments": remainingInstallments,
        "state": state,
        "auto_generate_installments": autoGenerateInstallments,
        "payment_method": paymentMethod,
        "payment_source": paymentSource,
        "purpose": purpose,
        "source_ref_id": sourceRefId,
        "partner": partner,
        "gateway": gateway,
        "euin": euin,
        "user_ip": userIp,
        "server_ip": serverIp,
        "initiated_by": initiatedBy,
        "initiated_via": initiatedVia,
        "created_at": createdAt?.toIso8601String(),
        "activated_at": activatedAt?.toIso8601String(),
        "cancelled_at": cancelledAt,
        "cancellation_scheduled_on": cancellationScheduledOn,
        "failed_at": failedAt,
        "completed_at": completedAt,
        "reason": reason,
        "__v": v,
    };
}