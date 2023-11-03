// ignore_for_file: unrelated_type_equality_checks, use_build_context_synchronously

import 'package:get/get.dart';
import 'package:midas/Widgets/buttons/small_button.dart';
import 'package:midas/constant/colors.dart';
import 'package:midas/constant/sizeConstant.dart';
import 'package:midas/constant/size_util.dart';
import 'package:midas/controller/investment/other_assets/other_assets_controller.dart';
import 'package:midas/screen/notifications/notifications.dart';
import 'package:midas/screen/profile/profile_and_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'other_assets.dart';

class AddOtherAssets extends StatefulWidget {
  final bool isEdit;
  final bool isWatch;
  final String otherAssetId;
  final String assetName;
  final String purchasePrice;
  final String currentValue;
  final DateTime purchaseDate;
  const AddOtherAssets({
    super.key,
    required this.isEdit,
    required this.isWatch,
    required this.otherAssetId,
    required this.assetName,
    required this.purchasePrice,
    required this.currentValue,
    required this.purchaseDate,
  });

  @override
  State<AddOtherAssets> createState() => _AddOtherAssetsState();
}

class _AddOtherAssetsState extends State<AddOtherAssets> {
  final FocusNode assetFocusNode = FocusNode();
  final FocusNode purchasePriceNode = FocusNode();
  final FocusNode currentValueNode = FocusNode();
  final FocusNode purchaseDateNode = FocusNode();
  TextEditingController purchasePriceController = TextEditingController();
  TextEditingController assetController = TextEditingController();
  TextEditingController currentValueController = TextEditingController();
  TextEditingController purchaseDateController = TextEditingController();
  GlobalKey<FormState> addOtherAssetsFormKey = GlobalKey<FormState>();
  Future<void> _selectPurchaseDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        purchaseDateController.text =
            "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year.toString()}";
      });
    }
  }

  OtherAssetsController otherAssetsController =
      Get.put(OtherAssetsController());

  @override
  void initState() {
    super.initState();
    if (widget.isEdit || widget.isWatch) {
      assetController.text = widget.assetName;
      purchasePriceController.text = widget.purchasePrice;
      currentValueController.text = widget.currentValue;
      purchaseDateController.text =
          "${widget.purchaseDate.day.toString().padLeft(2, '0')}/${widget.purchaseDate.month.toString().padLeft(2, '0')}/${widget.purchaseDate.year.toString()}";
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  offset: Offset(0, 4),
                  blurRadius: 4.0,
                  spreadRadius: 2.0,
                ),
              ],
              borderRadius: BorderRadius.only(
                bottomLeft:
                    Radius.circular(DefaultSizes.appheadercircularborder),
                bottomRight:
                    Radius.circular(DefaultSizes.appheadercircularborder),
              ),
              color: AppColors.primary,
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: SizeUtil.getStatusBarHeight(context),
                    right: 20,
                    bottom: DefaultSizes.bottemspaceofheader,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        padding: const EdgeInsets.all(0),
                        color: AppColors.white,
                        iconSize: SizeUtil.iconsSize(context),
                        icon: const Icon(Icons.notifications_outlined),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Notifications()),
                          );
                        },
                      ),
                      IconButton(
                        padding: const EdgeInsets.all(0),
                        color: AppColors.white,
                        icon: const Icon(Icons.account_circle),
                        iconSize: SizeUtil.iconsSize(context),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ProfileAndSettings()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: SizeUtil.verticalSpacingMedium(context),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: Form(
                key: addOtherAssetsFormKey,
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          textScaleFactor:
                              MediaQuery.of(context).textScaleFactor,
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Asset',
                                style: TextStyle(
                                    fontSize: SizeUtil.body(context),
                                    color: AppColors.grey,
                                    fontFamily: "Helvetica"),
                              ),
                              TextSpan(
                                  text: "*",
                                  style: TextStyle(
                                      fontSize: SizeUtil.body(context),
                                      color: AppColors.red,
                                      fontFamily: "Helvetica")),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 40.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: TextFormField(
                              readOnly: widget.isWatch,
                              autofocus: true,
                              controller: assetController,
                              focusNode: assetFocusNode,
                              onEditingComplete: () {
                                FocusScope.of(context)
                                    .requestFocus(purchasePriceNode);
                              },
                              decoration: InputDecoration(
                                filled: true,
                                isDense: true,
                                border: InputBorder.none,
                                hintText: 'e.g., House',
                                hintStyle: TextStyle(
                                    color: AppColors.grey,
                                    fontFamily: "Helvetica",
                                    fontSize: SizeUtil.body(context)),
                                fillColor: TextfieldColors.background,
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[a-z A-Z]'))
                              ],
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'asset is required';
                                } 
                                return null;
                              },
                              style:
                                  TextStyle(fontSize: SizeUtil.body(context)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeUtil.verticalSpacingMedium(context),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          textScaleFactor:
                              MediaQuery.of(context).textScaleFactor,
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Purchase Price',
                                style: TextStyle(
                                    fontSize: SizeUtil.body(context),
                                    color: AppColors.grey,
                                    fontFamily: "Helvetica"),
                              ),
                              TextSpan(
                                  text: "*",
                                  style: TextStyle(
                                      fontSize: SizeUtil.body(context),
                                      color: AppColors.red,
                                      fontFamily: "Helvetica")),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 40.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: TextFormField(
                              readOnly: widget.isWatch,
                              controller: purchasePriceController,
                              focusNode: purchasePriceNode,
                              onEditingComplete: () {
                                FocusScope.of(context)
                                    .requestFocus(currentValueNode);
                              },
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: true, decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10)
                              ],
                              decoration: InputDecoration(
                                filled: true,
                                isDense: true,
                                border: InputBorder.none,
                                hintText: 'e.g., 1000000',
                                hintStyle: TextStyle(
                                    color: AppColors.grey,
                                    fontFamily: "Helvetica",
                                    fontSize: SizeUtil.body(context)),
                                fillColor: TextfieldColors.background,
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'purchase price is required';
                                } else {
                                  if (int.parse(value.toString()) == 0) {
                                    return 'please enter valid purchase price';
                                  }
                                }
                                return null;
                              },
                              style:
                                  TextStyle(fontSize: SizeUtil.body(context)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeUtil.verticalSpacingMedium(context),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          textScaleFactor:
                              MediaQuery.of(context).textScaleFactor,
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Current Value',
                                style: TextStyle(
                                    fontSize: SizeUtil.body(context),
                                    color: AppColors.grey,
                                    fontFamily: "Helvetica"),
                              ),
                              TextSpan(
                                  text: "*",
                                  style: TextStyle(
                                      fontSize: SizeUtil.body(context),
                                      color: AppColors.red,
                                      fontFamily: "Helvetica")),
                            ],
                          ),
                        ),
                        const SizedBox(height: 2),
                        Padding(
                          padding: const EdgeInsets.only(right: 40),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: TextFormField(
                              readOnly: widget.isWatch,
                              controller: currentValueController,
                              focusNode: currentValueNode,
                              onEditingComplete: () {
                                FocusScope.of(context)
                                    .requestFocus(purchaseDateNode);
                              },
                              decoration: InputDecoration(
                                filled: true,
                                isDense: true,
                                border: InputBorder.none,
                                hintText: 'e.g., 14000000',
                                hintStyle: TextStyle(
                                    color: AppColors.grey,
                                    fontFamily: "Helvetica",
                                    fontSize: SizeUtil.body(context)),
                                fillColor: TextfieldColors.background,
                              ),
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: true, decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10)
                              ],
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'current value is required';
                                } else {
                                  if (int.parse(value.toString()) == 0) {
                                    return 'please enter valid current value';
                                  }
                                }
                                return null;
                              },
                              style:
                                  TextStyle(fontSize: SizeUtil.body(context)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeUtil.verticalSpacingMedium(context),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          textScaleFactor:
                              MediaQuery.of(context).textScaleFactor,
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Purchase Date',
                                style: TextStyle(
                                    fontSize: SizeUtil.body(context),
                                    color: AppColors.grey,
                                    fontFamily: "Helvetica"),
                              ),
                              TextSpan(
                                  text: "*",
                                  style: TextStyle(
                                      fontSize: SizeUtil.body(context),
                                      color: AppColors.red,
                                      fontFamily: "Helvetica")),
                            ],
                          ),
                        ),
                        const SizedBox(height: 2),
                        Padding(
                          padding: const EdgeInsets.only(right: 40),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              readOnly: true,
                              keyboardType: TextInputType.datetime,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10)
                              ],
                              decoration: InputDecoration(
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: GestureDetector(
                                    onTap: () => widget.isWatch
                                        ? () {}
                                        : _selectPurchaseDate(context),
                                    child: Icon(Icons.calendar_month,
                                        size: SizeUtil.iconsSize(context),
                                        color: AppColors.primary),
                                  ),
                                ),
                                suffixIconConstraints: const BoxConstraints(),
                                filled: true,
                                isDense: true,
                                border: InputBorder.none,
                                hintText: 'e.g., 01/01/2021',
                                hintStyle: TextStyle(
                                    color: AppColors.grey,
                                    fontFamily: "Helvetica",
                                    fontSize: SizeUtil.body(context)),
                                fillColor: TextfieldColors.background,
                              ),
                              style:
                                  TextStyle(fontSize: SizeUtil.body(context)),
                              controller: purchaseDateController,
                              focusNode: purchaseDateNode,
                              onEditingComplete: () {
                                purchaseDateNode.unfocus();
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'purchase date is required';
                                } else {
                                  return null;
                                }
                              },
                              onTap: () => widget.isWatch
                                  ? () {}
                                  : _selectPurchaseDate(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SmallButton(
                  text: widget.isWatch ? "Back" : "Cancel",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  backgroundColor: AppColors.white,
                  textColor: AppColors.primary),
              if (!widget.isWatch)
                SmallButton(
                    text: "Confirm",
                    onPressed: () {
                      if (addOtherAssetsFormKey.currentState!.validate()) {
                        if(widget.isEdit){
                          updateOtherAsset();
                        }else{
                          addOtherAsset(); 
                        }
                      }
                    },
                    backgroundColor: AppColors.primary,
                    textColor: AppColors.white),
            ],
          ),
        ],
      ),
    );
  }

  addOtherAsset() async {
    bool isSuccess = await otherAssetsController.addOtherAssets(
        assetController.text.toString(),
        double.parse(currentValueController.text.toString()),
        double.parse(purchasePriceController.text.toString()),
        purchaseDateController.text.toString(),
        context);

    if (isSuccess) {
      Navigator.maybePop(
              context,
              MaterialPageRoute(
                  builder: (context) => const OtherAssetsScreen()))
          .then((value) => otherAssetsController.getOtherAssetsList(context));
    } else {}
  }

  updateOtherAsset() async {
    bool isSuccess = await otherAssetsController.updateOtherAsset(
        widget.otherAssetId,
        assetController.text,
        double.parse(purchasePriceController.text.toString()),
        double.parse(currentValueController.text.toString()),
        purchaseDateController.text,
        context);
    if (isSuccess) {
      Navigator.maybePop(
              context,
              MaterialPageRoute(
                  builder: (context) => const OtherAssetsScreen()))
          .then((value) => otherAssetsController.getOtherAssetsList(context));
    } else {}
  }
}
