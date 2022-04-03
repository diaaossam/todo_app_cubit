import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../components/app_text.dart';
import '../../../shared/helper/size_config.dart';
import '../../../shared/styles/colors.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    this.text,
    this.image,
  }) : super(key: key);
  final String? text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),
        AppText(text: "Task App Mangment",isTitle: true),
        Spacer(flex: 1,),
        AppText(text: text!,align: TextAlign.center,),
        Spacer(flex: 2),
        SvgPicture.asset(
          image!,
          height: getProportionateScreenHeight(265),
          width: getProportionateScreenWidth(235),
        ),
      ],
    );
  }
}
