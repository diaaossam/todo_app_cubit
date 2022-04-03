import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_cubit/components/app_text.dart';
import 'package:todo_app_cubit/components/custom_button.dart';
import 'package:todo_app_cubit/screens/add_task_screen/add_task_screen.dart';
import 'package:todo_app_cubit/screens/main_screen/componets/custom_date_picker.dart';
import 'package:todo_app_cubit/screens/main_screen/cubit/main_cubit.dart';
import 'package:todo_app_cubit/shared/helper/assets_manger.dart';
import 'package:todo_app_cubit/shared/helper/constants.dart';
import 'package:todo_app_cubit/shared/helper/methods.dart';
import 'package:todo_app_cubit/shared/helper/size_config.dart';
import 'package:todo_app_cubit/shared/styles/colors.dart';

import '../settings_screen/settings_screen.dart';
import 'componets/today_tasks.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainCubit>(
      create: (context) => MainCubit()..getUserInfo(),
      child: BlocConsumer<MainCubit, MainState>(
        listener: (context, state) {},
        builder: (context, state) {
          MainCubit cubit = MainCubit.get(context);
          return state is GetUserLoading
              ? const Scaffold(
                  body: Center(child: CupertinoActivityIndicator()),
                )
              : Scaffold(
                  appBar: AppBar(
                    leading: Padding(
                      padding:
                          EdgeInsets.all(getProportionateScreenHeight(13.0)),
                      child: CircleAvatar(
                        backgroundColor: ColorsManger.primaryColorLight,
                        backgroundImage:
                            cubit.userModel.image == ConstantsManger.DEFULT
                                ? AssetImage(AssetsManger.DEFULT_IMAGE)
                                : NetworkImage(cubit.userModel.image ?? '')
                                    as ImageProvider,
                      ),
                    ),
                    title: AppText(
                      text:
                          "${cubit.userModel.firstName} ${cubit.userModel.lastName}",
                    ),
                    actions: [
                      IconButton(
                          onPressed: () {
                            navigateTo(context, SettingsScreen());
                          },
                          icon: Icon(CupertinoIcons.settings))
                    ],
                  ),
                  body: Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.all(getProportionateScreenHeight(15.0)),
                        child: Row(
                          children: [
                            AppText(
                              text: formatDate(DateTime.now()),
                              isTitle: true,
                              fontWeight: FontWeight.bold,
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: CustomButton(
                                  width: getProportionateScreenHeight(50),
                                  text: 'Add Task',
                                  press: () {
                                    navigateTo(context, AddTaskScreen());
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomDatePicker(),
                      SetupTodayTasks( cubit: cubit,),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
