import 'package:flutter/material.dart';
import 'package:todo_app_cubit/screens/add_task_screen/cubit/add_task_cubit.dart';

import '../../../components/app_text.dart';
import '../../../shared/helper/size_config.dart';
class CustomToggleButtonDesign extends StatelessWidget {

  AddTaskCubit _cubit;

  CustomToggleButtonDesign(this._cubit);

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      children: <Widget>[
        Padding(
          padding:  EdgeInsets.all(getProportionateScreenHeight(20.0)),
          child: Row(
            children: [
              AppText(text: 'Local'),
              SizedBox(
                height: getProportionateScreenHeight(10.0),
              ),
              Icon(Icons.store),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(getProportionateScreenHeight(20.0)),
          child: Row(
            children: [
              AppText(text: 'Cloud'),
              SizedBox(
                height: getProportionateScreenHeight(10.0),
              ),
              Icon(Icons.cloud),
            ],
          ),
        ),
      ],
      onPressed: (int index) {
        _cubit.changeToggleState(index);
      },
      isSelected: _cubit.storeList,
    );
  }
}
