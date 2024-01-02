// To parse this JSON data, do
//
//     final mutualFundSchemeDetailsModel = mutualFundSchemeDetailsModelFromJson(jsonString);

import 'dart:convert';

MutualFundSchemeDetailsModel mutualFundSchemeDetailsModelFromJson(String str) => MutualFundSchemeDetailsModel.fromJson(json.decode(str));

String mutualFundSchemeDetailsModelToJson(MutualFundSchemeDetailsModel data) => json.encode(data.toJson());

class MutualFundSchemeDetailsModel {
    SchemeDetails? schemeDetails;
    AmcFundDetails? amcFundDetails;

    MutualFundSchemeDetailsModel({
        this.schemeDetails,
        this.amcFundDetails,
    });

    factory MutualFundSchemeDetailsModel.fromJson(Map<String, dynamic> json) => MutualFundSchemeDetailsModel(
        schemeDetails: json["schemeDetails"] == "" ? null : SchemeDetails.fromJson(json["schemeDetails"]),
        amcFundDetails: json["amcFundDetails"] == "" ? null : AmcFundDetails.fromJson(json["amcFundDetails"]),
    );

    Map<String, dynamic> toJson() => {
        "schemeDetails": schemeDetails?.toJson(),
        "amcFundDetails": amcFundDetails?.toJson(),
    };
}

class AmcFundDetails {
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
    int? maxInitialInvestment;
    int? maxAdditionalInvestment;
    int? additionalInvestmentMultiples;
    int? minWithdrawalAmount;
    double? minWithdrawalUnits;
    int? maxWithdrawalAmount;
    int? maxWithdrawalUnits;
    int? withdrawalMultiples;
    double? withdrawalMultiplesUnits;
    bool? sipAllowed;
    bool? swpAllowed;
    bool? stpOutAllowed;
    bool? stpInAllowed;
    bool? switchInAllowed;
    int? minSwitchInAmount;
    double? switchInAmountMultiples;
    String? fundCategory;
    String? planType;
    String? subCategory;
    String? amfiCode;
    String? isin;
    bool? closeEnded;
    String? schemeCode;
    bool? lockIn;
    dynamic lockInPeriod;
    dynamic longTermPeriod;
    bool? purchaseAllowed;
    bool? redemptionAllowed;
    bool? instaRedemptionAllowed;
    bool? merged;
    String? mergedToIsin;
    dynamic mergerDate;
    bool? switchOutAllowed;
    int? minSwitchOutAmount;
    double? minSwitchOutUnits;
    double? switchOutUnitMultiples;
    double? switchOutAmountMultiples;
    int? amcId;
    int? rtaId;
    bool? active;
    String? deliveryMode;
    double? switchMultiples;
    int? switchInMinAmt;
    int? minSipAmount;
    int? minSwpAmount;
    int? minStpInAmount;
    int? maxSipAmount;
    int? maxSwpAmount;
    int? maxStpInAmount;
    int? minSipInstallments;
    int? minStpOutInstallments;
    int? minSwpInstallments;
    int? sipMultiples;
    int? swpMultiples;
    int? stpInAmountMultiples;
    int? v;

    AmcFundDetails({
        this.sipFrequencySpecificData,
        this.swpFrequencySpecificData,
        this.stpFrequencySpecificData,
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
        this.maxInitialInvestment,
        this.maxAdditionalInvestment,
        this.additionalInvestmentMultiples,
        this.minWithdrawalAmount,
        this.minWithdrawalUnits,
        this.maxWithdrawalAmount,
        this.maxWithdrawalUnits,
        this.withdrawalMultiples,
        this.withdrawalMultiplesUnits,
        this.sipAllowed,
        this.swpAllowed,
        this.stpOutAllowed,
        this.stpInAllowed,
        this.switchInAllowed,
        this.minSwitchInAmount,
        this.switchInAmountMultiples,
        this.fundCategory,
        this.planType,
        this.subCategory,
        this.amfiCode,
        this.isin,
        this.closeEnded,
        this.schemeCode,
        this.lockIn,
        this.lockInPeriod,
        this.longTermPeriod,
        this.purchaseAllowed,
        this.redemptionAllowed,
        this.instaRedemptionAllowed,
        this.merged,
        this.mergedToIsin,
        this.mergerDate,
        this.switchOutAllowed,
        this.minSwitchOutAmount,
        this.minSwitchOutUnits,
        this.switchOutUnitMultiples,
        this.switchOutAmountMultiples,
        this.amcId,
        this.rtaId,
        this.active,
        this.deliveryMode,
        this.switchMultiples,
        this.switchInMinAmt,
        this.minSipAmount,
        this.minSwpAmount,
        this.minStpInAmount,
        this.maxSipAmount,
        this.maxSwpAmount,
        this.maxStpInAmount,
        this.minSipInstallments,
        this.minStpOutInstallments,
        this.minSwpInstallments,
        this.sipMultiples,
        this.swpMultiples,
        this.stpInAmountMultiples,
        this.v,
    });

    factory AmcFundDetails.fromJson(Map<String, dynamic> json) => AmcFundDetails(
        sipFrequencySpecificData: json["sip_frequency_specific_data"] == null ? null : SipFrequencySpecificData.fromJson(json["sip_frequency_specific_data"]),
        swpFrequencySpecificData: json["swp_frequency_specific_data"] == null ? null : PFrequencySpecificData.fromJson(json["swp_frequency_specific_data"]),
        stpFrequencySpecificData: json["stp_frequency_specific_data"] == null ? null : PFrequencySpecificData.fromJson(json["stp_frequency_specific_data"]),
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
        maxInitialInvestment: json["max_initial_investment"],
        maxAdditionalInvestment: json["max_additional_investment"],
        additionalInvestmentMultiples: json["additional_investment_multiples"],
        minWithdrawalAmount: json["min_withdrawal_amount"],
        minWithdrawalUnits: json["min_withdrawal_units"]?.toDouble(),
        maxWithdrawalAmount: json["max_withdrawal_amount"],
        maxWithdrawalUnits: json["max_withdrawal_units"],
        withdrawalMultiples: json["withdrawal_multiples"],
        withdrawalMultiplesUnits: json["withdrawal_multiples_units"]?.toDouble(),
        sipAllowed: json["sip_allowed"],
        swpAllowed: json["swp_allowed"],
        stpOutAllowed: json["stp_out_allowed"],
        stpInAllowed: json["stp_in_allowed"],
        switchInAllowed: json["switch_in_allowed"],
        minSwitchInAmount: json["min_switch_in_amount"],
        switchInAmountMultiples: json["switch_in_amount_multiples"]?.toDouble(),
        fundCategory: json["fund_category"],
        planType: json["plan_type"],
        subCategory: json["sub_category"],
        amfiCode: json["amfi_code"],
        isin: json["isin"],
        closeEnded: json["close_ended"],
        schemeCode: json["scheme_code"],
        lockIn: json["lock_in"],
        lockInPeriod: json["lock_in_period"],
        longTermPeriod: json["long_term_period"],
        purchaseAllowed: json["purchase_allowed"],
        redemptionAllowed: json["redemption_allowed"],
        instaRedemptionAllowed: json["insta_redemption_allowed"],
        merged: json["merged"],
        mergedToIsin: json["merged_to_isin"],
        mergerDate: json["merger_date"],
        switchOutAllowed: json["switch_out_allowed"],
        minSwitchOutAmount: json["min_switch_out_amount"],
        minSwitchOutUnits: json["min_switch_out_units"]?.toDouble(),
        switchOutUnitMultiples: json["switch_out_unit_multiples"]?.toDouble(),
        switchOutAmountMultiples: json["switch_out_amount_multiples"]?.toDouble(),
        amcId: json["amc_id"],
        rtaId: json["rta_id"],
        active: json["active"],
        deliveryMode: json["delivery_mode"],
        switchMultiples: json["switch_multiples"]?.toDouble(),
        switchInMinAmt: json["switch_in_min_amt"],
        minSipAmount: json["min_sip_amount"],
        minSwpAmount: json["min_swp_amount"],
        minStpInAmount: json["min_stp_in_amount"],
        maxSipAmount: json["max_sip_amount"],
        maxSwpAmount: json["max_swp_amount"],
        maxStpInAmount: json["max_stp_in_amount"],
        minSipInstallments: json["min_sip_installments"],
        minStpOutInstallments: json["min_stp_out_installments"],
        minSwpInstallments: json["min_swp_installments"],
        sipMultiples: json["sip_multiples"],
        swpMultiples: json["swp_multiples"],
        stpInAmountMultiples: json["stp_in_amount_multiples"],
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
        "max_initial_investment": maxInitialInvestment,
        "max_additional_investment": maxAdditionalInvestment,
        "additional_investment_multiples": additionalInvestmentMultiples,
        "min_withdrawal_amount": minWithdrawalAmount,
        "min_withdrawal_units": minWithdrawalUnits,
        "max_withdrawal_amount": maxWithdrawalAmount,
        "max_withdrawal_units": maxWithdrawalUnits,
        "withdrawal_multiples": withdrawalMultiples,
        "withdrawal_multiples_units": withdrawalMultiplesUnits,
        "sip_allowed": sipAllowed,
        "swp_allowed": swpAllowed,
        "stp_out_allowed": stpOutAllowed,
        "stp_in_allowed": stpInAllowed,
        "switch_in_allowed": switchInAllowed,
        "min_switch_in_amount": minSwitchInAmount,
        "switch_in_amount_multiples": switchInAmountMultiples,
        "fund_category": fundCategory,
        "plan_type": planType,
        "sub_category": subCategory,
        "amfi_code": amfiCode,
        "isin": isin,
        "close_ended": closeEnded,
        "scheme_code": schemeCode,
        "lock_in": lockIn,
        "lock_in_period": lockInPeriod,
        "long_term_period": longTermPeriod,
        "purchase_allowed": purchaseAllowed,
        "redemption_allowed": redemptionAllowed,
        "insta_redemption_allowed": instaRedemptionAllowed,
        "merged": merged,
        "merged_to_isin": mergedToIsin,
        "merger_date": mergerDate,
        "switch_out_allowed": switchOutAllowed,
        "min_switch_out_amount": minSwitchOutAmount,
        "min_switch_out_units": minSwitchOutUnits,
        "switch_out_unit_multiples": switchOutUnitMultiples,
        "switch_out_amount_multiples": switchOutAmountMultiples,
        "amc_id": amcId,
        "rta_id": rtaId,
        "active": active,
        "delivery_mode": deliveryMode,
        "switch_multiples": switchMultiples,
        "switch_in_min_amt": switchInMinAmt,
        "min_sip_amount": minSipAmount,
        "min_swp_amount": minSwpAmount,
        "min_stp_in_amount": minStpInAmount,
        "max_sip_amount": maxSipAmount,
        "max_swp_amount": maxSwpAmount,
        "max_stp_in_amount": maxStpInAmount,
        "min_sip_installments": minSipInstallments,
        "min_stp_out_installments": minStpOutInstallments,
        "min_swp_installments": minSwpInstallments,
        "sip_multiples": sipMultiples,
        "swp_multiples": swpMultiples,
        "stp_in_amount_multiples": stpInAmountMultiples,
        "__v": v,
    };
}

class NameChanges {
    List<dynamic>? history;

    NameChanges({
        this.history,
    });

    factory NameChanges.fromJson(Map<String, dynamic> json) => NameChanges(
        history: json["history"] == null ? [] : List<dynamic>.from(json["history"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "history": history == null ? [] : List<dynamic>.from(history!.map((x) => x)),
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

class SchemeDetails {
    String? id;
    Meta? meta;
    List<Datum>? data;
    DateTime? createdAt;
    double? growthPercentage;

    SchemeDetails({
        this.id,
        this.meta,
        this.data,
        this.createdAt,
        this.growthPercentage,
    });

    factory SchemeDetails.fromJson(Map<String, dynamic> json) => SchemeDetails(
        id: json["_id"],
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        createdAt: json["createdAt"] == null ? DateTime.now() : DateTime.parse(json["createdAt"]),
        growthPercentage: json["growthPercentage"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "meta": meta?.toJson(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "createdAt":createdAt,
        "growthPercentage": growthPercentage,
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
        fundHouse: json["fund_house"] ?? "",
        schemeType: json["scheme_type"] ?? "",
        schemeCategory: json["scheme_category"] ?? "",
        schemeCode: json["scheme_code"] ?? 0,
        schemeName: json["scheme_name"] ?? "",
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
