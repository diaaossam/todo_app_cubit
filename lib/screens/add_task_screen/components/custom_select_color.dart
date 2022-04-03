import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app_cubit/screens/add_task_screen/cubit/add_task_cubit.dart';
import 'package:todo_app_cubit/shared/helper/constants.dart';
import 'package:todo_app_cubit/shared/styles/colors.dart';

import '../../../shared/helper/size_config.dart';

class CustomSelectColorDesign extends StatelessWidget {
  AddTaskCubit _cubit;

  CustomSelectColorDesign(this._cubit);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            _cubit.setUpSelectedColor(ConstantsManger.COLORS_RED);
          },
          child: CircleAvatar(
            backgroundColor: ColorsManger.NoteColorsRed,
            radius: getProportionateScreenHeight(25.0),
            child: _cubit.defultSelectedColor == ConstantsManger.COLORS_RED
                ? SvgPicture.asset(
              'assets/icons/choose_icon.svg',
              color: Colors.white,
              width: getProportionateScreenHeight(25.0),
              height: getProportionateScreenHeight(25.0),
            ) : Center(),
          ),
        ),
        SizedBox(
          width: getProportionateScreenHeight(10.0),
        ),
        InkWell(
          onTap: () {
            _cubit.setUpSelectedColor(ConstantsManger.COLORS_BLUE);
          },
          child: CircleAvatar(
            backgroundColor: ColorsManger.NoteColorsBlue,
            radius: getProportionateScreenHeight(25.0),
            child: _cubit.defultSelectedColor == ConstantsManger.COLORS_BLUE
                ? SvgPicture.asset(
              'assets/icons/choose_icon.svg',
              color: Colors.white,
              width: getProportionateScreenHeight(25.0),
              height: getProportionateScreenHeight(25.0),
            ) : Center(),
          ),
        ),
        SizedBox(
          width: getProportionateScreenHeight(10.0),
        ),
        InkWell(
          onTap: () {
            _cubit.setUpSelectedColor(ConstantsManger.COLORS_YELLOW);
          },
          child: CircleAvatar(
            backgroundColor: ColorsManger.NoteColorsYellow,
            radius: getProportionateScreenHeight(25.0),
            child: _cubit.defultSelectedColor == ConstantsManger.COLORS_YELLOW
                ? SvgPicture.asset(
              'assets/icons/choose_icon.svg',
              color: Colors.white,
              width: getProportionateScreenHeight(25.0),
              height: getProportionateScreenHeight(25.0),
            ) : Center(),
          ),
        ),
      ],
    );
  }
}
