import 'package:midas/constant/colors.dart';
import 'package:flutter/material.dart';

class NumberStepper extends StatelessWidget {
  final double width;
  final double height;
  final totalSteps;
  final int curStep;
  final Color stepCompleteColor;
  final Color currentStepColor;
  final Color inactiveColor;
  final double lineWidth;
  NumberStepper({
    Key? key,
    required this.width,
    required this.height,
    required this.curStep,
    required this.stepCompleteColor,
    required this.totalSteps,
    required this.inactiveColor,
    required this.currentStepColor,
    required this.lineWidth,
  })  : assert(curStep > 0 == true && curStep <= totalSteps + 1),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _steps(),
    );
  }

  getCircleColor(i) {
    var color;
    if (i + 1 < curStep) {
      color = stepCompleteColor;
    } else if (i + 1 == curStep) {
      color = currentStepColor;
    } else {
      color = inactiveColor;
    }
    return color;
  }

  getBorderColor(i) {
    var color;
    if (i + 1 <= curStep) {
      color = stepCompleteColor;
    } else {
      color = inactiveColor;
    }
    return color;
  }

  getLineColor(i) {
    var color = curStep > i + 1 ? AppColors.primary : AppColors.grey;
    return color;
  }

  List<Widget> _steps() {
    var list = <Widget>[];
    for (int i = 0; i < totalSteps; i++) {
      //colors according to state

      var circleColor = getCircleColor(i);
      // var borderColor = getBorderColor(i);
      var lineColor = getLineColor(i);

      // step circles
      list.add(
        Container(
          width: height * 0.05,
          height: height * 0.05,
          child: getInnerElementOfNumberStepper(i),
          decoration: new BoxDecoration(
            color: circleColor,
            shape: BoxShape.circle,
            // borderRadius: new BorderRadius.all(new Radius.circular(25.0)),
            // border: new Border.all(
            //   color: borderColor,
            //   width: 1.0,
            // ),
          ),
        ),
      );

      //line between step circles
      if (i != totalSteps - 1) {
        list.add(
          Expanded(
            child: Container(
              height: lineWidth,
              color: lineColor,
            ),
          ),
        );
      }
    }

    return list;
  }

  Widget getInnerElementOfNumberStepper(index) {
    var textStyle = TextStyle(
      fontSize: height * 0.025,
      color: AppColors.white,
      fontWeight: FontWeight.w700,
      fontFamily: 'Roboto',
    );

    if (index + 1 < curStep) {
      return Icon(
        Icons.check,
        color: AppColors.white,
        size: height * 0.030,
      );
    } else {
      return Center(
        child: Text(
          '${index + 1}',
          style: curStep == index + 1
              ? textStyle
              : TextStyle(
                  color: AppColors.white,
                  fontSize: height * 0.025,
                  fontWeight: FontWeight.w700,
                ),
        ),
      );
    }
  }
}
