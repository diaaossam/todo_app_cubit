import 'package:flutter/material.dart';
import 'package:todo_app_cubit/shared/styles/colors.dart';

import '../screens/register_screen/register_screen.dart';
import '../shared/helper/methods.dart';
import '../shared/helper/size_config.dart';



class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don’t have an account? ",
          style: TextStyle(fontSize: getProportionateScreenWidth(16)),
        ),
        GestureDetector(
          onTap: (){
            navigateTo(context, RegisterScreen());
          },
          child: Text(
            "Sign Up",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(16),
                color: ColorsManger.primaryColor),
          ),
        ),
      ],
    );
  }
}
