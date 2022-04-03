import 'package:flutter/material.dart';
import 'package:todo_app_cubit/components/app_text.dart';
import 'package:todo_app_cubit/shared/styles/colors.dart';

import '../shared/helper/size_config.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    this.text,
    this.press,
    this.width
  }) : super(key: key);
  final String? text;
  final Function? press;
  final double ? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ==null ? double.infinity : getProportionateScreenHeight(width!),
      height: getProportionateScreenHeight(60),
      decoration: BoxDecoration(
        color: ColorsManger.primaryColor,
        borderRadius: BorderRadius.circular(getProportionateScreenHeight(20.0))
      ),
      child:MaterialButton( 
        onPressed:press as void Function(),
        child: AppText(
          color: Colors.white,
          text: text!,
          textSize: getProportionateScreenHeight(20.0),
        ) ,
      ),
    );
  }
}
