import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:midas/constant/colors.dart';
import 'package:midas/constant/constant_util.dart';
import 'package:midas/constant/size_util.dart';
import 'package:midas/widgets/alert_message/warning_message.dart';
import 'package:midas/widgets/appbar/small_appbar.dart';
import 'package:midas/widgets/buttons/icon_button.dart';
import 'package:midas/widgets/buttons/small_button.dart';
import 'package:midas/widgets/upper_case_formatter.dart';

class KYCRequestForm extends StatefulWidget {
  const KYCRequestForm({super.key});

  @override
  State<KYCRequestForm> createState() => _KYCRequestFormState();
}

class _KYCRequestFormState extends State<KYCRequestForm> {
  var height;
  var width;
  int currentStep = 1;
  int stepLength = 2;
  bool complete = false;

  List<GlobalKey<FormState>> formKeys =
      List.generate(3, (_) => GlobalKey<FormState>());

  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController panController = TextEditingController();
  TextEditingController aadhaarController = TextEditingController();
  TextEditingController dateofBirthController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController motherNameController = TextEditingController();
  TextEditingController countryOfBirthController = TextEditingController();
  TextEditingController maritalStatusController = TextEditingController();
  TextEditingController occupationTypeController = TextEditingController();

  // controllers to documents to uplaod
  TextEditingController addressProofDocumentController =
      TextEditingController();
  TextEditingController panCardDocumentController = TextEditingController();
  TextEditingController signatureScanDocumentController =
      TextEditingController();
  TextEditingController photoDocumentController = TextEditingController();
  TextEditingController bankAccountDocumentController = TextEditingController();
  TextEditingController videoVerificationDocumentController =
      TextEditingController();

  final FocusNode fullNameFocusNode = FocusNode();
  final FocusNode phoneNoFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode panFocusNode = FocusNode();
  final FocusNode aadhaarFocusNode = FocusNode();
  final FocusNode dateofBirthFocusNode = FocusNode();
  final FocusNode genderFocusNode = FocusNode();
  final FocusNode fathernameFocusNode = FocusNode();
  final FocusNode motherNameFocusNode = FocusNode();
  final FocusNode countryOfBirthFocusNode = FocusNode();
  final FocusNode maritalStatusFocusNode = FocusNode();
  final FocusNode occupationTypeFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    fullNameController.dispose();
    phoneNoController.dispose();
    emailController.dispose();
    panController.dispose();
    aadhaarController.dispose();
    dateofBirthController.dispose();
    genderController.dispose();
    countryOfBirthController.dispose();
    maritalStatusController.dispose();
    occupationTypeController.dispose();
    addressProofDocumentController.dispose();
    panCardDocumentController.dispose();
    signatureScanDocumentController.dispose();
    photoDocumentController.dispose();
    bankAccountDocumentController.dispose();
    fullNameFocusNode.dispose();
    phoneNoFocusNode.dispose();
    emailFocusNode.dispose();
    panFocusNode.dispose();
    aadhaarFocusNode.dispose();
    dateofBirthFocusNode.dispose();
    genderFocusNode.dispose();
    countryOfBirthFocusNode.dispose();
    maritalStatusFocusNode.dispose();
    occupationTypeFocusNode.dispose();
  }

  XFile? addressProofDocument;
  XFile? panCardDocument;
  XFile? signatureScanDocument;
  XFile? photoDocument;
  XFile? bankAccountDocument;
  XFile? videoVerificationDocument;

  List<String> genderList = ["Male", "Female", "Others"];
  List<String> countryofBirthList = ["IN", "USA", "AUS", "NZ"];
  List<String> maritalStatusList = ["married", "unmarried"];

  List<String> occupationTypeList = [
    "business",
    "professional",
    "self_employed",
    "retired",
    "housewife",
    "student",
    "public_sector",
    "private_sector",
    "government_sector",
    "others"
  ];
  bool _showGenderDropdown = false;
  bool _showCountryOfBirthDropdown = false;
  bool _showMaritalStatusDropdown = false;
  bool _showOccupationTypeDropdown = false;

  void _toggleGenderDropdown() async {
    setState(() {
      _showGenderDropdown = !_showGenderDropdown;
    });
  }

  void _toggleCountryofBirthDropdown() async {
    setState(() {
      _showCountryOfBirthDropdown = !_showCountryOfBirthDropdown;
    });
  }

  void _toggleMaritalStatusDropdown() async {
    setState(() {
      _showMaritalStatusDropdown = !_showMaritalStatusDropdown;
    });
  }

  void _toggleOccupationTypeDropdown() async {
    setState(() {
      _showOccupationTypeDropdown = !_showOccupationTypeDropdown;
    });
  }

  // next() {
  //   if (currentStep <= 2) {
  //     setState(() => currentStep += 1);
  //   }
  // }

  next() {
    if (currentStep <= 2) {
      if (formKeys[currentStep - 1].currentState!.validate()) {
        setState(() => currentStep += 1);
      }
    } else if (currentStep == 3) {
      if (formKeys[currentStep - 1].currentState!.validate()) {}
    }
  }

  back() {
    if (currentStep == 1) {
      Navigator.pop(context);
    } else {
      setState(() => currentStep -= 1);
    }
  }

  Future<void> _selectDateOfBirth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        dateofBirthController.text =
            "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year.toString()}";
      });
    }
  }

  Widget kycForm1() {
    return SingleChildScrollView(
      child: Form(
        key: formKeys[0],
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Full Name (First & Last)',
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
                      maxLength: 40,
                      controller: fullNameController,
                      autofocus: true,
                      focusNode: fullNameFocusNode,
                      onEditingComplete: () {
                        phoneNoFocusNode.unfocus();
                        FocusScope.of(context).requestFocus(panFocusNode);
                      },
                      onFieldSubmitted: (_) {
                        phoneNoFocusNode.unfocus();
                      },
                      decoration: InputDecoration(
                        counterText: "",
                        filled: true,
                        isDense: true,
                        border: InputBorder.none,
                        hintText: 'e.g. John Doe',
                        hintStyle: TextStyle(
                            color: AppColors.grey,
                            fontFamily: "Helvetica",
                            fontSize: SizeUtil.body(context)),
                        fillColor: TextfieldColors.background,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[a-z A-Z]'))
                      ],
                      style: TextStyle(fontSize: SizeUtil.body(context)),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'full name is required';
                        } else {
                          if (value.length < 2) {
                            return 'please enter valid full name';
                          }
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: SizeUtil.verticalSpacingMedium(context)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'PAN',
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
                      focusNode: panFocusNode,
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(emailFocusNode);
                      },
                      controller: panController,
                      decoration: InputDecoration(
                        filled: true,
                        isDense: true,
                        border: InputBorder.none,
                        hintText: 'e.g., ABCD9999F',
                        hintStyle: TextStyle(
                            color: AppColors.grey,
                            fontFamily: "Helvetica",
                            fontSize: SizeUtil.body(context)),
                        fillColor: TextfieldColors.background,
                      ),
                      style: TextStyle(
                          fontSize: SizeUtil.body(context),
                          fontFamily: "Helvetica"),
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z0-9]')),
                        LengthLimitingTextInputFormatter(10)
                      ],
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        RegExp regex = RegExp(r'^[A-Za-z]{5}\d{4}[A-Za-z]$');
                        if (value!.isEmpty) {
                          return 'pan card number is required';
                        } else {
                          if (!regex.hasMatch(value)) {
                            return 'please enter valid pan card number';
                          } else {
                            return null;
                          }
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: SizeUtil.verticalSpacingMedium(context)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Email',
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
                      maxLength: 60,
                      focusNode: emailFocusNode,
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(phoneNoFocusNode);
                      },
                      controller: emailController,
                      decoration: InputDecoration(
                        counterText: "",
                        filled: true,
                        isDense: true,
                        border: InputBorder.none,
                        hintText: 'e.g. something@email.com',
                        hintStyle: TextStyle(
                            color: AppColors.grey,
                            fontFamily: "Helvetica",
                            fontSize: SizeUtil.body(context)),
                        fillColor: TextfieldColors.background,
                      ),
                      style: TextStyle(
                          fontSize: SizeUtil.body(context),
                          fontFamily: "Helvetica"),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        RegExp regex = RegExp(
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                        if (value!.isEmpty) {
                          return 'email is required';
                        } else {
                          if (!regex.hasMatch(value)) {
                            return 'please enter valid email';
                          } else {
                            return null;
                          }
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: SizeUtil.verticalSpacingMedium(context)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Phone Number (10 digits)',
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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: TextFormField(
                            maxLength: 10,
                            focusNode: phoneNoFocusNode,
                            onEditingComplete: () {
                              FocusScope.of(context)
                                  .requestFocus(dateofBirthFocusNode);
                            },
                            controller: phoneNoController,
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              counterText: "",
                              suffixIcon: const Padding(
                                padding: EdgeInsets.only(right: 5.0),
                                child: Icon(Icons.check_circle,
                                    size: 30, color: AppColors.primary),
                              ),
                              suffixIconConstraints: const BoxConstraints(),
                              filled: true,
                              isDense: true,
                              border: InputBorder.none,
                              hintText: 'e.g., 9876543210',
                              hintStyle: TextStyle(
                                  color: AppColors.grey,
                                  fontFamily: "Helvetica",
                                  fontSize: SizeUtil.body(context)),
                              fillColor: TextfieldColors.background,
                            ),
                            style: TextStyle(
                                fontSize: SizeUtil.body(context),
                                fontFamily: "Helvetica"),
                            onChanged: (value) {},
                            validator: (value) {
                              if (value!.isEmpty &&
                                  !phoneNoFocusNode.hasFocus) {
                                return 'phone number is required';
                              } else {
                                if (value.length != 10) {
                                  return 'phone number must be exactly 10 digits.';
                                }
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Padding(
                        padding: const EdgeInsets.only(top: 7.5),
                        child: GestureDetector(
                          onTap: () async {
                            // await showDialog(
                            //   barrierDismissible: false,
                            //   context: context,
                            //   builder: (BuildContext context) {
                            //     return OtpVerification(
                            //         mobileNumber:
                            //             phoneNoController.text.toString());
                            //   },
                            // );
                          },
                          child: Text(
                            "Send OTP",
                            style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w400,
                                fontSize: SizeUtil.body(context),
                                fontFamily: "Helvetica"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: SizeUtil.verticalSpacingMedium(context)),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              RichText(
                textScaleFactor: MediaQuery.of(context).textScaleFactor,
                textAlign: TextAlign.start,
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: 'Date of Birth',
                        style: TextStyle(
                            fontSize: SizeUtil.bodyLarge(context),
                            color: AppColors.grey,
                            fontFamily: "Helvetica")),
                    TextSpan(
                        text: "*",
                        style: TextStyle(
                            fontSize: SizeUtil.bodyLarge(context),
                            color: AppColors.red)),
                  ],
                ),
              ),
              const SizedBox(height: 2),
              Padding(
                padding: const EdgeInsets.only(right: 40),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          onTap: () => _selectDateOfBirth(context),
                          child: const Icon(Icons.calendar_month,
                              size: 30, color: AppColors.primary),
                        ),
                      ),
                      suffixIconConstraints: const BoxConstraints(),
                      filled: true,
                      isDense: true,
                      border: InputBorder.none,
                      hintText: 'e.g., 01/11/2021',
                      hintStyle: const TextStyle(
                          color: AppColors.grey, fontFamily: "Helvetica"),
                      fillColor: TextfieldColors.background,
                    ),
                    style: TextStyle(
                      fontSize: SizeUtil.body(context),
                    ),
                    controller: dateofBirthController,
                    focusNode: dateofBirthFocusNode,
                    onEditingComplete: () {
                      dateofBirthFocusNode.requestFocus(genderFocusNode);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'date of birth is required';
                      } else {
                        return null;
                      }
                    },
                    onTap: () => _selectDateOfBirth(context),
                  ),
                ),
              )
            ]),
            SizedBox(
              height: SizeUtil.verticalSpacingMedium(context),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Gender',
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
                        FocusScope.of(context).requestFocus(aadhaarFocusNode);
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        hintText: 'e.g., Male, Femle',
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontFamily: "Helvetica",
                            fontSize: SizeUtil.body(context)),
                        fillColor: TextfieldColors.background,
                      ),
                      readOnly: true,
                      onTap: _toggleGenderDropdown,
                      style: TextStyle(
                          fontSize: SizeUtil.body(context),
                          fontFamily: "Helvetica"),
                      controller: genderController,
                      focusNode: genderFocusNode,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'gender is required';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),
                if (_showGenderDropdown)
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
                            if (genderList.isEmpty)
                              ListTile(
                                title: Text(
                                  'No Records Found',
                                  style: TextStyle(
                                      fontSize: SizeUtil.body(context),
                                      fontFamily: "Helvetica"),
                                ),
                                enabled: false,
                              ),
                            if (genderList.isNotEmpty)
                              ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: genderList.length,
                                itemBuilder: (context, index) {
                                  final option = genderList[index];
                                  return ListTile(
                                    dense: true,
                                    title: Text(option,
                                        style: TextStyle(
                                            fontFamily: "Helvetica",
                                            fontSize: SizeUtil.body(context))),
                                    onTap: () {
                                      setState(() {
                                        genderController.text = option;
                                        _showGenderDropdown = false;
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
            SizedBox(height: SizeUtil.verticalSpacingMedium(context)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Last 4 digit of Aadhaar',
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
                      focusNode: aadhaarFocusNode,
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                      },
                      controller: aadhaarController,
                      decoration: InputDecoration(
                        filled: true,
                        isDense: true,
                        border: InputBorder.none,
                        hintText: 'e.g. 1234',
                        hintStyle: TextStyle(
                            color: AppColors.grey,
                            fontFamily: "Helvetica",
                            fontSize: SizeUtil.body(context)),
                        fillColor: TextfieldColors.background,
                      ),
                      style: TextStyle(
                          fontSize: SizeUtil.body(context),
                          fontFamily: "Helvetica"),
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4)
                      ],
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'last 4 digit is required';
                        } else {
                          if (value.length < 4) {
                            return 'please enter last 4 digit';
                          } else {
                            return null;
                          }
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.35,
            )
          ],
        ),
      ),
    );
  }

  Widget kycForm2() {
    return SingleChildScrollView(
      child: Form(
        key: formKeys[1],
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Father name',
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
                      maxLength: 40,
                      controller: fatherNameController,
                      autofocus: true,
                      focusNode: fathernameFocusNode,
                      onEditingComplete: () {
                        FocusScope.of(context)
                            .requestFocus(motherNameFocusNode);
                      },
                      decoration: InputDecoration(
                        counterText: "",
                        filled: true,
                        isDense: true,
                        border: InputBorder.none,
                        hintText: 'e.g. John Doe',
                        hintStyle: TextStyle(
                            color: AppColors.grey,
                            fontFamily: "Helvetica",
                            fontSize: SizeUtil.body(context)),
                        fillColor: TextfieldColors.background,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[a-z A-Z]'))
                      ],
                      style: TextStyle(fontSize: SizeUtil.body(context)),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'father name is required';
                        } else {
                          if (value.length < 2) {
                            return 'please enter valid name';
                          }
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: SizeUtil.verticalSpacingMedium(context)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Mother name',
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
                      maxLength: 40,
                      controller: motherNameController,
                      autofocus: true,
                      focusNode: motherNameFocusNode,
                      onEditingComplete: () {
                        FocusScope.of(context)
                            .requestFocus(countryOfBirthFocusNode);
                      },
                      decoration: InputDecoration(
                        counterText: "",
                        filled: true,
                        isDense: true,
                        border: InputBorder.none,
                        hintText: 'e.g. John Doe',
                        hintStyle: TextStyle(
                            color: AppColors.grey,
                            fontFamily: "Helvetica",
                            fontSize: SizeUtil.body(context)),
                        fillColor: TextfieldColors.background,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[a-z A-Z]'))
                      ],
                      style: TextStyle(fontSize: SizeUtil.body(context)),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'mother name is required';
                        } else {
                          if (value.length < 2) {
                            return 'please enter valid name';
                          }
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: SizeUtil.verticalSpacingMedium(context)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Country of Birth',
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
                            .requestFocus(maritalStatusFocusNode);
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        hintText: 'e.g., IN, USA',
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontFamily: "Helvetica",
                            fontSize: SizeUtil.body(context)),
                        fillColor: TextfieldColors.background,
                      ),
                      readOnly: true,
                      onTap: _toggleCountryofBirthDropdown,
                      style: TextStyle(
                          fontSize: SizeUtil.body(context),
                          fontFamily: "Helvetica"),
                      controller: countryOfBirthController,
                      focusNode: countryOfBirthFocusNode,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'country of birth is required';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),
                if (_showCountryOfBirthDropdown)
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
                            if (countryofBirthList.isEmpty)
                              ListTile(
                                title: Text(
                                  'No Records Found',
                                  style: TextStyle(
                                      fontSize: SizeUtil.body(context),
                                      fontFamily: "Helvetica"),
                                ),
                                enabled: false,
                              ),
                            if (countryofBirthList.isNotEmpty)
                              ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: countryofBirthList.length,
                                itemBuilder: (context, index) {
                                  final option = countryofBirthList[index];
                                  return ListTile(
                                    dense: true,
                                    title: Text(option,
                                        style: TextStyle(
                                            fontFamily: "Helvetica",
                                            fontSize: SizeUtil.body(context))),
                                    onTap: () {
                                      setState(() {
                                        countryOfBirthController.text = option;
                                        _showCountryOfBirthDropdown = false;
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
            SizedBox(height: SizeUtil.verticalSpacingMedium(context)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Marital Status',
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
                            .requestFocus(occupationTypeFocusNode);
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        hintText: 'e.g., married, unmarried',
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontFamily: "Helvetica",
                            fontSize: SizeUtil.body(context)),
                        fillColor: TextfieldColors.background,
                      ),
                      readOnly: true,
                      onTap: _toggleMaritalStatusDropdown,
                      style: TextStyle(
                          fontSize: SizeUtil.body(context),
                          fontFamily: "Helvetica"),
                      controller: maritalStatusController,
                      focusNode: maritalStatusFocusNode,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'marital status is required';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),
                if (_showMaritalStatusDropdown)
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
                            if (maritalStatusList.isEmpty)
                              ListTile(
                                title: Text(
                                  'No Records Found',
                                  style: TextStyle(
                                      fontSize: SizeUtil.body(context),
                                      fontFamily: "Helvetica"),
                                ),
                                enabled: false,
                              ),
                            if (maritalStatusList.isNotEmpty)
                              ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: maritalStatusList.length,
                                itemBuilder: (context, index) {
                                  final option = maritalStatusList[index];
                                  return ListTile(
                                    dense: true,
                                    title: Text(option,
                                        style: TextStyle(
                                            fontFamily: "Helvetica",
                                            fontSize: SizeUtil.body(context))),
                                    onTap: () {
                                      setState(() {
                                        maritalStatusController.text = option;
                                        _showMaritalStatusDropdown = false;
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
            SizedBox(height: SizeUtil.verticalSpacingMedium(context)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Occupation',
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
                        FocusScope.of(context).unfocus();
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        hintText: 'e.g., business, professional, self_employed',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontFamily: "Helvetica",
                          fontSize: SizeUtil.body(context),
                        ),
                        fillColor: TextfieldColors.background,
                      ),
                      readOnly: true,
                      onTap: _toggleOccupationTypeDropdown,
                      style: TextStyle(
                        fontSize: SizeUtil.body(context),
                        fontFamily: "Helvetica",
                      ),
                      controller: occupationTypeController,
                      focusNode: occupationTypeFocusNode,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'occupation type is required';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),
                if (_showOccupationTypeDropdown)
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
                            if (occupationTypeList.isEmpty)
                              ListTile(
                                title: Text(
                                  'No Records Found',
                                  style: TextStyle(
                                    fontSize: SizeUtil.body(context),
                                    fontFamily: "Helvetica",
                                  ),
                                ),
                                enabled: false,
                              ),
                            if (occupationTypeList.isNotEmpty)
                              SizedBox(
                                height: 150,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  itemCount: occupationTypeList.length,
                                  itemBuilder: (context, index) {
                                    final option = occupationTypeList[index];
                                    return ListTile(
                                      dense: true,
                                      title: Text(
                                        option,
                                        style: TextStyle(
                                          fontFamily: "Helvetica",
                                          fontSize: SizeUtil.body(context),
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          occupationTypeController.text =
                                              option;
                                          _showOccupationTypeDropdown = false;
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
            SizedBox(
              height: height * 0.35,
            )
          ],
        ),
      ),
    );
  }

  Widget kycForm3() {
    return SingleChildScrollView(
      child: Form(
          key: formKeys[2],
          child: Column(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Address with proof (address)',
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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: TextFormField(
                            readOnly: true,
                            controller: addressProofDocumentController,
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              counterText: "",
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      addressProofDocumentController.clear();
                                      addressProofDocument = null;
                                    });
                                  },
                                  child: const Icon(Icons.clear,
                                      size: 20, color: AppColors.primary),
                                ),
                              ),
                              suffixIconConstraints: const BoxConstraints(),
                              filled: true,
                              isDense: true,
                              border: InputBorder.none,
                              hintText: 'document.jpg',
                              hintStyle: TextStyle(
                                  color: AppColors.grey,
                                  fontFamily: "Helvetica",
                                  fontSize: SizeUtil.body(context)),
                              fillColor: TextfieldColors.background,
                            ),
                            style: TextStyle(
                                fontSize: SizeUtil.body(context),
                                fontFamily: "Helvetica"),
                            onChanged: (value) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'address proof is required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: GestureDetector(
                          onTap: () {
                            if (addressProofDocument == null) {
                              mediaPicker(addressProofDocumentController,
                                  (image) {
                                setState(() {
                                  addressProofDocumentController.text =
                                      image.name;
                                  addressProofDocument = image;
                                });
                              }, false);
                            }
                          },
                          child: Text(
                            addressProofDocument == null
                                ? "Select a file"
                                : "Uploaded",
                            style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w400,
                                fontSize: SizeUtil.body(context),
                                fontFamily: "Helvetica"),
                          ),
                        ),
                      ),
                    ],
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
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'PAN card copy (identity_proof)',
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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: TextFormField(
                            readOnly: true,
                            controller: panCardDocumentController,
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              counterText: "",
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      panCardDocumentController.clear();
                                      panCardDocument = null;
                                    });
                                  },
                                  child: const Icon(Icons.clear,
                                      size: 20, color: AppColors.primary),
                                ),
                              ),
                              suffixIconConstraints: const BoxConstraints(),
                              filled: true,
                              isDense: true,
                              border: InputBorder.none,
                              hintText: 'document.jpg',
                              hintStyle: TextStyle(
                                  color: AppColors.grey,
                                  fontFamily: "Helvetica",
                                  fontSize: SizeUtil.body(context)),
                              fillColor: TextfieldColors.background,
                            ),
                            style: TextStyle(
                                fontSize: SizeUtil.body(context),
                                fontFamily: "Helvetica"),
                            onChanged: (value) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'pan card copy is required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: GestureDetector(
                          onTap: () {
                            if (panCardDocument == null) {
                              mediaPicker(panCardDocumentController, (image) {
                                setState(() {
                                  panCardDocumentController.text = image.name;
                                  panCardDocument = image;
                                });
                              }, false);
                            }
                          },
                          child: Text(
                            panCardDocument == null
                                ? "Select a file"
                                : "Uploaded",
                            style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w400,
                                fontSize: SizeUtil.body(context),
                                fontFamily: "Helvetica"),
                          ),
                        ),
                      ),
                    ],
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
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Signature scan (signature)',
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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: TextFormField(
                            readOnly: true,
                            controller: signatureScanDocumentController,
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              counterText: "",
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      signatureScanDocumentController.clear();
                                      signatureScanDocument = null;
                                    });
                                  },
                                  child: const Icon(Icons.clear,
                                      size: 20, color: AppColors.primary),
                                ),
                              ),
                              suffixIconConstraints: const BoxConstraints(),
                              filled: true,
                              isDense: true,
                              border: InputBorder.none,
                              hintText: 'document.jpg',
                              hintStyle: TextStyle(
                                  color: AppColors.grey,
                                  fontFamily: "Helvetica",
                                  fontSize: SizeUtil.body(context)),
                              fillColor: TextfieldColors.background,
                            ),
                            style: TextStyle(
                                fontSize: SizeUtil.body(context),
                                fontFamily: "Helvetica"),
                            onChanged: (value) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'signature is required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: GestureDetector(
                          onTap: () {
                            if (signatureScanDocument == null) {
                              mediaPicker(signatureScanDocumentController,
                                  (image) {
                                setState(() {
                                  signatureScanDocumentController.text =
                                      image.name;
                                  signatureScanDocument = image;
                                });
                              }, false);
                            }
                          },
                          child: Text(
                            signatureScanDocument == null
                                ? "Select a file"
                                : "Uploaded",
                            style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w400,
                                fontSize: SizeUtil.body(context),
                                fontFamily: "Helvetica"),
                          ),
                        ),
                      ),
                    ],
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
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Photo',
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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: TextFormField(
                            readOnly: true,
                            controller: photoDocumentController,
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              counterText: "",
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      photoDocumentController.clear();
                                      photoDocument = null;
                                    });
                                  },
                                  child: const Icon(Icons.clear,
                                      size: 20, color: AppColors.primary),
                                ),
                              ),
                              suffixIconConstraints: const BoxConstraints(),
                              filled: true,
                              isDense: true,
                              border: InputBorder.none,
                              hintText: 'document.jpg',
                              hintStyle: TextStyle(
                                  color: AppColors.grey,
                                  fontFamily: "Helvetica",
                                  fontSize: SizeUtil.body(context)),
                              fillColor: TextfieldColors.background,
                            ),
                            style: TextStyle(
                                fontSize: SizeUtil.body(context),
                                fontFamily: "Helvetica"),
                            onChanged: (value) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'photo is required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: GestureDetector(
                          onTap: () {
                            if (photoDocument == null) {
                              mediaPicker(photoDocumentController, (image) {
                                setState(() {
                                  photoDocumentController.text = image.name;
                                  photoDocument = image;
                                });
                              }, false);
                            }
                          },
                          child: Text(
                            photoDocument == null
                                ? "Select a file"
                                : "Uploaded",
                            style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w400,
                                fontSize: SizeUtil.body(context),
                                fontFamily: "Helvetica"),
                          ),
                        ),
                      ),
                    ],
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
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Bank account details (bank_account)',
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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: TextFormField(
                            readOnly: true,
                            controller: bankAccountDocumentController,
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              counterText: "",
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      bankAccountDocumentController.clear();
                                      bankAccountDocument = null;
                                    });
                                  },
                                  child: const Icon(Icons.clear,
                                      size: 20, color: AppColors.primary),
                                ),
                              ),
                              suffixIconConstraints: const BoxConstraints(),
                              filled: true,
                              isDense: true,
                              border: InputBorder.none,
                              hintText: 'document.jpg',
                              hintStyle: TextStyle(
                                  color: AppColors.grey,
                                  fontFamily: "Helvetica",
                                  fontSize: SizeUtil.body(context)),
                              fillColor: TextfieldColors.background,
                            ),
                            style: TextStyle(
                                fontSize: SizeUtil.body(context),
                                fontFamily: "Helvetica"),
                            onChanged: (value) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'pan card copy is required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: GestureDetector(
                          onTap: () {
                            if (bankAccountDocument == null) {
                              mediaPicker(bankAccountDocumentController,
                                  (image) {
                                setState(() {
                                  bankAccountDocumentController.text =
                                      image.name;
                                  bankAccountDocument = image;
                                });
                              }, false);
                            }
                          },
                          child: Text(
                            bankAccountDocument == null
                                ? "Select a file"
                                : "Uploaded",
                            style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w400,
                                fontSize: SizeUtil.body(context),
                                fontFamily: "Helvetica"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: SizeUtil.verticalSpacingMedium(context)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Verification Video (ipv_video)',
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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: TextFormField(
                            readOnly: true,
                            controller: videoVerificationDocumentController,
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              counterText: "",
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      videoVerificationDocumentController
                                          .clear();
                                      videoVerificationDocument = null;
                                    });
                                  },
                                  child: const Icon(Icons.clear,
                                      size: 20, color: AppColors.primary),
                                ),
                              ),
                              suffixIconConstraints: const BoxConstraints(),
                              filled: true,
                              isDense: true,
                              border: InputBorder.none,
                              hintText: 'document.mp4',
                              hintStyle: TextStyle(
                                  color: AppColors.grey,
                                  fontFamily: "Helvetica",
                                  fontSize: SizeUtil.body(context)),
                              fillColor: TextfieldColors.background,
                            ),
                            style: TextStyle(
                                fontSize: SizeUtil.body(context),
                                fontFamily: "Helvetica"),
                            onChanged: (value) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'pan card copy is required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: GestureDetector(
                          onTap: () {
                            if (videoVerificationDocument == null) {
                              mediaPicker(videoVerificationDocumentController,
                                  (video) {
                                setState(() {
                                  videoVerificationDocumentController.text =
                                      video.name;
                                  videoVerificationDocument = video;
                                });
                              }, true);
                            }
                          },
                          child: Text(
                            videoVerificationDocument == null
                                ? "select a file"
                                : "Uploaded",
                            style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w400,
                                fontSize: SizeUtil.body(context),
                                fontFamily: "Helvetica"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: SizeUtil.verticalSpacingMedium(context),
            ),
            const WarningMessage(
                message: ConstantUtil.warningMessageToUploadImage),
            SizedBox(height: SizeUtil.verticalSpacingSmall(context)),
            const WarningMessage(
                message: ConstantUtil.warningMessageToUploadVideo),
            SizedBox(
              height: height * 0.35,
            )
          ])),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SmallAppbar(heading: "KYC Details"),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.04,
                vertical: SizeUtil.scallingFactor(context) * 35),
            child: Text(
              textAlign: TextAlign.start,
              getCurrentKYCStepName(currentStep),
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
                fontSize: SizeUtil.headingLarge2(context),
                fontFamily: "Helvetica",
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04,
              ),
              child: getCurrentKYCForm(),
            ),
          ),
          Container(
            color: AppColors.white,
            padding: EdgeInsets.only(bottom: size.height * 0.02),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SmallButton(
                      text: "Cancel",
                      onPressed: back,
                      backgroundColor: AppColors.white,
                      textColor: AppColors.primary,
                    ),
                    SmallButton(
                      text: "Next",
                      onPressed: next,
                      backgroundColor: AppColors.primary,
                      textColor: AppColors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getCurrentKYCForm() {
    switch (currentStep) {
      case 1:
        return kycForm1();
      case 2:
        return kycForm2();
      case 3:
        return kycForm3();
      default:
        return Container();
    }
  }

  String getCurrentKYCStepName(int step) {
    switch (step) {
      case 1:
        return "KYC Basic Information";
      case 2:
        return "Personal Information";
      case 3:
        return "Document Verification";
      default:
        return "";
    }
  }

  void mediaPicker(TextEditingController controller, Function(XFile) onSelected,
      bool isVideo) {
    Get.bottomSheet(
      SingleChildScrollView(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: SizeUtil.verticalSpacingSmall(context)),
                  Text(
                    "Pick Image From",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .apply(color: AppColors.primary),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SizeUtil.verticalSpacingMedium(context)),
                  CustomIconButton(
                    text: " Camera",
                    onPressed: () async {
                      if (isVideo) {
                        XFile? file = await pickVideo(ImageSource.camera);
                        if (file != null) {
                          onSelected(file);
                          Get.back();
                        }
                      } else {
                        XFile? file = await pickImage(ImageSource.camera);
                        if (file != null) {
                          onSelected(file);
                          Get.back();
                        }
                      }
                    },
                    backgroundColor: AppColors.primary,
                    textColor: AppColors.white,
                    icon: Icons.camera,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomIconButton(
                    text: " Gallery",
                    onPressed: () async {
                      if (isVideo) {
                        XFile? file = await pickVideo(ImageSource.gallery);
                        if (file != null) {
                          onSelected(file);
                          Get.back();
                        }
                      } else {
                        XFile? file = await pickImage(ImageSource.gallery);
                        if (file != null) {
                          onSelected(file);
                          Get.back();
                        }
                      }
                    },
                    backgroundColor: AppColors.primary,
                    textColor: AppColors.white,
                    icon: Icons.image,
                  ),
                  SizedBox(height: SizeUtil.verticalSpacingMedium(context)),
                  CustomIconButton(
                    text: " Cancel",
                    onPressed: () {
                      Get.back();
                    },
                    backgroundColor: AppColors.white,
                    textColor: AppColors.primary,
                    icon: Icons.close,
                  ),
                  SizedBox(height: SizeUtil.verticalSpacingMedium(context)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<XFile?> pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      return photo != null ? XFile(photo.path) : null;
    } catch (error) {
      debugPrint(error.toString());
      return null;
    }
  }

  Future<XFile?> pickVideo(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickVideo(source: imageType);
      return photo != null ? XFile(photo.path) : null;
    } catch (error) {
      debugPrint(error.toString());
      return null;
    }
  }

//    void requestPermissionsAndPickImage() async {
//   // Check if permissions are already granted
//   final cameraStatus = await Permission.camera.status;
//   final photosStatus = await Permission.photos.status;

//   if (cameraStatus.isGranted && photosStatus.isGranted) {
//     // Permissions are already granted, open image picker
//     // imagePickerOption();
//   } else {
//     // Permissions are not granted, request permissions
//     final cameraPermissionStatus = await Permission.camera.request();
//     final photosPermissionStatus = await Permission.photos.request();

//     if (cameraPermissionStatus.isGranted && photosPermissionStatus.isGranted) {
//       // Permissions granted, open image picker
//       imagePickerOption();
//     } else {
//       // Handle cases where the user denied permission
//       Get.snackbar(
//         "Permission Denied",
//         "Please grant camera and photos access to select an image.",
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }
// }

  // void imagePickerOption() {
  //   Get.bottomSheet(
  //     SingleChildScrollView(
  //       child: ClipRRect(
  //         borderRadius: const BorderRadius.only(
  //           topLeft: Radius.circular(10.0),
  //           topRight: Radius.circular(10.0),
  //         ),
  //         child: Container(
  //           color: Colors.white,
  //           child: Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.stretch,
  //               children: [
  //                 SizedBox(height: SizeUtil.verticalSpacingSmall(context)),
  //                 Text(
  //                   "Pick Image From",
  //                   style: Theme.of(context)
  //                       .textTheme
  //                       .headline6!
  //                       .apply(color: AppColors.primary),
  //                   textAlign: TextAlign.center,
  //                 ),
  //                 SizedBox(height: SizeUtil.verticalSpacingMedium(context)),
  //                 CustomIconButton(
  //                   text: " Camera",
  //                   onPressed: () {
  //                     pickImage(ImageSource.camera);
  //                   },
  //                   backgroundColor: AppColors.primary,
  //                   textColor: AppColors.white,
  //                   icon: Icons.camera,
  //                 ),
  //                 const SizedBox(
  //                   height: 20,
  //                 ),
  //                 CustomIconButton(
  //                   text: " Gallery",
  //                   onPressed: () {
  //                     pickImage(ImageSource.gallery);
  //                   },
  //                   backgroundColor: AppColors.primary,
  //                   textColor: AppColors.white,
  //                   icon: Icons.image,
  //                 ),
  //                 SizedBox(height: SizeUtil.verticalSpacingMedium(context)),
  //                 CustomIconButton(
  //                   text: " Cancel",
  //                   onPressed: () {
  //                     Get.back();
  //                   },
  //                   backgroundColor: AppColors.white,
  //                   textColor: AppColors.primary,
  //                   icon: Icons.close,
  //                 ),
  //                 SizedBox(height: SizeUtil.verticalSpacingMedium(context)),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // pickImage(ImageSource imageType) async {
  //   try {
  //     final photo = await ImagePicker().pickImage(source: imageType);
  //     final tempImage = File(photo!.path);
  //     setState(() {
  //       addressProofDocument = tempImage;
  //       addressProofDocumentController.text = photo.name;
  //     });

  //     Get.back();
  //   } catch (error) {
  //     debugPrint(error.toString());
  //   }
  // }
}
