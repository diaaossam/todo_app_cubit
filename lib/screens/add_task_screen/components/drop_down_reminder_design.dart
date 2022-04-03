import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_cubit/components/app_text.dart';
import 'package:todo_app_cubit/models/reminder_model.dart';
import 'package:todo_app_cubit/screens/add_task_screen/cubit/add_task_cubit.dart';
import 'package:todo_app_cubit/shared/helper/size_config.dart';

class DropDownReminderDesign extends StatelessWidget {
  AddTaskCubit _cubit;

  DropDownReminderDesign(this._cubit);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(getProportionateScreenHeight(7.0)),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(getProportionateScreenHeight(15.0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          hint: AppText(text: 'Select Item', color: Colors.grey),
          items: _cubit.reminderList
              .map((item) => DropdownMenuItem<String>(
                    value: item.time,
                    child: AppText(text: item.time, textSize: 22.0),
                  ))
              .toList(),
          value: _cubit.reminderValue,
          onChanged: (value) {
            _cubit.changeReminderState("${value.toString()}");
          },
          buttonHeight: getProportionateScreenHeight(50.0),
          buttonWidth: getProportionateScreenHeight(180),
          itemHeight: getProportionateScreenHeight(50.0),
        ),
      ),
    );
  }
}
