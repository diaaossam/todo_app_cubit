import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_cubit/shared/helper/size_config.dart';

class CustomDatePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.bodyHeight * 0.11,
      child: DatePicker(
        DateTime.now(),
        width: getProportionateScreenHeight(50),
        initialSelectedDate: DateTime.now(),
        dateTextStyle: Theme.of(context)
            .textTheme
            .headline1!
            .copyWith(fontSize: getProportionateScreenHeight(25.0)),
        dayTextStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
              fontSize: getProportionateScreenHeight(12.0),
            ),
        monthTextStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
              fontSize: getProportionateScreenHeight(12.0),
            ),
        selectionColor: Colors.deepPurple,
        onDateChange: (DateTime newdate) {
          /* setState(() {
            currentdate = newdate;
          });*/
        },
      ),
    );
  }
}
