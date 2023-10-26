import 'package:get/get.dart';
import 'package:midas/Widgets/buttons/small_button.dart';
import 'package:midas/constant/colors.dart';
import 'package:midas/constant/sizeConstant.dart';
import 'package:midas/constant/size_util.dart';
import 'package:midas/controller/gold_types/gold_types_controller.dart';
import 'package:midas/controller/investment/gold/gold_controller.dart';
import 'package:midas/screen/notifications/notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../profile/profile_and_setting.dart';
import 'gold_item_details.dart';

class AddGoldItem extends StatefulWidget {
  // final bool isEdit;
  // final bool isWatch;
  // final String goldId;
  // final String shortTitle;
  // final String weight;
  final String goldPurity;
  // final String description;
  const AddGoldItem({
    super.key,
    // required this.isEdit,
    // required this.isWatch,
    // required this.goldId,
    // required this.shortTitle,
    // required this.weight,
    required this.goldPurity,
    // required this.description,
  });

  @override
  State<AddGoldItem> createState() => _AddGoldItemState();
}

class _AddGoldItemState extends State<AddGoldItem> {
  final FocusNode shortTitleFocusNode = FocusNode();
  final FocusNode weightFocusNode = FocusNode();
  final FocusNode goldPurityFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();
  // Set<String> _selectedData = Set();
  TextEditingController shortTitleController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController goldPurityController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<String> goldTypeList = [];
  // bool _selectAllData = false;
  bool _showDataDropdown = false;
  GlobalKey<FormState> addGoldItemFormKey = GlobalKey<FormState>();
  void _toggleDataDropDown() async {
    if (goldTypeList.isEmpty) {
      List<String> goldTypes =
          await goldTypesController.getGoldTypesList(context);
      setState(() {
        goldTypeList = goldTypes;
      });
    }
    setState(() {
      _showDataDropdown = !_showDataDropdown;
    });
  }

  GoldController goldController = Get.put(GoldController());
  GoldTypesController goldTypesController = Get.put(GoldTypesController());

  @override
  void initState() {
    super.initState();
    // if (widget.isEdit || widget.isWatch) {
    //   shortTitleController.text = widget.shortTitle;
    //   weightController.text = widget.weight;
      // goldPurityController.text = widget.goldPurity;
    //   descriptionController.text = widget.description;
    // }
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
                key: addGoldItemFormKey,
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
                                text: 'Short Title',
                                style: TextStyle(
                                    fontSize: SizeUtil.body(context),
                                    color: AppColors.grey),
                              ),
                              TextSpan(
                                  text: "*",
                                  style: TextStyle(
                                      fontSize: SizeUtil.body(context),
                                      color: AppColors.red)),
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
                              // readOnly: widget.isWatch,
                              autofocus: true,
                              controller: shortTitleController,
                              focusNode: shortTitleFocusNode,
                              onEditingComplete: () {
                                FocusScope.of(context)
                                    .requestFocus(weightFocusNode);
                              },
                              decoration: InputDecoration(
                                filled: true,
                                isDense: true,
                                border: InputBorder.none,
                                hintText: 'e.g. Gold coin',
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
                                  return 'short title is required';
                                }
                                return null;
                              },
                              style: TextStyle(
                                  fontSize: SizeUtil.body(context),
                                  fontFamily: "Helvetica"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
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
                                text: 'Weight (in gms)',
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
                              // readOnly: widget.isWatch,
                              controller: weightController,
                              focusNode: weightFocusNode,
                              onEditingComplete: () {
                                FocusScope.of(context)
                                    .requestFocus(goldPurityFocusNode);
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
                                hintText: 'e.g., 5,10,20',
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
                                  return 'weight is required';
                                } else if (int.parse(value.toString()) == 0) {
                                  return 'please enter valid weight';
                                }
                                return null;
                              },
                              style: TextStyle(
                                  fontSize: SizeUtil.body(context),
                                  fontFamily: "Helvetica"),
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
                                text: 'Gold Purity',
                                style: TextStyle(
                                  fontSize: SizeUtil.body(context),
                                  color: AppColors.grey,
                                  fontFamily: "Helvetica",
                                ),
                              ),
                              TextSpan(
                                text: "*",
                                style: TextStyle(
                                  fontSize: SizeUtil.body(context),
                                  color: AppColors.red,
                                  fontFamily: "Helvetica",
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 2),
                        Padding(
                          padding: const EdgeInsets.only(right: 40),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: TextFormField(
                              onEditingComplete: () {
                                FocusScope.of(context)
                                    .requestFocus(descriptionFocusNode);
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.arrow_drop_down,
                                  size: SizeUtil.iconsSize(context),
                                  color: AppColors.primary,
                                ),
                                suffixIconConstraints: const BoxConstraints(),
                                filled: true,
                                isDense: true,
                                border: InputBorder.none,
                                hintText: 'e.g., 18k, 22k, 24k',
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: "Helvetica",
                                    fontSize: SizeUtil.body(context)),
                                fillColor: TextfieldColors.background,
                              ),
                              readOnly: true,
                              onTap: 
                                  // widget.isWatch ? () {} : 
                                  _toggleDataDropDown,
                              style: TextStyle(
                                  fontSize: SizeUtil.body(context),
                                  fontFamily: "Helvetica"),
                              controller: goldPurityController,
                              focusNode: goldPurityFocusNode,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'gold purity is required';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                        if (_showDataDropdown)
                          Material(
                            color: Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 40),
                              child: Card(
                                color: AppColors.white,
                                elevation: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (goldTypeList.isEmpty)
                                      ListTile(
                                        title: Text(
                                          'No Records Found',
                                          style: TextStyle(
                                              fontSize: SizeUtil.body(context),
                                              fontFamily: "Helvetica"),
                                        ),
                                        enabled: false,
                                      ),
                                    if (goldTypeList.isNotEmpty)
                                      ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        itemCount: goldTypeList.length,
                                        itemBuilder: (context, index) {
                                          final option = goldTypeList[index];
                                          return ListTile(
                                            dense: true,
                                            title: Text(option,
                                                style: TextStyle(
                                                    fontFamily: "Helvetica",
                                                    fontSize: SizeUtil.body(
                                                        context))),
                                            onTap: () {
                                              setState(() {
                                                goldPurityController.text =
                                                    option;
                                                _showDataDropdown = false;
                                              });
                                            },
                                          );
                                        },
                                      ),
                                  ],
                                ),
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
                                text: 'Description of the item',
                                style: TextStyle(
                                    fontSize: SizeUtil.body(context),
                                    color: AppColors.grey,
                                    fontFamily: "Helvetica"),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 2),
                        Padding(
                          padding: const EdgeInsets.only(right: 40),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: TextFormField(
                              // readOnly: widget.isWatch,
                              controller: descriptionController,
                              focusNode: descriptionFocusNode,
                              onEditingComplete: () {
                                descriptionFocusNode.unfocus();
                              },
                              maxLines: 3,
                              decoration: InputDecoration(
                                filled: true,
                                isDense: true,
                                border: InputBorder.none,
                                hintText: 'e.g., Necklace with Beads',
                                hintStyle: TextStyle(
                                    color: AppColors.grey,
                                    fontFamily: "Helvetica",
                                    fontSize: SizeUtil.body(context)),
                                fillColor: TextfieldColors.background,
                              ),
                              style:
                                  TextStyle(fontSize: SizeUtil.body(context)),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              textInputAction: TextInputAction
                                  .newline, // Add this line to enable newline key on the keyboard
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
                  text:
                   "Cancel",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  backgroundColor: AppColors.white,
                  textColor: AppColors.primary),
              // if (!widget.isWatch)
                SmallButton(
                    text: "Confirm",
                    onPressed: () {
                      if (addGoldItemFormKey.currentState!.validate()) {
                          addGoldItems();
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

  addGoldItems() async {
    bool isSuccess = await goldController.addNewGold(
        shortTitleController.text.toString(),
        double.parse(weightController.text.toString()),
        goldPurityController.text.toString(),
        descriptionController.text.toString(),
        context);

    if (isSuccess) {
      // ignore: use_build_context_synchronously
      Navigator.maybePop(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  GoldItemDetails(goldPurity: widget.goldPurity))).then(
          (value) =>
              goldController.getGoldItemsList(widget.goldPurity, context));
    } else {}
  }

  // updateGoldItems() async {
  //   bool isSuccess = await goldController.updateGoldItems(
  //       widget.goldId,
  //       shortTitleController.text.toString(),
  //       double.parse(weightController.text.toString()),
  //       goldPurityController.text.toString(),
  //       descriptionController.text.toString(),
  //       context);

  //   if (isSuccess) {
  //     // ignore: use_build_context_synchronously
  //     Navigator.maybePop(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) =>
  //                 GoldItemDetails(goldPurity: widget.goldPurity))).then(
  //         (value) =>
  //             goldController.getGoldItemsList(widget.goldPurity, context));
  //   } else {}
  // }
}
