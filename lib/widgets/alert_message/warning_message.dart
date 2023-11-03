import 'package:flutter/material.dart';
import 'package:midas/constant/colors.dart';
import 'package:midas/constant/size_util.dart';

class WarningMessage extends StatelessWidget {
  final String message;
  const WarningMessage({super.key,required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.error_outline, size: SizeUtil.bodyLarge(context)),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Text(
            message,
            style: TextStyle(
                color: AppColors.grey,
                fontSize: SizeUtil.body(context),
                fontFamily: "Helvetica"),
          ),
        ),
      ],
    );
  }
}
