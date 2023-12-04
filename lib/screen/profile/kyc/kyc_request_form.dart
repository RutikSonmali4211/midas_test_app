import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:midas/constant/colors.dart';
import 'package:midas/constant/constant_util.dart';
import 'package:midas/constant/size_util.dart';
import 'package:midas/widgets/alert_message/alert_message.dart';
import 'package:midas/widgets/alert_message/warning_message.dart';
import 'package:midas/widgets/appbar/small_appbar.dart';
import 'package:midas/widgets/buttons/icon_button.dart';
import 'package:midas/widgets/buttons/small_button.dart';
import 'package:midas/widgets/upper_case_formatter.dart';
import '../../../Controller/kyc/kyc_controller.dart';
import '../../../Model/Dto/ImageData.dart';
import 'kyc_pending.dart';

class KYCRequestForm extends StatefulWidget {
  const KYCRequestForm({super.key});

  @override
  State<KYCRequestForm> createState() => _KYCRequestFormState();
}

class _KYCRequestFormState extends State<KYCRequestForm> {
  var height;
  var width;
  var addressFileId = "";
  var addressProofBackId = "";
  var bankAccountDocId = "";
  var panCardDocId = "";
  var photoDocId = "";
  var signDocId = "";
  var ipvVedioId = "";
  int currentStep = 1;
  int stepLength = 4;
  bool complete = false;

  List<GlobalKey<FormState>> formKeys =
      List.generate(5, (_) => GlobalKey<FormState>());

  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController panController = TextEditingController();
  TextEditingController aadhaarController = TextEditingController();
  TextEditingController dateofBirthController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController motherNameController = TextEditingController();
  TextEditingController spouseNameController = TextEditingController();
  TextEditingController countryOfBirthController = TextEditingController();
  TextEditingController maritalStatusController = TextEditingController();
  TextEditingController occupationTypeController = TextEditingController();

// controllers to select document for address to uplaod
  TextEditingController addressline1Controller = TextEditingController();
  TextEditingController addressline2Controller = TextEditingController();
  TextEditingController addressline3Controller = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController addressProofController = TextEditingController();
  TextEditingController addressProofBackController = TextEditingController();
  TextEditingController addressProofTypeController = TextEditingController();
  TextEditingController addressProofNumberController = TextEditingController();
  TextEditingController addressProofIssueDateController =
      TextEditingController();
  TextEditingController addressProofExpiryDateController =
      TextEditingController();

  // controllers to select document for bank account details to uplaod
  TextEditingController bankAccountHolderNameController =
      TextEditingController();
  TextEditingController bankAccountNumberController = TextEditingController();
  TextEditingController bankAccountIfscCodeController = TextEditingController();
  TextEditingController bankAccountProofController = TextEditingController();

  // controllers to documents to uplaod
  TextEditingController panCardDocumentController = TextEditingController();
  TextEditingController signatureScanDocumentController =
      TextEditingController();
  TextEditingController photoDocumentController = TextEditingController();
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
  final FocusNode spouseNameFocusNode = FocusNode();
  final FocusNode countryOfBirthFocusNode = FocusNode();
  final FocusNode maritalStatusFocusNode = FocusNode();
  final FocusNode occupationTypeFocusNode = FocusNode();

// focus nodes to select document for address to uplaod

  final FocusNode addressline1FocusNode = FocusNode();
  final FocusNode addressline2FocusNode = FocusNode();
  final FocusNode addressline3FocusNode = FocusNode();
  final FocusNode cityFocusNode = FocusNode();
  final FocusNode pincodeFocusNode = FocusNode();
  final FocusNode countryFocusNode = FocusNode();
  final FocusNode addressProofFocusNode = FocusNode();
  final FocusNode addressProofBackFocusNode = FocusNode();
  final FocusNode addressProofTypeFocusNode = FocusNode();
  final FocusNode addressProofNumberFocusNode = FocusNode();
  final FocusNode addressProofIssueDateFocusNode = FocusNode();
  final FocusNode addressProofExpiryDateFocusNode = FocusNode();

  // focus nodes to select document for bank account details to uplaod
  final FocusNode bankAccountHolderNameFocusNode = FocusNode();
  final FocusNode bankAccountNumberFocusNode = FocusNode();
  final FocusNode bankAccountIfscCodeFocusNode = FocusNode();
  final FocusNode bankAccountProofFocusNode = FocusNode();

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
    panCardDocumentController.dispose();
    signatureScanDocumentController.dispose();
    photoDocumentController.dispose();
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
  XFile? addressProofBackDocument;
  XFile? panCardDocument;
  XFile? signatureScanDocument;
  XFile? photoDocument;
  XFile? bankAccountProofDocument;
  XFile? videoVerificationDocument;

  List<String> genderList = ["male", "female", "transgender"];
  List<String> countriesList = ["in"];
  List<String> addressProofTypeList = [
    "passport",
    "voter id",
    "driving licence"
  ];
  List<String> maritalStatusList = ["married", "unmarried", "others"];

  List<String> occupationTypeList = [
    "business",
    "professional",
    "self employed",
    "retired",
    "housewife",
    "student",
    "public sector",
    "private sector",
    "government sector",
    "others"
  ];
  bool _showGenderDropdown = false;
  bool _showCountryOfBirthDropdown = false;
  bool _showCountryDropdown = false;
  bool _showAddressProofType = false;
  bool _showMaritalStatusDropdown = false;
  bool _showOccupationTypeDropdown = false;
  KycController kycController = Get.put(KycController());

  @override
  void initState() {
    super.initState();
    setPresentDetails();
  }

  setPresentDetails() async {
    final Map<String, dynamic> data =
        await kycController.fetchKycDetails(context);
    if (data["status"] == true) {
      fullNameController.text = data["result"]["name"] ?? "";
      phoneNoController.text = data["result"]["mobile"]["number"] ?? "";
      emailController.text = data["result"]["email"] ?? "";
      panController.text = data["result"]["pan"] ?? "";
      aadhaarController.text = (data["result"]["aadhaar_number"] ?? "").toString();
      dateofBirthController.text = data["result"]["date_of_birth"] ?? "";
      genderController.text = data["result"]["gender"] ?? "";
      fatherNameController.text = data["result"]["father_name"] ?? "";
      motherNameController.text = data["result"]["mother_name"] ?? "";
      countryOfBirthController.text = data["result"]["country_of_birth"] ?? "";
      maritalStatusController.text = data["result"]["marital_status"] ?? "";
      occupationTypeController.text = data["result"]["occupation_type"] ?? "";
      addressline1Controller.text = data["result"]["address"]["line_1"] ?? "";
      addressline2Controller.text = data["result"]["address"]["line_2"] ?? "";
      addressline3Controller.text = data["result"]["address"]["line_3"] ?? "";
      cityController.text = data["result"]["address"]["city"] ?? "";
      pincodeController.text = data["result"]["address"]["pincode"] ?? "";
      countryController.text = data["result"]["address"]["country"] ?? "";
      addressProofTypeController.text = data["result"]["address"]["proof_type"] ?? "";
      addressProofNumberController.text = data["result"]["address"]["proof_number"] ?? "";
      addressProofIssueDateController.text =
          data["result"]["address"]["proof_issue_date"] ?? "";
      addressProofExpiryDateController.text =
          data["result"]["address"]["proof_expiry_date"] ?? "";
      bankAccountHolderNameController.text =
          data["result"]["bank_account"]["account_holder_name"] ?? "";
      bankAccountNumberController.text =
          data["result"]["bank_account"]["account_number"] ?? "";
      bankAccountIfscCodeController.text =
          data["result"]["bank_account"]["ifsc_code"] ?? "";
    }
  }

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

  void _toggleCountryDropdown() async {
    setState(() {
      _showCountryDropdown = !_showCountryDropdown;
    });
  }

  void _toggleAddressProofTypeDropdown() async {
    setState(() {
      _showAddressProofType = !_showAddressProofType;
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

  uploadFile(String name, File file, String documentType) async {
    ImageData data = await kycController.uploadFile(name, file, context);
    if (documentType == ConstantUtil.addressType) {
      addressFileId = data.value;
    }
    if (documentType == ConstantUtil.addressproofBackType) {
      addressProofBackId = data.value;
    }
    if (documentType == ConstantUtil.bankAccountType) {
      bankAccountDocId = data.value;
    }
    if (documentType == ConstantUtil.ipvVedioType) {
      ipvVedioId = data.value;
    }
    if (documentType == ConstantUtil.pancardType) {
      panCardDocId = data.value;
    }
    if (documentType == ConstantUtil.photoDocType) {
      photoDocId = data.value;
    }
    if (documentType == ConstantUtil.signDocType) {
      signDocId = data.value;
    }
  }

  String ipvVedio = "test";

  Future<bool> createKyc(bool startKyc) async {
    bool isSuccess = await kycController.createKyc(
        startKyc,
        fullNameController.text.toString(),
        phoneNoController.text.toString(),
        emailController.text.toString(),
        panController.text.toString(),
        aadhaarController.text.toString(),
        dateofBirthController.text.toString(),
        genderController.text.toString(),
        fatherNameController.text.toString(),
        motherNameController.text.toString(),
        countryOfBirthController.text.toString(),
        maritalStatusController.text.toString(),
        occupationTypeController.text.toString(),
        addressline1Controller.text.toString(),
        addressline2Controller.text.toString(),
        addressline3Controller.text.toString(),
        cityController.text.toString(),
        pincodeController.text.toString(),
        countryController.text.toString(),
        addressFileId,
        addressProofBackId,
        addressProofTypeController.text.toString(),
        addressProofNumberController.text.toString(),
        addressProofIssueDateController.text.toString(),
        addressProofExpiryDateController.text.toString(),
        bankAccountHolderNameController.text.toString(),
        bankAccountNumberController.text.toString(),
        bankAccountIfscCodeController.text.toString(),
        bankAccountDocId,
        panCardDocId,
        signDocId,
        photoDocId,
        ipvVedioId,
        context);
    if (isSuccess) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> next() async {
    if (currentStep <= 4) {
      if (formKeys[currentStep - 1].currentState!.validate()) {
        try {
          bool kycupdate = await createKyc(false);
          if (kycupdate) {
            setState(() => currentStep += 1);
          } else {
            print("KYC update failed");
          }
        } catch (e) {
          print("Error during KYC update: $e");
        }
      }
    } else if (currentStep == 5) {
      if (formKeys[currentStep - 1].currentState!.validate()) {
        try {
          bool kycupdate = await createKyc(true);
          if (kycupdate) {
            // ignore: use_build_context_synchronously
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const KycPendingPhase()),
            );
          } else {
            print("KYC update failed");
          }
        } catch (e) {
          print("Error during KYC update: $e");
        }
      }
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

  Future<void> _selectAddressProofIssueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        addressProofIssueDateController.text =
            "${picked.year.toString()}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  Future<void> _selectAddressProofExpiryDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        addressProofExpiryDateController.text =
            "${picked.year.toString()}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  Widget kycBasicInformationForm() {
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

  Widget kycPersonalInformationForm() {
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
                        hintText: 'e.g., India',
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
                            if (countriesList.isEmpty)
                              ListTile(
                                title: Text(
                                  'No Records Found',
                                  style: TextStyle(
                                      fontSize: SizeUtil.body(context),
                                      fontFamily: "Helvetica"),
                                ),
                                enabled: false,
                              ),
                            if (countriesList.isNotEmpty)
                              ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: countriesList.length,
                                itemBuilder: (context, index) {
                                  final option = countriesList[index];
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
                        hintText: 'e.g., Married, Unmarried',
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
            if (maritalStatusController.text == "Married")
              SizedBox(height: SizeUtil.verticalSpacingMedium(context)),
            if (maritalStatusController.text == "Married")
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    textScaleFactor: MediaQuery.of(context).textScaleFactor,
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Spouse name',
                          style: TextStyle(
                              fontSize: SizeUtil.body(context),
                              color: AppColors.grey,
                              fontFamily: "Helvetica"),
                        ),
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
                        controller: spouseNameController,
                        autofocus: true,
                        focusNode: spouseNameFocusNode,
                        onEditingComplete: () {
                          FocusScope.of(context)
                              .requestFocus(occupationTypeFocusNode);
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
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[a-z A-Z]'))
                        ],
                        style: TextStyle(fontSize: SizeUtil.body(context)),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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

  Widget kycAddressDetailsForm() {
    return SingleChildScrollView(
      child: Form(
        key: formKeys[2],
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
                        text: 'line 1',
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
                      maxLength: 500,
                      controller: addressline1Controller,
                      autofocus: true,
                      focusNode: addressline1FocusNode,
                      onEditingComplete: () {
                        FocusScope.of(context)
                            .requestFocus(addressline2FocusNode);
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
                      style: TextStyle(fontSize: SizeUtil.body(context)),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'line 1 is required';
                        } else {
                          if (value.length < 2) {
                            return 'please enter valid address line 1';
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
                        text: 'line 2',
                        style: TextStyle(
                            fontSize: SizeUtil.body(context),
                            color: AppColors.grey,
                            fontFamily: "Helvetica"),
                      ),
                      // TextSpan(
                      //     text: "*",
                      //     style: TextStyle(
                      //         fontSize: SizeUtil.body(context),
                      //         color: AppColors.red,
                      //         fontFamily: "Helvetica")),
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
                      controller: addressline2Controller,
                      focusNode: addressline2FocusNode,
                      onEditingComplete: () {
                        FocusScope.of(context)
                            .requestFocus(addressline3FocusNode);
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
                      style: TextStyle(fontSize: SizeUtil.body(context)),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return 'address line 2 is required';
                      //   } else {
                      //     if (value.length < 2) {
                      //       return 'please enter valid address line 2';
                      //     }
                      //   }
                      //   return null;
                      // },
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
                        text: 'line 3',
                        style: TextStyle(
                            fontSize: SizeUtil.body(context),
                            color: AppColors.grey,
                            fontFamily: "Helvetica"),
                      ),
                      // TextSpan(
                      //     text: "*",
                      //     style: TextStyle(
                      //         fontSize: SizeUtil.body(context),
                      //         color: AppColors.red,
                      //         fontFamily: "Helvetica")),
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
                      controller: addressline3Controller,
                      focusNode: addressline3FocusNode,
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(cityFocusNode);
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
                      style: TextStyle(fontSize: SizeUtil.body(context)),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return 'address line 2 is required';
                      //   } else {
                      //     if (value.length < 2) {
                      //       return 'please enter valid address line 2';
                      //     }
                      //   }
                      //   return null;
                      // },
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
                        text: 'City',
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
                      controller: cityController,
                      focusNode: cityFocusNode,
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(pincodeFocusNode);
                      },
                      decoration: InputDecoration(
                        counterText: "",
                        filled: true,
                        isDense: true,
                        border: InputBorder.none,
                        hintText: 'e.g. mumbai',
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
                          return 'city is required';
                        } else {
                          if (value.length < 2) {
                            return 'please enter valid city';
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
                        text: 'Pin Code',
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
                      controller: pincodeController,
                      focusNode: pincodeFocusNode,
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(countryFocusNode);
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
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(6),
                      ],
                      style: TextStyle(fontSize: SizeUtil.body(context)),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'pin code is required';
                        } else {
                          if (value.length < 6) {
                            return 'please enter valid pin code';
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
                        text: 'Country',
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
                            .requestFocus(addressProofTypeFocusNode);
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
                      onTap: _toggleCountryDropdown,
                      style: TextStyle(
                          fontSize: SizeUtil.body(context),
                          fontFamily: "Helvetica"),
                      controller: countryController,
                      focusNode: countryFocusNode,
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
                if (_showCountryDropdown)
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
                            if (countriesList.isEmpty)
                              ListTile(
                                title: Text(
                                  'No Records Found',
                                  style: TextStyle(
                                      fontSize: SizeUtil.body(context),
                                      fontFamily: "Helvetica"),
                                ),
                                enabled: false,
                              ),
                            if (countriesList.isNotEmpty)
                              ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: countriesList.length,
                                itemBuilder: (context, index) {
                                  final option = countriesList[index];
                                  return ListTile(
                                    dense: true,
                                    title: Text(option,
                                        style: TextStyle(
                                            fontFamily: "Helvetica",
                                            fontSize: SizeUtil.body(context))),
                                    onTap: () {
                                      setState(() {
                                        countryController.text = option;
                                        _showCountryDropdown = false;
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
                        text: 'Proof type',
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
                            .requestFocus(addressProofNumberFocusNode);
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
                        hintText: 'e.g., passport',
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontFamily: "Helvetica",
                            fontSize: SizeUtil.body(context)),
                        fillColor: TextfieldColors.background,
                      ),
                      readOnly: true,
                      onTap: _toggleAddressProofTypeDropdown,
                      style: TextStyle(
                          fontSize: SizeUtil.body(context),
                          fontFamily: "Helvetica"),
                      controller: addressProofTypeController,
                      focusNode: addressProofTypeFocusNode,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'proof type is required';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),
                if (_showAddressProofType)
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
                            if (addressProofTypeList.isEmpty)
                              ListTile(
                                title: Text(
                                  'No Records Found',
                                  style: TextStyle(
                                      fontSize: SizeUtil.body(context),
                                      fontFamily: "Helvetica"),
                                ),
                                enabled: false,
                              ),
                            if (addressProofTypeList.isNotEmpty)
                              ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: addressProofTypeList.length,
                                itemBuilder: (context, index) {
                                  final option = addressProofTypeList[index];
                                  return ListTile(
                                    dense: true,
                                    title: Text(option,
                                        style: TextStyle(
                                            fontFamily: "Helvetica",
                                            fontSize: SizeUtil.body(context))),
                                    onTap: () {
                                      setState(() {
                                        addressProofTypeController.text =
                                            option;
                                        _showAddressProofType = false;
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
                        text: 'Proof Number',
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
                      controller: addressProofNumberController,
                      focusNode: addressProofNumberFocusNode,
                      onEditingComplete: () {
                        FocusScope.of(context)
                            .requestFocus(addressProofIssueDateFocusNode);
                      },
                      decoration: InputDecoration(
                        counterText: "",
                        filled: true,
                        isDense: true,
                        border: InputBorder.none,
                        hintText: 'e.g. JXXXXXX0',
                        hintStyle: TextStyle(
                            color: AppColors.grey,
                            fontFamily: "Helvetica",
                            fontSize: SizeUtil.body(context)),
                        fillColor: TextfieldColors.background,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[0-9 a-z A-Z]'))
                      ],
                      style: TextStyle(fontSize: SizeUtil.body(context)),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'address proof number is required';
                        }
                        return null;
                      },
                    ),
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
                        text: 'Address Proof Issue Date',
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
                          onTap: () => _selectAddressProofIssueDate(context),
                          child: const Icon(Icons.calendar_month,
                              size: 30, color: AppColors.primary),
                        ),
                      ),
                      suffixIconConstraints: const BoxConstraints(),
                      filled: true,
                      isDense: true,
                      border: InputBorder.none,
                      hintText: 'e.g., 2021-11-01',
                      hintStyle: const TextStyle(
                          color: AppColors.grey, fontFamily: "Helvetica"),
                      fillColor: TextfieldColors.background,
                    ),
                    style: TextStyle(
                      fontSize: SizeUtil.body(context),
                    ),
                    controller: addressProofIssueDateController,
                    focusNode: addressProofIssueDateFocusNode,
                    onEditingComplete: () {
                      addressProofIssueDateFocusNode
                          .requestFocus(addressProofExpiryDateFocusNode);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'address proof issue date is required';
                      } else {
                        return null;
                      }
                    },
                    onTap: () => _selectAddressProofIssueDate(context),
                  ),
                ),
              )
            ]),
            SizedBox(height: SizeUtil.verticalSpacingMedium(context)),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              RichText(
                textScaleFactor: MediaQuery.of(context).textScaleFactor,
                textAlign: TextAlign.start,
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: 'Address Proof Expiry Date',
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
                          onTap: () => _selectAddressProofExpiryDate(context),
                          child: const Icon(Icons.calendar_month,
                              size: 30, color: AppColors.primary),
                        ),
                      ),
                      suffixIconConstraints: const BoxConstraints(),
                      filled: true,
                      isDense: true,
                      border: InputBorder.none,
                      hintText: 'e.g., 2021-12-01',
                      hintStyle: const TextStyle(
                          color: AppColors.grey, fontFamily: "Helvetica"),
                      fillColor: TextfieldColors.background,
                    ),
                    style: TextStyle(
                      fontSize: SizeUtil.body(context),
                    ),
                    controller: addressProofExpiryDateController,
                    focusNode: addressProofExpiryDateFocusNode,
                    onEditingComplete: () {
                      addressProofExpiryDateFocusNode
                          .requestFocus(addressProofFocusNode);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'address proof expiry date is required';
                      } else {
                        return null;
                      }
                    },
                    onTap: () => _selectAddressProofExpiryDate(context),
                  ),
                ),
              )
            ]),
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
                        text: 'Address Proof',
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
                            controller: addressProofController,
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
                                      addressProofController.clear();
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
                              mediaPicker(addressProofController, (image) {
                                setState(() {
                                  addressProofController.text = image.name;
                                  addressProofDocument = image;
                                  File selectedFile = File(image.path);
                                  uploadFile(image.name, selectedFile,
                                      ConstantUtil.addressType);
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
              height: SizeUtil.verticalSpacingSmall(context),
            ),
            const WarningMessage(
                message: ConstantUtil.warningMessageToUploadImage),
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
                        text: 'Address Proof Back',
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
                            controller: addressProofBackController,
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
                                      addressProofBackController.clear();
                                      addressProofBackDocument = null;
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
                                return 'address proof back is required';
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
                            if (addressProofBackDocument == null) {
                              mediaPicker(addressProofBackController, (image) {
                                setState(() {
                                  addressProofBackController.text = image.name;
                                  addressProofBackDocument = image;
                                  File selectedFile = File(image.path);
                                  uploadFile(image.name, selectedFile,
                                      ConstantUtil.addressproofBackType);
                                });
                              }, false);
                            }
                          },
                          child: Text(
                            addressProofBackDocument == null
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
              height: SizeUtil.verticalSpacingSmall(context),
            ),
            const WarningMessage(
                message: ConstantUtil.warningMessageToUploadImage),
            SizedBox(
              height: height * 0.35,
            )
          ],
        ),
      ),
    );
  }

  Widget kycBankDetailsForm() {
    return SingleChildScrollView(
      child: Form(
        key: formKeys[3],
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
                        text: 'Account holder name',
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
                      controller: bankAccountHolderNameController,
                      autofocus: true,
                      focusNode: bankAccountHolderNameFocusNode,
                      onEditingComplete: () {
                        FocusScope.of(context)
                            .requestFocus(bankAccountNumberFocusNode);
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
                          return 'account holder name is required';
                        } else {
                          if (value.length < 2) {
                            return 'please enter valid account holder name';
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
                        text: 'Account Number',
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
                      controller: bankAccountNumberController,
                      focusNode: bankAccountNumberFocusNode,
                      onEditingComplete: () {
                        FocusScope.of(context)
                            .requestFocus(bankAccountIfscCodeFocusNode);
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
                      keyboardType: const TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(17),
                      ],
                      style: TextStyle(fontSize: SizeUtil.body(context)),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'account number is required';
                        } else {
                          if (value.length < 11) {
                            return 'please enter valid account number';
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
                        text: 'IFSC code',
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
                      maxLength: 11,
                      controller: bankAccountIfscCodeController,
                      focusNode: bankAccountIfscCodeFocusNode,
                      onEditingComplete: () {
                        FocusScope.of(context)
                            .requestFocus(bankAccountProofFocusNode);
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
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[0-9 a-z A-Z]'))
                      ],
                      style: TextStyle(fontSize: SizeUtil.body(context)),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'ifsc code is required';
                        } else {
                          if (value.length < 11) {
                            return 'please enter valid ifsc code';
                          }
                        }
                        return null;
                      },
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
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Bank account proof',
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
                            controller: bankAccountProofController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              counterText: "",
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      bankAccountProofController.clear();
                                      bankAccountProofDocument = null;
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
                                return 'account proof is required';
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
                            if (bankAccountProofDocument == null) {
                              mediaPicker(bankAccountProofController, (image) {
                                setState(() {
                                  bankAccountProofController.text = image.name;
                                  bankAccountProofDocument = image;
                                  File selectedFile = File(image.path);
                                  uploadFile(image.name, selectedFile,
                                      ConstantUtil.bankAccountType);
                                });
                              }, false);
                            }
                          },
                          child: Text(
                            bankAccountProofDocument == null
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
              height: SizeUtil.verticalSpacingSmall(context),
            ),
            const WarningMessage(
                message: ConstantUtil.warningMessageToUploadImage),
            SizedBox(
              height: height * 0.35,
            )
          ],
        ),
      ),
    );
  }

  Widget kycDocumentVerification() {
    return SingleChildScrollView(
      child: Form(
          key: formKeys[4],
          child: Column(children: [
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     RichText(
            //       textScaleFactor: MediaQuery.of(context).textScaleFactor,
            //       textAlign: TextAlign.start,
            //       text: TextSpan(
            //         children: [
            //           TextSpan(
            //             text: 'Address with proof (address)',
            //             style: TextStyle(
            //                 fontSize: SizeUtil.body(context),
            //                 color: AppColors.grey,
            //                 fontFamily: "Helvetica"),
            //           ),
            //           TextSpan(
            //               text: "*",
            //               style: TextStyle(
            //                   fontSize: SizeUtil.body(context),
            //                   color: AppColors.red,
            //                   fontFamily: "Helvetica")),
            //         ],
            //       ),
            //     ),
            //     const SizedBox(height: 2),
            //     Padding(
            //       padding: const EdgeInsets.only(right: 40),
            //       child: Row(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         children: [
            //           Expanded(
            //             child: ClipRRect(
            //               borderRadius: BorderRadius.circular(5),
            //               child: TextFormField(
            //                 readOnly: true,
            //                 controller: addressProofDocumentController,
            //                 keyboardType: const TextInputType.numberWithOptions(
            //                     signed: true, decimal: true),
            //                 autovalidateMode:
            //                     AutovalidateMode.onUserInteraction,
            //                 decoration: InputDecoration(
            //                   counterText: "",
            //                   suffixIcon: Padding(
            //                     padding: const EdgeInsets.only(right: 5.0),
            //                     child: GestureDetector(
            //                       onTap: () {
            //                         setState(() {
            //                           addressProofDocumentController.clear();
            //                           addressProofDocument = null;
            //                         });
            //                       },
            //                       child: const Icon(Icons.clear,
            //                           size: 20, color: AppColors.primary),
            //                     ),
            //                   ),
            //                   suffixIconConstraints: const BoxConstraints(),
            //                   filled: true,
            //                   isDense: true,
            //                   border: InputBorder.none,
            //                   hintText: 'document.jpg',
            //                   hintStyle: TextStyle(
            //                       color: AppColors.grey,
            //                       fontFamily: "Helvetica",
            //                       fontSize: SizeUtil.body(context)),
            //                   fillColor: TextfieldColors.background,
            //                 ),
            //                 style: TextStyle(
            //                     fontSize: SizeUtil.body(context),
            //                     fontFamily: "Helvetica"),
            //                 onChanged: (value) {},
            //                 validator: (value) {
            //                   if (value!.isEmpty) {
            //                     return 'address proof is required';
            //                   }
            //                   return null;
            //                 },
            //               ),
            //             ),
            //           ),
            //           const SizedBox(width: 10),
            //           Padding(
            //             padding: const EdgeInsets.only(top: 8),
            //             child: GestureDetector(
            //               onTap: () {
            //                 if (addressProofDocument == null) {
            //                   mediaPicker(addressProofDocumentController,
            //                       (image) {
            //                     setState(() {
            //                       addressProofDocumentController.text =
            //                           image.name;
            //                       addressProofDocument = image;
            //                     });
            //                   }, false);
            //                 }
            //               },
            //               child: Text(
            //                 addressProofDocument == null
            //                     ? "Select a file"
            //                     : "Uploaded",
            //                 style: TextStyle(
            //                     color: AppColors.primary,
            //                     fontWeight: FontWeight.w400,
            //                     fontSize: SizeUtil.body(context),
            //                     fontFamily: "Helvetica"),
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
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
                                  File selectedFile = File(image.path);
                                  uploadFile(image.name, selectedFile,
                                      ConstantUtil.pancardType);
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
                                  File selectedFile = File(image.path);
                                  uploadFile(image.name, selectedFile,
                                      ConstantUtil.signDocType);
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
                                  File selectedFile = File(image.path);
                                  uploadFile(image.name, selectedFile,
                                      ConstantUtil.photoDocType);
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
            // SizedBox(
            //   height: SizeUtil.verticalSpacingMedium(context),
            // ),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     RichText(
            //       textScaleFactor: MediaQuery.of(context).textScaleFactor,
            //       textAlign: TextAlign.start,
            //       text: TextSpan(
            //         children: [
            //           TextSpan(
            //             text: 'Bank account details (bank_account)',
            //             style: TextStyle(
            //                 fontSize: SizeUtil.body(context),
            //                 color: AppColors.grey,
            //                 fontFamily: "Helvetica"),
            //           ),
            //           TextSpan(
            //               text: "*",
            //               style: TextStyle(
            //                   fontSize: SizeUtil.body(context),
            //                   color: AppColors.red,
            //                   fontFamily: "Helvetica")),
            //         ],
            //       ),
            //     ),
            //     const SizedBox(height: 2),
            //     Padding(
            //       padding: const EdgeInsets.only(right: 40),
            //       child: Row(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         children: [
            //           Expanded(
            //             child: ClipRRect(
            //               borderRadius: BorderRadius.circular(5),
            //               child: TextFormField(
            //                 readOnly: true,
            //                 controller: bankAccountDocumentController,
            //                 keyboardType: const TextInputType.numberWithOptions(
            //                     signed: true, decimal: true),
            //                 autovalidateMode:
            //                     AutovalidateMode.onUserInteraction,
            //                 decoration: InputDecoration(
            //                   counterText: "",
            //                   suffixIcon: Padding(
            //                     padding: const EdgeInsets.only(right: 5.0),
            //                     child: GestureDetector(
            //                       onTap: () {
            //                         setState(() {
            //                           bankAccountDocumentController.clear();
            //                           bankAccountDocument = null;
            //                         });
            //                       },
            //                       child: const Icon(Icons.clear,
            //                           size: 20, color: AppColors.primary),
            //                     ),
            //                   ),
            //                   suffixIconConstraints: const BoxConstraints(),
            //                   filled: true,
            //                   isDense: true,
            //                   border: InputBorder.none,
            //                   hintText: 'document.jpg',
            //                   hintStyle: TextStyle(
            //                       color: AppColors.grey,
            //                       fontFamily: "Helvetica",
            //                       fontSize: SizeUtil.body(context)),
            //                   fillColor: TextfieldColors.background,
            //                 ),
            //                 style: TextStyle(
            //                     fontSize: SizeUtil.body(context),
            //                     fontFamily: "Helvetica"),
            //                 onChanged: (value) {},
            //                 validator: (value) {
            //                   if (value!.isEmpty) {
            //                     return 'pan card copy is required';
            //                   }
            //                   return null;
            //                 },
            //               ),
            //             ),
            //           ),
            //           const SizedBox(width: 10),
            //           Padding(
            //             padding: const EdgeInsets.only(top: 8),
            //             child: GestureDetector(
            //               onTap: () {
            //                 if (bankAccountDocument == null) {
            //                   mediaPicker(bankAccountDocumentController,
            //                       (image) {
            //                     setState(() {
            //                       bankAccountDocumentController.text =
            //                           image.name;
            //                       bankAccountDocument = image;
            //                     });
            //                   }, false);
            //                 }
            //               },
            //               child: Text(
            //                 bankAccountDocument == null
            //                     ? "Select a file"
            //                     : "Uploaded",
            //                 style: TextStyle(
            //                     color: AppColors.primary,
            //                     fontWeight: FontWeight.w400,
            //                     fontSize: SizeUtil.body(context),
            //                     fontFamily: "Helvetica"),
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
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
                                  File selectedFile = File(video.path);
                                  uploadFile(video.name, selectedFile,
                                      ConstantUtil.ipvVedioType);
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
                message: ConstantUtil.warningMessageToUploadMultipleImages),
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
        return kycBasicInformationForm();
      case 2:
        return kycPersonalInformationForm();
      case 3:
        return kycAddressDetailsForm();
      case 4:
        return kycBankDetailsForm();
      case 5:
        return kycDocumentVerification();
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
        return "Address Details";
      case 4:
        return "Bank Account Details";
      case 5:
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
      if (photo != null) {
        final imageFile = File(photo.path);
        final fileSize = await imageFile.length();
        const maxSize = 5 * 1024 * 1024;
        if (fileSize <= maxSize) {
          return XFile(photo.path);
        } else {
          showErrorAlert("please select a file less than 5 mb");
          Get.back();
        }
      }
      // return photo != null ? XFile(photo.path) : null;
      return null;
    } catch (error) {
      debugPrint(error.toString());
      return null;
    }
  }

  Future<XFile?> pickVideo(ImageSource imageType) async {
    try {
      final video = await ImagePicker().pickVideo(source: imageType);
      if (video != null) {
        final imageFile = File(video.path);
        final fileSize = await imageFile.length();
        const maxSize = 10 * 1024 * 1024;
        if (fileSize <= maxSize) {
          return XFile(video.path);
        } else {
          showErrorAlert("please select a file less than 10 mb");
          Get.back();
        }
      }
      // return photo != null ? XFile(photo.path) : null;
      return null;
      // return photo != null ? XFile(photo.path) : null;
    } catch (error) {
      debugPrint(error.toString());
      return null;
    }
  }
}
