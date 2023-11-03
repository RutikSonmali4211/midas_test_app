import 'package:get/get.dart';
import 'package:midas/Widgets/buttons/large_button.dart';
import 'package:midas/constant/colors.dart';
import 'package:midas/constant/size_util.dart';
import 'package:flutter/material.dart';
import 'package:midas/controller/contact_us/contact_us_controller.dart';
import 'package:midas/controller/dropdown_data/dropdown_controller.dart';
import 'package:midas/screen/profile/profile_and_setting.dart';
import 'package:midas/widgets/appbar/small_appbar.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  ContactUsController contactUsController = Get.put(ContactUsController());
  DropdownController dropdownController = Get.put(DropdownController());
  var height;
  var width;
  String _selectedValue = 'Raise an issue';
  Map<String, dynamic> contactCategoriesList = {
  };
  final FocusNode detailsFocusNode = FocusNode();
  TextEditingController detailsController = TextEditingController();
  GlobalKey<FormState> addDetailsFormKey = GlobalKey<FormState>();
  bool istoggle = true;

  @override
  void initState() {
    super.initState();
    getContactUsDropdownData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    height = size.height;

    width = size.width;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SmallAppbar(heading: "Contact us"),
          SizedBox(height: SizeUtil.verticalSpacingMedium(context)),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Form(
                        key: addDetailsFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              textScaleFactor:
                                  MediaQuery.of(context).textScaleFactor,
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Contact Category',
                                    style: TextStyle(
                                        fontSize: SizeUtil.body(context),
                                        color: AppColors.primary,
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
                            const SizedBox(height: 7),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color:
                                    Colors.grey[200], // Gray background color
                              ),
                              child: DropdownButton<String>(
                                hint: const Text("select an option"),
                                underline: const SizedBox(),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10),
                                value: _selectedValue,
                                onTap: () {
                                  getContactUsDropdownData();
                                },
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedValue = newValue!;
                                  });
                                },
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  size: SizeUtil.iconsSize(context),
                                  color: AppColors
                                      .primary,
                                ),
                                style: const TextStyle(
                                  color: AppColors.grey,
                                ),
                                items: contactCategoriesList.keys
                                    .map((String key) {
                                  return DropdownMenuItem<String>(
                                    value: key,
                                    child: Text(contactCategoriesList[key]!),
                                  );
                                }).toList(),
                                // items: <String>[
                                //   'Raise an issue',
                                //   'Provide feedback (or suggest an idea)'
                                // ]
                                //     .map<DropdownMenuItem<String>>(
                                //       (String value) =>
                                //           DropdownMenuItem<String>(
                                //         value: value,
                                //         child: Text(
                                //           value,
                                //           style: TextStyle(
                                //               fontSize:
                                //                   SizeUtil.body(context),
                                //               fontFamily: "Helvetica"),
                                //         ),
                                //       ),
                                //     )
                                //     .toList(),
                              ),
                            ),
                            const SizedBox(height: 20),
                            RichText(
                              textScaleFactor:
                                  MediaQuery.of(context).textScaleFactor,
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Details',
                                    style: TextStyle(
                                        fontSize: SizeUtil.body(context),
                                        color: AppColors.primary,
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
                            const SizedBox(height: 7),
                            Padding(
                              padding: const EdgeInsets.only(right: 40),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: TextFormField(
                                  controller: detailsController,
                                  focusNode: detailsFocusNode,
                                  onEditingComplete: () {
                                    detailsFocusNode.unfocus();
                                  },
                                  maxLines: 15,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    isDense: true,
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                        color: AppColors.grey,
                                        fontFamily: "Helvetica"),
                                    fillColor: TextfieldColors.background,
                                  ),
                                  style: const TextStyle(fontSize: 15),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Details is required';
                                    } else {
                                      if (value.length <= 1) {
                                        return 'please enter valid Details';
                                      }
                                    }
                                    return null;
                                  },
                                  textInputAction: TextInputAction.newline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.06),
                      child: LargeButton(
                          text: "Submit",
                          backgroundColor: AppColors.primary,
                          textColor: AppColors.white,
                          onPressed: () {
                            if (addDetailsFormKey.currentState!.validate()) {
                              addContactUsDetails();
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  getContactUsDropdownData() async {
   if(contactCategoriesList.isEmpty){
     Map<String,dynamic> data = await dropdownController.fetchDropdownData("contactUs", context);
    setState(() {
      print(data);
      _selectedValue=data.keys.first;
      contactCategoriesList = data;
    });
   }
  }

  addContactUsDetails() async {
    bool isSuccess = await contactUsController.addNewContactRequest(
        _selectedValue, detailsController.text.toString(), context);
    if (isSuccess) {
      // ignore: use_build_context_synchronously
      Navigator.maybePop(context,
          MaterialPageRoute(builder: (context) => const ProfileAndSettings()));
    }
  }
}
