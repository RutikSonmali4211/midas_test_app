// ignore_for_file: use_build_context_synchronously

import 'package:midas/Widgets/appbar/large_appbar.dart';
import 'package:midas/Widgets/buttons/large_button.dart';
import 'package:midas/constant/colors.dart';
import 'package:midas/constant/sizeConstant.dart';
import 'package:midas/constant/size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:midas/controller/sms/sms_controller.dart';
import 'package:midas/screen/Investments/mutual_funds/sip/mutual_funds_sip.dart';
import 'package:midas/widgets/alert_message/alert_message.dart';
import 'package:midas/widgets/confirmation_dialog_box.dart';
import 'package:get/get.dart';
import 'package:midas/controller/investment/mutual_funds/mutual_funds_controller.dart';
import 'package:midas/widgets/otp_verification.dart';

import '../../../constant/date_util.dart';

class MutualFundSchemeSIP extends StatefulWidget {
  final bool isUpdate;
  final String amfiCode;
  final String isinNumber;
  final String folioNumber;
  final String sipid;
  const MutualFundSchemeSIP({
    super.key,
    required this.isUpdate,
    required this.amfiCode,
    required this.isinNumber,
    required this.folioNumber,
    required this.sipid,
  });

  @override
  State<MutualFundSchemeSIP> createState() => _MutualFundSchemeSIPState();
}

class _MutualFundSchemeSIPState extends State<MutualFundSchemeSIP> {
  var height;
  var width;

  MutualFundsController mutualFundsController =
      Get.put(MutualFundsController());
  String selectedTimeline = '20';
  @override
  void initState() {
    super.initState();
    frequencyController.text = _selectedFrequency.toString();
    if (widget.amfiCode.isNotEmpty) {
      mutualFundsController.getMutualFundSchemeDetailsByAmfiCode(
          widget.amfiCode, selectedTimeline, context);
    }
    if (widget.sipid.isNotEmpty && widget.isUpdate) {
      setPresentDetails();
    }
    // _selectedDate = now.day.toString();
    // frequencyController.text = _selectedFrequency;
  }

  TextEditingController dateController = TextEditingController();
  TextEditingController frequencyController = TextEditingController();
  setPresentDetails() async {
    final Map<String, dynamic> data =
        await mutualFundsController.getSIPDetailsById(widget.sipid, context);
    if (data["status"] == true) {
      setState(() {
        frequencyController.text = data["result"][0]["frequency"].toString();
        dateController.text = data["result"][0]["installment_day"].toString();
        sipAmountController.text = data["result"][0]["amount"].toString();
      });
    }
  }

  SmsController smsController = Get.put(SmsController());

  bool _showDateDropdown = false;
  bool _showFrequencyDropdown = false;
  DateTime now = DateTime.now();
  String _selectedDate = "";
  String _selectedFrequency = "monthly";
  int numberOfInstallments = 72;
  List<String> frequencyList = ["monthly"];
  List<String> dateList = DateUtil.getDaysListInCurrentMonth();
  TextEditingController sipAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    height = screenSize.height;
    width = screenSize.width;
    return GestureDetector(
      onTap: () {
        setState(() {
          _showDateDropdown = false;
          _showFrequencyDropdown = false;
        });
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LargeAppbar(
                      heading: "",
                      isAmount: false,
                      isbackButtonAvailable: true,
                      content: "UTI AMC",
                      timeline:
                          "Last Updated: ${mutualFundsController.schedularLastUpdatedDate} | ${mutualFundsController.schedularLastUpdatedTime}"),
                  SizedBox(
                    height: SizeUtil.verticalSpacingMedium(context),
                  ),
                  Expanded(
                    child: mutualFundsController.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : Padding(
                            padding: EdgeInsets.only(
                              left: height * 0.02,
                              right: height * 0.02,
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 6,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Scheme',
                                              style: TextStyle(
                                                  color: AppColors.primary,
                                                  fontSize: SizeUtil.bodyLarge(
                                                      context),
                                                  fontFamily: "Helvetica"),
                                            ),
                                            const SizedBox(
                                              height: DefaultSizes
                                                  .spacingBetweenTexts,
                                            ),
                                            Text(
                                              mutualFundsController.schemeName
                                                  .toString(),
                                              style: TextStyle(
                                                  color: AppColors.grey,
                                                  fontSize:
                                                      SizeUtil.body(context),
                                                  fontFamily: "Helvetica"),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      Expanded(
                                        flex: 6,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Type',
                                              style: TextStyle(
                                                  color: AppColors.primary,
                                                  fontSize: SizeUtil.bodyLarge(
                                                      context),
                                                  fontFamily: "Helvetica"),
                                            ),
                                            const SizedBox(
                                              height: DefaultSizes
                                                  .spacingBetweenTexts,
                                            ),
                                            Text(
                                              mutualFundsController.schemeType
                                                  .toString(),
                                              style: TextStyle(
                                                  color: AppColors.grey,
                                                  fontSize:
                                                      SizeUtil.body(context),
                                                  fontFamily: "Helvetica"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height:
                                        SizeUtil.verticalSpacingMedium(context),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 6,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Category',
                                              style: TextStyle(
                                                  color: AppColors.primary,
                                                  fontSize: SizeUtil.bodyLarge(
                                                      context),
                                                  fontFamily: "Helvetica"),
                                            ),
                                            const SizedBox(
                                              height: DefaultSizes
                                                  .spacingBetweenTexts,
                                            ),
                                            Text(
                                              mutualFundsController
                                                  .schemeCategory
                                                  .toString(),
                                              style: TextStyle(
                                                  color: AppColors.grey,
                                                  fontSize:
                                                      SizeUtil.body(context),
                                                  fontFamily: "Helvetica"),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      Expanded(
                                        flex: 6,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Current NAV',
                                              style: TextStyle(
                                                  color: AppColors.primary,
                                                  fontSize: SizeUtil.bodyLarge(
                                                      context),
                                                  fontFamily: "Helvetica"),
                                            ),
                                            const SizedBox(
                                              height: DefaultSizes
                                                  .spacingBetweenTexts,
                                            ),
                                            RichText(
                                              textScaleFactor:
                                                  MediaQuery.of(context)
                                                      .textScaleFactor,
                                              textAlign: TextAlign.start,
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: '₹',
                                                    style: TextStyle(
                                                        letterSpacing: 2,
                                                        color: AppColors.grey,
                                                        fontSize: SizeUtil.body(
                                                            context)),
                                                  ),
                                                  TextSpan(
                                                    text: mutualFundsController
                                                        .currentNav
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: AppColors.grey,
                                                        fontSize: SizeUtil.body(
                                                            context),
                                                        fontFamily:
                                                            "Helvetica"),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height:
                                        SizeUtil.verticalSpacingMedium(context),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 6,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Minimum Investment',
                                              style: TextStyle(
                                                  color: AppColors.primary,
                                                  fontSize: SizeUtil.bodyLarge(
                                                      context),
                                                  fontFamily: "Helvetica"),
                                            ),
                                            const SizedBox(
                                              height: DefaultSizes
                                                  .spacingBetweenTexts,
                                            ),
                                            RichText(
                                              textScaleFactor:
                                                  MediaQuery.of(context)
                                                      .textScaleFactor,
                                              textAlign: TextAlign.start,
                                              text: TextSpan(
                                                children: [
                                                  if (mutualFundsController
                                                      .minimumInvestment
                                                      .isNotEmpty)
                                                    TextSpan(
                                                      text: '₹',
                                                      style: TextStyle(
                                                          letterSpacing: 2,
                                                          color: AppColors.grey,
                                                          fontSize:
                                                              SizeUtil.body(
                                                                  context)),
                                                    ),
                                                  TextSpan(
                                                    text: mutualFundsController
                                                            .minimumInvestment
                                                            .isEmpty
                                                        ? "-"
                                                        : mutualFundsController
                                                            .minimumInvestment
                                                            .toString(),
                                                    style: TextStyle(
                                                        color: AppColors.grey,
                                                        fontSize: SizeUtil.body(
                                                            context),
                                                        fontFamily:
                                                            "Helvetica"),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      Expanded(
                                        flex: 6,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Investment Multiple',
                                              style: TextStyle(
                                                  color: AppColors.primary,
                                                  fontSize: SizeUtil.bodyLarge(
                                                      context),
                                                  fontFamily: "Helvetica"),
                                            ),
                                            const SizedBox(
                                              height: DefaultSizes
                                                  .spacingBetweenTexts,
                                            ),
                                            RichText(
                                              textScaleFactor:
                                                  MediaQuery.of(context)
                                                      .textScaleFactor,
                                              textAlign: TextAlign.start,
                                              text: TextSpan(
                                                children: [
                                                  if (mutualFundsController
                                                      .investmentMultiple
                                                      .isNotEmpty)
                                                    TextSpan(
                                                      text: '₹',
                                                      style: TextStyle(
                                                          letterSpacing: 2,
                                                          color: AppColors.grey,
                                                          fontSize:
                                                              SizeUtil.body(
                                                                  context)),
                                                    ),
                                                  TextSpan(
                                                    text: mutualFundsController
                                                            .investmentMultiple
                                                            .isEmpty
                                                        ? "-"
                                                        : mutualFundsController
                                                            .investmentMultiple
                                                            .toString(),
                                                    style: TextStyle(
                                                        color: AppColors.grey,
                                                        fontSize: SizeUtil.body(
                                                            context),
                                                        fontFamily:
                                                            "Helvetica"),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height:
                                        SizeUtil.verticalSpacingMedium(context),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Investment Amount',
                                        style: TextStyle(
                                            color: AppColors.primary,
                                            fontSize:
                                                SizeUtil.bodyLarge(context),
                                            fontFamily: "Helvetica"),
                                      ),
                                      SizedBox(
                                        height: SizeUtil.verticalSpacingSmall(
                                            context),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 40),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: width * 0.12,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: TextFormField(
                                                  readOnly: true,
                                                  textAlign: TextAlign.center,
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: width * 0.04,
                                                      vertical: SizeUtil
                                                          .verticalSpacingMedium(
                                                              context),
                                                    ),
                                                    counterText: "",
                                                    filled: true,
                                                    isDense: true,
                                                    hintText: '₹',
                                                    hintStyle: TextStyle(
                                                        color: AppColors.grey,
                                                        fontSize: SizeUtil
                                                                .scallingFactor(
                                                                    context) *
                                                            24),
                                                    border: InputBorder.none,
                                                    fillColor: TextfieldColors
                                                        .background,
                                                  ),
                                                  style: TextStyle(
                                                      fontSize: SizeUtil
                                                              .scallingFactor(
                                                                  context) *
                                                          24,
                                                      color: AppColors.grey),
                                                  onTap: () {
                                                    setState(() {
                                                      _showDateDropdown = false;
                                                      _showFrequencyDropdown =
                                                          false;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              flex: 14,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: TextFormField(
                                                  controller:
                                                      sipAmountController,
                                                  maxLength: 15,
                                                  keyboardType:
                                                      const TextInputType
                                                              .numberWithOptions(
                                                          signed: true,
                                                          decimal: true),
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .digitsOnly,
                                                  ],
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                width * 0.04,
                                                            vertical: SizeUtil
                                                                .verticalSpacingMedium(
                                                                    context)),
                                                    counterText: "",
                                                    suffixIconConstraints:
                                                        const BoxConstraints(),
                                                    filled: true,
                                                    isDense: true,
                                                    border: InputBorder.none,
                                                    hintText: '1,000',
                                                    hintStyle: TextStyle(
                                                        color: AppColors.grey,
                                                        fontSize: SizeUtil
                                                                .scallingFactor(
                                                                    context) *
                                                            24),
                                                    fillColor: TextfieldColors
                                                        .background,
                                                  ),
                                                  style: TextStyle(
                                                      fontSize: SizeUtil
                                                              .scallingFactor(
                                                                  context) *
                                                          24),
                                                  onTap: () {
                                                    setState(() {
                                                      _showDateDropdown = false;
                                                      _showFrequencyDropdown =
                                                          false;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height:
                                        SizeUtil.verticalSpacingMedium(context),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 6,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Frequency',
                                              style: TextStyle(
                                                  color: AppColors.primary,
                                                  fontSize: SizeUtil.bodyLarge(
                                                      context),
                                                  fontFamily: "Helvetica"),
                                            ),
                                            const SizedBox(
                                              height: DefaultSizes
                                                  .spacingBetweenTexts,
                                            ),
                                            SizedBox(
                                              width: SizeUtil.scallingFactor(
                                                      context) *
                                                  150,
                                              child: Column(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    child: TextFormField(
                                                      controller:
                                                          frequencyController,
                                                      autovalidateMode:
                                                          AutovalidateMode
                                                              .onUserInteraction,
                                                      decoration:
                                                          InputDecoration(
                                                        suffixIcon: Icon(
                                                          Icons.arrow_drop_down,
                                                          size: SizeUtil
                                                              .iconsSize(
                                                                  context),
                                                          color:
                                                              AppColors.primary,
                                                        ),
                                                        suffixIconConstraints:
                                                            const BoxConstraints(),
                                                        filled: true,
                                                        isDense: true,
                                                        border:
                                                            InputBorder.none,
                                                        hintText: 'monthly',
                                                        hintStyle: TextStyle(
                                                            color:
                                                                AppColors.grey,
                                                            fontSize:
                                                                SizeUtil.body(
                                                                    context),
                                                            fontFamily:
                                                                "Helvetica"),
                                                        fillColor:
                                                            TextfieldColors
                                                                .background,
                                                      ),
                                                      readOnly: true,
                                                      onTap: widget.isUpdate
                                                          ? null
                                                          : _toggleFrequencyDropDown,
                                                      style: TextStyle(
                                                          fontSize:
                                                              SizeUtil.body(
                                                                  context),
                                                          color:
                                                              AppColors.black),
                                                    ),
                                                  ),
                                                  if (_showFrequencyDropdown)
                                                    Card(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              255,
                                                              254,
                                                              254),
                                                      elevation: 2,
                                                      child: ListView.builder(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        shrinkWrap: true,
                                                        itemCount: frequencyList
                                                            .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          final option =
                                                              frequencyList[
                                                                  index];
                                                          return GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                _selectedFrequency =
                                                                    option;
                                                                frequencyController
                                                                        .text =
                                                                    _selectedFrequency;
                                                                _showFrequencyDropdown =
                                                                    false;
                                                              });
                                                            },
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 8,
                                                                  horizontal:
                                                                      16),
                                                              child: Text(
                                                                option,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        SizeUtil.body(
                                                                            context)),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      //           Container(
                                      //   decoration: BoxDecoration(
                                      //     borderRadius: BorderRadius.circular(8.0),
                                      //     color:
                                      //         Colors.grey[200], // Gray background color
                                      //   ),
                                      //   child: DropdownButton<String>(
                                      //     // isDense: true,
                                      //     hint: const Text("select an option"),
                                      //     underline: const SizedBox(),
                                      //     padding: const EdgeInsets.symmetric(
                                      //         horizontal: 10),
                                      //     value: "1",
                                      //     onTap: () {
                                      //       // getContactUsDropdownData();
                                      //     },
                                      //     onChanged: (newValue) {
                                      //       setState(() {
                                      //         // _selectedValue = newValue!;
                                      //       });
                                      //     },
                                      //     icon: Icon(
                                      //       Icons.arrow_drop_down,
                                      //       size: SizeUtil.iconsSize(context),
                                      //       color: AppColors
                                      //           .primary,
                                      //     ),
                                      //     style: const TextStyle(
                                      //       color: AppColors.grey,
                                      //     ),
                                      //     items: dateList
                                      //         .map((String value) {
                                      //       return DropdownMenuItem<String>(
                                      //         value: value,
                                      //         child: Text(value,style: TextStyle(fontSize: 20),),
                                      //       );
                                      //     }).toList(),
                                      //   ),
                                      // ),
                                      Expanded(
                                        flex: 6,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Start Day',
                                              style: TextStyle(
                                                  color: AppColors.primary,
                                                  fontSize: SizeUtil.bodyLarge(
                                                      context),
                                                  fontFamily: "Helvetica"),
                                            ),
                                            const SizedBox(
                                              height: DefaultSizes
                                                  .spacingBetweenTexts,
                                            ),
                                            SizedBox(
                                              width: SizeUtil.scallingFactor(
                                                      context) *
                                                  100,
                                              child: Column(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    child: TextFormField(
                                                      controller:
                                                          dateController,
                                                      autovalidateMode:
                                                          AutovalidateMode
                                                              .onUserInteraction,
                                                      decoration:
                                                          InputDecoration(
                                                        suffixIcon: Icon(
                                                          Icons.arrow_drop_down,
                                                          size: SizeUtil
                                                              .iconsSize(
                                                                  context),
                                                          color:
                                                              AppColors.primary,
                                                        ),
                                                        suffixIconConstraints:
                                                            const BoxConstraints(),
                                                        filled: true,
                                                        isDense: true,
                                                        border:
                                                            InputBorder.none,
                                                        hintText: '14',
                                                        hintStyle: TextStyle(
                                                            color:
                                                                AppColors.grey,
                                                            fontSize:
                                                                SizeUtil.body(
                                                                    context),
                                                            fontFamily:
                                                                "Helvetica"),
                                                        fillColor:
                                                            TextfieldColors
                                                                .background,
                                                      ),
                                                      readOnly: true,
                                                      onTap: widget.isUpdate
                                                          ? null
                                                          : _toggleDateDropDown,
                                                      style: TextStyle(
                                                          fontSize:
                                                              SizeUtil.body(
                                                                  context),
                                                          color:
                                                              AppColors.black),
                                                    ),
                                                  ),
                                                  if (_showDateDropdown)
                                                    Material(
                                                      color: Colors.transparent,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(right: 0),
                                                        child: Card(
                                                          color:
                                                              AppColors.white,
                                                          elevation: 2,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              if (dateList
                                                                  .isEmpty)
                                                                ListTile(
                                                                  title: Text(
                                                                    'No Records Found',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          SizeUtil.body(
                                                                              context),
                                                                      fontFamily:
                                                                          "Helvetica",
                                                                    ),
                                                                  ),
                                                                  enabled:
                                                                      false,
                                                                ),
                                                              if (dateList
                                                                  .isNotEmpty)
                                                                SizedBox(
                                                                  height: 200,
                                                                  child: ListView
                                                                      .builder(
                                                                    shrinkWrap:
                                                                        true,
                                                                    padding:
                                                                        EdgeInsets
                                                                            .zero,
                                                                    itemCount:
                                                                        dateList
                                                                            .length,
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      final option =
                                                                          dateList[
                                                                              index];
                                                                      return ListTile(
                                                                        dense:
                                                                            true,
                                                                        title:
                                                                            Text(
                                                                          option,
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                "Helvetica",
                                                                            fontSize:
                                                                                SizeUtil.body(context),
                                                                          ),
                                                                        ),
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            _selectedDate =
                                                                                option;
                                                                            dateController.text =
                                                                                _selectedDate;
                                                                            _showDateDropdown =
                                                                                false;
                                                                          });
                                                                        },
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height:
                                        SizeUtil.verticalSpacingLarge(context),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.error_outline,
                                          size: SizeUtil.iconsSize(context)),
                                      SizedBox(
                                        width: width * 0.02,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Currently on monthly SIP is supported",
                                          style: TextStyle(
                                              color: AppColors.grey,
                                              fontSize: SizeUtil.body(context),
                                              fontFamily: "Helvetica"),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height:
                                        SizeUtil.verticalSpacingMedium(context),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.error_outline,
                                          size: SizeUtil.iconsSize(context)),
                                      SizedBox(
                                        width: width * 0.02,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "SIP will remain active until cancelled",
                                          style: TextStyle(
                                              color: AppColors.grey,
                                              fontSize: SizeUtil.body(context),
                                              fontFamily: "Helvetica"),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height:
                                        SizeUtil.verticalSpacingMedium(context),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.error_outline,
                                          size: SizeUtil.iconsSize(context)),
                                      SizedBox(
                                        width: width * 0.02,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "NAV allotment is based on the day funds are realised at the clearing corporation",
                                          style: TextStyle(
                                              color: AppColors.grey,
                                              fontSize: SizeUtil.body(context),
                                              fontFamily: "Helvetica"),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      height: SizeUtil.verticalSpacingMedium(
                                          context))
                                ],
                              ),
                            ),
                          ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: width * 0.10,
                        left: width * 0.10,
                        bottom: SizeUtil.buttonPaddingBottom(context)),
                    child: Container(
                      color: AppColors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          LargeButton(
                              text:
                                  widget.isUpdate ? "Update SIP" : "Create SIP",
                              backgroundColor: AppColors.primary,
                              textColor: AppColors.white,
                              onPressed: widget.isUpdate
                                  ? () {
                                      if (sipAmountController.text.isNotEmpty) {
                                        if (double.parse(mutualFundsController
                                                .minimumInvestment.value) <
                                            double.parse(
                                                sipAmountController.text)) {
                                          modifySIP(
                                              mutualFundsController.schemeName
                                                  .toString(),
                                              double.parse(
                                                  sipAmountController.text),
                                              widget.sipid);
                                        } else {
                                          showErrorAlert(
                                              "please enter amount grater than minimum investment amount");
                                        }
                                      } else {
                                        showErrorAlert(
                                            "please enter valid amount");
                                      }
                                    }
                                  : () {
                                      if (sipAmountController.text.isNotEmpty) {
                                        if (_selectedFrequency.isNotEmpty) {
                                          if (_selectedDate.isNotEmpty) {
                                            if (double.parse(
                                                    mutualFundsController
                                                        .minimumInvestment
                                                        .value) <
                                                double.parse(
                                                    sipAmountController.text)) {
                                              confirmSIP(
                                                  mutualFundsController
                                                      .schemeName
                                                      .toString(),
                                                  double.parse(
                                                      sipAmountController.text),
                                                  widget.isinNumber,
                                                  _selectedFrequency,
                                                  int.parse(_selectedDate),
                                                  numberOfInstallments);
                                            } else {
                                              showErrorAlert(
                                                  "please enter amount grater than minimum investment amount");
                                            }
                                          } else {
                                            showErrorAlert(
                                                "please select start day");
                                          }
                                        } else {
                                          showErrorAlert(
                                              "please select frequency");
                                        }
                                      } else {
                                        showErrorAlert(
                                            "please enter valid amount");
                                      }
                                    })
                        ],
                      ),
                    ),
                  ),
                ],
              ))),
    );
  }

  void _toggleDateDropDown() {
    setState(() {
      _showFrequencyDropdown = false;
      _showDateDropdown = !_showDateDropdown;
    });
  }

  void _toggleFrequencyDropDown() {
    setState(() {
      _showDateDropdown = false;
      _showFrequencyDropdown = !_showFrequencyDropdown;
    });
  }

  Future<void> confirmSIP(String schemeName, double amount, String isinNumber,
      String frequency, int installmentDay, int numberOfInstallments) async {
    await showDialog(
      context: this.context,
      builder: (BuildContext context) {
        return ConfirmDialogBox(
            onConfirm: () async {
              bool isSuccess = await mutualFundsController
                  .requestSIPPurchaseOrder(this.context);
              if (isSuccess) {
                showDialog(
                  barrierDismissible: false,
                  context: this.context,
                  builder: (BuildContext context) {
                    return OtpVerification(
                      mobileNumber:
                          mutualFundsController.userMobileNumber.toString(),
                      onConfirm: () async {
                        String otp = smsController.otpController.text;
                        if (otp.length == 6) {
                          smsController.otpController.clear();
                          await mutualFundsController
                              .verifyOtpAndConfirmSipMandate(
                                  isinNumber,
                                  amount,
                                  frequency,
                                  installmentDay,
                                  numberOfInstallments,
                                  otp,
                                  this.context);
                        } else {
                          showErrorAlert("please enter valid otp");
                        }
                      },
                    );
                  },
                );
              }
            },
            heading: "Confirm Order",
            body: "Invest Rs. $amount in $schemeName",
            message: "Orders cannot be cancelled after they are placed");
      },
    );
  }

  Future<void> modifySIP(String schemeName, double amount, String sipId) async {
    await showDialog(
      context: this.context,
      builder: (BuildContext context) {
        return ConfirmDialogBox(
            onConfirm: () async {
              bool isSuccess = await mutualFundsController
                  .createMandateForModifySip(amount, sipId, this.context);
              if (isSuccess) {
                Navigator.maybePop(
                  this.context,
                  MaterialPageRoute(
                      builder: (context) => const MutualFundsOrdersSIP()),
                ).then((value) =>
                    mutualFundsController.getSIPDetails(this.context, 1));
              }
            },
            heading: "Confirm Order",
            body: "Invest Rs. $amount in $schemeName",
            message: "Orders cannot be cancelled after they are placed");
      },
    );
  }
}
