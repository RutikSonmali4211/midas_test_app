import 'package:get/get.dart';
import 'package:midas/controller/user/user_controller.dart';
import 'package:midas/Widgets/buttons/large_button.dart';
import 'package:midas/constant/colors.dart';
import 'package:midas/constant/convertors.dart';
import 'package:midas/constant/size_util.dart';
import 'package:flutter/material.dart';
import 'package:midas/widgets/appbar/small_appbar.dart';

import '../profile_and_setting.dart';

class InvestmentProfileScreen extends StatefulWidget {
  const InvestmentProfileScreen({super.key});

  @override
  State<InvestmentProfileScreen> createState() =>
      _InvestmentProfileScreenState();
}

class _InvestmentProfileScreenState extends State<InvestmentProfileScreen> {
  var height;
  var width;

  List<String> riskTolerenceList = ["Moderate"];
  List<String> investingFrequencyList = ["Once a month"];
  List<String> investingExperienceList = ["3 to 5 years"];
  List<String> yearlyIncomeList = ["50+ lakh rupees"];
  bool _showriskTolerenceDropdown = false;
  bool _showinvestingFrequencyDropdown = false;
  bool _showinvestingExperienceDropdown = false;
  bool _showyearlyIncomeDropdown = false;
  final Set<String> _selectedriskTolerence = {};
  final Set<String> _selectedinvestingFrequency = {};
  final Set<String> _selectedinvestingExperience = {};
  final Set<String> _selectedyearlyIncome = {};
  bool _selectAllriskTolerence = false;
  bool _selectAllinvestingFrequency = false;
  bool _selectAllinvestingExperience = false;
  bool _selectAllyearlyIncome = false;

  TextEditingController riskTolerenceController = TextEditingController();
  TextEditingController investingFrequencyController = TextEditingController();
  TextEditingController investingExperienceController = TextEditingController();
  TextEditingController yearlyIncomeController = TextEditingController();
  UserController userController = Get.put(UserController());
  GlobalKey<FormState> investmentProfileFormKey = GlobalKey<FormState>();

  saveInvestorProfile() async {
    List<Map<String, dynamic>> ListData = [];

    ListData.add(Convertors.createListForInvestmentDropdownData(
        "Risk Tolerence", riskTolerenceController.text.toString()));
    ListData.add(Convertors.createListForInvestmentDropdownData(
        "Investing Frequency", investingFrequencyController.text.toString()));
    ListData.add(Convertors.createListForInvestmentDropdownData(
        "Investing Experience", investingExperienceController.text.toString()));
    ListData.add(Convertors.createListForInvestmentDropdownData(
        "Investing Experience", yearlyIncomeController.text.toString()));

    bool isSuccess =
        await userController.saveInvestmentProfile(ListData, context);
    if (isSuccess) {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfileAndSettings()),
      );
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return GestureDetector(
      onTap: () {
        setState(() {
          _showriskTolerenceDropdown = false;
          _showinvestingFrequencyDropdown = false;
          _showinvestingExperienceDropdown = false;
          _showyearlyIncomeDropdown = false;
        });
      },
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SmallAppbar(heading: "Investment Profile"),
            SizedBox(height: SizeUtil.verticalSpacingMedium(context)),
            Form(
              key: investmentProfileFormKey,
              child: Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                  child: SingleChildScrollView(
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
                                    text: 'Risk Tolerence',
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
                                  decoration: InputDecoration(
                                    suffixIcon: Icon(Icons.arrow_drop_down,
                                        size: SizeUtil.iconsSize(context),
                                        color: AppColors.primary),
                                    suffixIconConstraints:
                                        const BoxConstraints(),
                                    filled: true,
                                    isDense: true,
                                    border: InputBorder.none,
                                    hintText: 'Moderate',
                                    hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: SizeUtil.body(context),
                                        fontFamily: "Helvetica"),
                                    fillColor: TextfieldColors.background,
                                  ),
                                  readOnly: true,
                                  onTap: _toggleRiskTolerence,
                                  style: TextStyle(
                                      fontSize: SizeUtil.body(context),
                                      fontFamily: "Helvetica"),
                                  controller: riskTolerenceController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'risk tolerence is required';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                            if (_showriskTolerenceDropdown)
                              Material(
                                color: Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 40),
                                  child: Card(
                                    elevation: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (riskTolerenceList.isEmpty)
                                          ListTile(
                                            title: Text(
                                              'No Records Found',
                                              style: TextStyle(
                                                  fontSize:
                                                      SizeUtil.body(context),
                                                  fontFamily: "Helvetica"),
                                            ),
                                            enabled: false,
                                          ),
                                        if (riskTolerenceList.isNotEmpty)
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _selectAllriskTolerence =
                                                        !_selectAllriskTolerence;
                                                    _showriskTolerenceDropdown =
                                                        !_showriskTolerenceDropdown;
                                                    if (_selectAllriskTolerence) {
                                                      _selectedriskTolerence
                                                          .addAll(
                                                              riskTolerenceList);
                                                      riskTolerenceController
                                                              .text =
                                                          _selectedriskTolerence
                                                              .join(', ');
                                                    } else {
                                                      _selectedriskTolerence
                                                          .clear();
                                                      riskTolerenceController
                                                          .clear();
                                                    }
                                                  });
                                                },
                                                child: Text(
                                                  _selectAllriskTolerence
                                                      ? 'Deselect All'
                                                      : 'Select All',
                                                  style: TextStyle(
                                                      color: AppColors.primary,
                                                      fontSize: SizeUtil.body(
                                                          context),
                                                      fontFamily: "Helvetica"),
                                                ),
                                              ),
                                              if (_selectedriskTolerence
                                                  .isNotEmpty)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 15.0),
                                                  child: Text(
                                                    '${_selectedriskTolerence.length} selected',
                                                    style: TextStyle(
                                                      fontSize:
                                                          SizeUtil.bodySmall(
                                                              context),
                                                      color: Colors.grey,
                                                      fontFamily: "Helvetica",
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ListView.builder(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          itemCount: riskTolerenceList.length,
                                          itemBuilder: (context, index) {
                                            final option =
                                                riskTolerenceList[index];
                                            return CheckboxListTile(
                                              dense: true,
                                              activeColor: AppColors.primary,
                                              title: Text(
                                                option,
                                                style: TextStyle(
                                                    fontSize:
                                                        SizeUtil.body(context),
                                                    fontFamily: "Helvetica"),
                                              ),
                                              value: _selectedriskTolerence
                                                  .contains(option),
                                              onChanged: (selected) {
                                                setState(() {
                                                  if (selected!) {
                                                    _selectedriskTolerence
                                                        .add(option);
                                                    riskTolerenceController
                                                            .text =
                                                        _selectedriskTolerence
                                                            .join(', ');
                                                  } else {
                                                    _selectedriskTolerence
                                                        .remove(option);
                                                    riskTolerenceController
                                                            .text =
                                                        _selectedriskTolerence
                                                            .join(', ');
                                                  }
                                                  _selectAllriskTolerence =
                                                      _selectedriskTolerence
                                                              .length ==
                                                          riskTolerenceList
                                                              .length;
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
                                    text: 'Investing Frequency',
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
                                  decoration: InputDecoration(
                                    suffixIcon: Icon(Icons.arrow_drop_down,
                                        size: SizeUtil.iconsSize(context),
                                        color: AppColors.primary),
                                    suffixIconConstraints:
                                        const BoxConstraints(),
                                    filled: true,
                                    isDense: true,
                                    border: InputBorder.none,
                                    hintText: 'Once a month',
                                    hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: SizeUtil.body(context),
                                        fontFamily: "Helvetica"),
                                    fillColor: TextfieldColors.background,
                                  ),
                                  readOnly: true,
                                  onTap: _toggleInvestingFrequency,
                                  style: TextStyle(
                                      fontSize: SizeUtil.body(context),
                                      fontFamily: "Helvetica"),
                                  controller: investingFrequencyController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'investing frequency is required';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                            if (_showinvestingFrequencyDropdown)
                              Material(
                                color: Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 40),
                                  child: Card(
                                    elevation: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (investingFrequencyList.isEmpty)
                                          ListTile(
                                            title: Text(
                                              'No Records Found',
                                              style: TextStyle(
                                                  fontSize:
                                                      SizeUtil.body(context),
                                                  fontFamily: "Helvetica"),
                                            ),
                                            enabled: false,
                                          ),
                                        if (investingFrequencyList.isNotEmpty)
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _selectAllinvestingFrequency =
                                                        !_selectAllinvestingFrequency;
                                                    _showinvestingFrequencyDropdown =
                                                        !_showinvestingFrequencyDropdown;
                                                    if (_selectAllinvestingFrequency) {
                                                      _selectedinvestingFrequency
                                                          .addAll(
                                                              investingFrequencyList);
                                                      investingFrequencyController
                                                              .text =
                                                          _selectedinvestingFrequency
                                                              .join(', ');
                                                    } else {
                                                      _selectedinvestingFrequency
                                                          .clear();
                                                      investingFrequencyController
                                                          .clear();
                                                    }
                                                  });
                                                },
                                                child: Text(
                                                  _selectAllinvestingFrequency
                                                      ? 'Deselect All'
                                                      : 'Select All',
                                                  style: TextStyle(
                                                      color: AppColors.primary,
                                                      fontSize: SizeUtil.body(
                                                          context),
                                                      fontFamily: "Helvetica"),
                                                ),
                                              ),
                                              if (_selectedinvestingFrequency
                                                      .length >
                                                  0)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 15.0),
                                                  child: Text(
                                                    '${_selectedinvestingFrequency.length} selected',
                                                    style: TextStyle(
                                                        fontSize:
                                                            SizeUtil.bodySmall(
                                                                context),
                                                        color: Colors.grey,
                                                        fontFamily:
                                                            "Helvetica"),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ListView.builder(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          itemCount:
                                              investingFrequencyList.length,
                                          itemBuilder: (context, index) {
                                            final option =
                                                investingFrequencyList[index];
                                            return CheckboxListTile(
                                              dense: true,
                                              activeColor: AppColors.primary,
                                              title: Text(
                                                option,
                                                style: TextStyle(
                                                    fontSize:
                                                        SizeUtil.body(context),
                                                    fontFamily: "Helvetica"),
                                              ),
                                              value: _selectedinvestingFrequency
                                                  .contains(option),
                                              onChanged: (selected) {
                                                setState(() {
                                                  if (selected!) {
                                                    _selectedinvestingFrequency
                                                        .add(option);
                                                    investingFrequencyController
                                                            .text =
                                                        _selectedinvestingFrequency
                                                            .join(', ');
                                                  } else {
                                                    _selectedinvestingFrequency
                                                        .remove(option);
                                                    investingFrequencyController
                                                            .text =
                                                        _selectedinvestingFrequency
                                                            .join(', ');
                                                  }
                                                  _selectAllinvestingFrequency =
                                                      _selectedinvestingFrequency
                                                              .length ==
                                                          investingFrequencyList
                                                              .length;
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
                            height: SizeUtil.verticalSpacingMedium(context)),
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
                                    text: 'Investing Experience',
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
                                  decoration: InputDecoration(
                                    suffixIcon: Icon(Icons.arrow_drop_down,
                                        size: SizeUtil.iconsSize(context),
                                        color: AppColors.primary),
                                    suffixIconConstraints:
                                        const BoxConstraints(),
                                    filled: true,
                                    isDense: true,
                                    border: InputBorder.none,
                                    hintText: '3 to 5 years',
                                    hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: SizeUtil.body(context),
                                        fontFamily: "Helvetica"),
                                    fillColor: TextfieldColors.background,
                                  ),
                                  readOnly: true,
                                  onTap: _toggleInvestingExperience,
                                  style: TextStyle(
                                    fontSize: SizeUtil.body(context),
                                  ),
                                  controller: investingExperienceController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'investing experience is required';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                            if (_showinvestingExperienceDropdown)
                              Material(
                                color: Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 40),
                                  child: Card(
                                    elevation: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (investingExperienceList.isEmpty)
                                          ListTile(
                                            title: Text(
                                              'No Records Found',
                                              style: TextStyle(
                                                  fontSize:
                                                      SizeUtil.body(context),
                                                  fontFamily: "Helvetica"),
                                            ),
                                            enabled: false,
                                          ),
                                        if (investingExperienceList.isNotEmpty)
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _selectAllinvestingExperience =
                                                        !_selectAllinvestingExperience;
                                                    _showinvestingExperienceDropdown =
                                                        !_showinvestingExperienceDropdown;
                                                    if (_selectAllinvestingExperience) {
                                                      _selectedinvestingExperience
                                                          .addAll(
                                                              investingExperienceList);
                                                      investingExperienceController
                                                              .text =
                                                          _selectedinvestingExperience
                                                              .join(', ');
                                                    } else {
                                                      _selectedinvestingExperience
                                                          .clear();
                                                      investingExperienceController
                                                          .clear();
                                                    }
                                                  });
                                                },
                                                child: Text(
                                                  _selectAllinvestingExperience
                                                      ? 'Deselect All'
                                                      : 'Select All',
                                                  style: TextStyle(
                                                      color: AppColors.primary,
                                                      fontSize: SizeUtil.body(
                                                          context),
                                                      fontFamily: "Helvetica"),
                                                ),
                                              ),
                                              if (_selectedinvestingExperience
                                                      .length >
                                                  0)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 15.0),
                                                  child: Text(
                                                    '${_selectedinvestingExperience.length} selected',
                                                    style: TextStyle(
                                                        fontSize:
                                                            SizeUtil.bodySmall(
                                                                context),
                                                        color: Colors.grey,
                                                        fontFamily:
                                                            "Helvetica"),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ListView.builder(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          itemCount:
                                              investingExperienceList.length,
                                          itemBuilder: (context, index) {
                                            final option =
                                                investingExperienceList[index];
                                            return CheckboxListTile(
                                              dense: true,
                                              activeColor: AppColors.primary,
                                              title: Text(
                                                option,
                                                style: TextStyle(
                                                    fontSize:
                                                        SizeUtil.body(context),
                                                    fontFamily: "Helvetica"),
                                              ),
                                              value:
                                                  _selectedinvestingExperience
                                                      .contains(option),
                                              onChanged: (selected) {
                                                setState(() {
                                                  if (selected!) {
                                                    _selectedinvestingExperience
                                                        .add(option);
                                                    investingExperienceController
                                                            .text =
                                                        _selectedinvestingExperience
                                                            .join(', ');
                                                  } else {
                                                    _selectedinvestingExperience
                                                        .remove(option);
                                                    investingExperienceController
                                                            .text =
                                                        _selectedinvestingExperience
                                                            .join(', ');
                                                  }
                                                  _selectAllinvestingExperience =
                                                      _selectedinvestingExperience
                                                              .length ==
                                                          investingExperienceList
                                                              .length;
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
                                    text: 'Yearly Income',
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
                                  decoration: InputDecoration(
                                    suffixIcon: Icon(Icons.arrow_drop_down,
                                        size: SizeUtil.iconsSize(context),
                                        color: AppColors.primary),
                                    suffixIconConstraints:
                                        const BoxConstraints(),
                                    filled: true,
                                    isDense: true,
                                    border: InputBorder.none,
                                    hintText: '50+ Lakh rupees',
                                    hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: SizeUtil.body(context),
                                        fontFamily: "Helvetica"),
                                    fillColor: TextfieldColors.background,
                                  ),
                                  readOnly: true,
                                  onTap: _toggleYearlyIncome,
                                  style: TextStyle(
                                      fontSize: SizeUtil.body(context)),
                                  controller: yearlyIncomeController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'yearly income is required';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                            if (_showyearlyIncomeDropdown)
                              Material(
                                color: Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 40),
                                  child: Card(
                                    elevation: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (yearlyIncomeList.isEmpty)
                                          ListTile(
                                            title: Text(
                                              'No Records Found',
                                              style: TextStyle(
                                                  fontSize:
                                                      SizeUtil.body(context),
                                                  fontFamily: "Helvetica"),
                                            ),
                                            enabled: false,
                                          ),
                                        if (yearlyIncomeList.isNotEmpty)
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _selectAllyearlyIncome =
                                                        !_selectAllyearlyIncome;
                                                    _showyearlyIncomeDropdown =
                                                        !_showyearlyIncomeDropdown;
                                                    if (_selectAllyearlyIncome) {
                                                      _selectedyearlyIncome
                                                          .addAll(
                                                              yearlyIncomeList);
                                                      yearlyIncomeController
                                                              .text =
                                                          _selectedyearlyIncome
                                                              .join(', ');
                                                    } else {
                                                      _selectedyearlyIncome
                                                          .clear();
                                                      yearlyIncomeController
                                                          .clear();
                                                    }
                                                  });
                                                },
                                                child: Text(
                                                  _selectAllyearlyIncome
                                                      ? 'Deselect All'
                                                      : 'Select All',
                                                  style: TextStyle(
                                                      fontSize: SizeUtil.body(
                                                          context),
                                                      color: AppColors.primary,
                                                      fontFamily: "Helvetica"),
                                                ),
                                              ),
                                              if (_selectedyearlyIncome.length >
                                                  0)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 15.0),
                                                  child: Text(
                                                    '${_selectedyearlyIncome.length} selected',
                                                    style: TextStyle(
                                                        fontSize:
                                                            SizeUtil.bodySmall(
                                                                context),
                                                        color: Colors.grey,
                                                        fontFamily:
                                                            "Helvetica"),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ListView.builder(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          itemCount: yearlyIncomeList.length,
                                          itemBuilder: (context, index) {
                                            final option =
                                                yearlyIncomeList[index];
                                            return CheckboxListTile(
                                              dense: true,
                                              activeColor: AppColors.primary,
                                              title: Text(
                                                option,
                                                style: TextStyle(
                                                    fontSize:
                                                        SizeUtil.body(context),
                                                    fontFamily: "Helvetica"),
                                              ),
                                              value: _selectedyearlyIncome
                                                  .contains(option),
                                              onChanged: (selected) {
                                                setState(() {
                                                  if (selected!) {
                                                    _selectedyearlyIncome
                                                        .add(option);
                                                    yearlyIncomeController
                                                            .text =
                                                        _selectedyearlyIncome
                                                            .join(', ');
                                                  } else {
                                                    _selectedyearlyIncome
                                                        .remove(option);
                                                    yearlyIncomeController
                                                            .text =
                                                        _selectedyearlyIncome
                                                            .join(', ');
                                                  }
                                                  _selectAllyearlyIncome =
                                                      _selectedyearlyIncome
                                                              .length ==
                                                          yearlyIncomeList
                                                              .length;
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
                        const SizedBox(
                          height: 60,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.06),
                          child: LargeButton(
                              text: "Save Profile",
                              backgroundColor: AppColors.primary,
                              textColor: AppColors.white,
                              onPressed: () {
                                saveInvestorProfile();
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _toggleRiskTolerence() {
    setState(() {
      _showriskTolerenceDropdown = !_showriskTolerenceDropdown;
    });
  }

  void _toggleInvestingFrequency() {
    setState(() {
      _showinvestingFrequencyDropdown = !_showinvestingFrequencyDropdown;
    });
  }

  void _toggleInvestingExperience() {
    setState(() {
      _showinvestingExperienceDropdown = !_showinvestingExperienceDropdown;
    });
  }

  void _toggleYearlyIncome() {
    setState(() {
      _showyearlyIncomeDropdown = !_showyearlyIncomeDropdown;
    });
  }
}
