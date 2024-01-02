import 'package:midas/Widgets/buttons/small_button.dart';
import 'package:midas/constant/colors.dart';
import 'package:midas/constant/date_util.dart';
import 'package:midas/constant/size_util.dart';
import 'package:flutter/material.dart';

class PauseSIPDialogBox extends StatelessWidget {
  final String heading;
  final String body;
  final String message;
  final TextEditingController startDateController;
  final TextEditingController endDateController;
  final GlobalKey<FormState> formKey;
  final VoidCallback onConfirm;

  const PauseSIPDialogBox(
      {super.key,
      required this.heading,
      required this.body,
      required this.message,
      required this.onConfirm,
      required this.startDateController,
      required this.endDateController,
      required this.formKey});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
      insetPadding: const EdgeInsets.all(10),
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (heading.isNotEmpty)
              Text(
                heading,
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: SizeUtil.headingLarge2(context),
                  fontWeight: FontWeight.w700,
                  fontFamily: "Helvetica",
                ),
              ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.050),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    body,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.primary,
                        fontSize: SizeUtil.headingMedium(context),
                        fontFamily: "Helvetica"),
                  ),
                  if (message.isNotEmpty) const SizedBox(height: 30),
                  if (message.isNotEmpty)
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: SizeUtil.bodyLarge(context),
                        fontFamily: "Helvetica",
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Form(
              key: formKey,
              child: Column(
                children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: RichText(
                        textScaleFactor: MediaQuery.of(context).textScaleFactor,
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: 'Start Date',
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
                    ),
                    const SizedBox(height: 2),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            readOnly: true,
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: GestureDetector(
                                  child: const Icon(Icons.calendar_month,
                                      size: 30, color: AppColors.primary),
                                ),
                              ),
                              suffixIconConstraints: const BoxConstraints(),
                              filled: true,
                              isDense: true,
                              border: InputBorder.none,
                              hintText: 'e.g., 01/Jun/2021',
                              hintStyle: const TextStyle(
                                  color: AppColors.grey, fontFamily: "Helvetica"),
                              fillColor: TextfieldColors.background,
                            ),
                            style: TextStyle(
                              fontSize: SizeUtil.body(context),
                            ),
                            controller: startDateController,
                            onEditingComplete: () {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'start date is required';
                              } else {
                                return null;
                              }
                            },
                            onTap: () async {
                              startDateController.text =
                                  await DateUtil.showDatePickerFromCurrentDate(
                                      context);
                            }),
                      ),
                    )
                  ]),
                  const SizedBox(height: 20),
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: RichText(
                        textScaleFactor: MediaQuery.of(context).textScaleFactor,
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: 'End Date',
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
                    ),
                    const SizedBox(height: 2),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          readOnly: true,
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: GestureDetector(
                                child: const Icon(Icons.calendar_month,
                                    size: 30, color: AppColors.primary),
                              ),
                            ),
                            suffixIconConstraints: const BoxConstraints(),
                            filled: true,
                            isDense: true,
                            border: InputBorder.none,
                            hintText: 'e.g., 01/Jun/2021',
                            hintStyle: const TextStyle(
                                color: AppColors.grey, fontFamily: "Helvetica"),
                            fillColor: TextfieldColors.background,
                          ),
                          style: TextStyle(
                            fontSize: SizeUtil.body(context),
                          ),
                          controller: endDateController,
                          onEditingComplete: () {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'end date is required';
                            } else {
                              return null;
                            }
                          },
                          onTap: () async {
                            endDateController.text =
                                await DateUtil.showDatePickerFromFifteenDaysLater(
                                    context);
                          },
                        ),
                      ),
                    )
                  ]),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SmallButton(
                    text: "Cancel",
                    onPressed: () {
                      startDateController.clear();
                      endDateController.clear();
                      Navigator.pop(context);
                    },
                    backgroundColor: AppColors.white,
                    textColor: AppColors.primary),
                SmallButton(
                    text: "Confirm",
                    onPressed: onConfirm,
                    backgroundColor: AppColors.primary,
                    textColor: AppColors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
