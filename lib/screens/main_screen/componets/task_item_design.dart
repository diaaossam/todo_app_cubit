import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_cubit/components/app_text.dart';
import 'package:todo_app_cubit/models/menu_item.dart';
import 'package:todo_app_cubit/models/note_model.dart';
import 'package:todo_app_cubit/screens/main_screen/cubit/main_cubit.dart';
import 'package:todo_app_cubit/shared/helper/constants.dart';
import 'package:todo_app_cubit/shared/helper/size_config.dart';
import 'package:todo_app_cubit/shared/styles/colors.dart';

class TaskItemDesign extends StatelessWidget {
  NoteModel noteModel;
  MainCubit cubit;

  TaskItemDesign({required this.noteModel, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(15.0)),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenHeight(15.0)),
        width: double.infinity,
        height: getProportionateScreenHeight(175.0),
        decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(getProportionateScreenHeight(10.0)),
            color: setUpColor(
              noteModel.color,
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Center(
                  child: AppText(
                    text: '${noteModel.title}',
                    isTitle: true,
                    textSize: 22,
                    color: Colors.white,
                  ),
                ),
                Spacer(),
                PopupMenuButton(
                    icon: Icon(CupertinoIcons.ellipsis_vertical,
                        color: Colors.white),
                    itemBuilder: (contet) {
                      return [
                        PopupMenuItem(
                            onTap: () {},
                            child: setUpColoumItem(
                                MenuItem(icon: Icons.delete, title: 'Delete'))),
                        PopupMenuItem(
                            child: setUpColoumItem(
                                MenuItem(icon: Icons.update, title: 'Update'))),
                      ];
                    })
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(7.0),
            ),
            Container(
                color: Colors.grey,
                width: double.infinity,
                height: getProportionateScreenHeight(1)),
            SizedBox(
              height: getProportionateScreenHeight(7.0),
            ),
            Center(
              child: AppText(
                text: '${noteModel.noteDesc}',
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(10.0),
            ),
            Row(
              children: [
                AppText(
                  textSize: 18.0,
                  text: 'Start Time : ${noteModel.startTime}',
                  color: Colors.white,
                ),
                Spacer(),
                AppText(
                  textSize: 18.0,
                  text: 'End Time : ${noteModel.endTime}',
                  color: Colors.white,
                )
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(10.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  textSize: 18.0,
                  text: 'Status : ${noteModel.status}',
                  color: Colors.white,
                ),
                SizedBox(
                  width: getProportionateScreenHeight(10.0),
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Icon(
                    setupIcon('${noteModel.status}'),
                    color: Colors.red,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color setUpColor(String? color) {
    if (color == ConstantsManger.COLORS_RED) {
      return ColorsManger.NoteColorsRed;
    } else if (color == ConstantsManger.COLORS_BLUE) {
      return ColorsManger.NoteColorsBlue;
    } else {
      return ColorsManger.NoteColorsYellow;
    }
  }

  IconData setupIcon(String status) {
    if (status == ConstantsManger.Cancel) {
      return Icons.cancel;
    } else if (status == ConstantsManger.InProgress) {
      return Icons.watch_outlined;
    } else {
      return Icons.check;
    }
  }

  Widget setUpColoumItem(MenuItem menuItem) {
    return Row(
      children: [
        Icon(menuItem.icon, color: ColorsManger.primaryColor),
        SizedBox(width: getProportionateScreenHeight(10)),
        AppText(
          text: menuItem.title,
          color: ColorsManger.primaryColor,
        )
      ],
    );
  }
}
