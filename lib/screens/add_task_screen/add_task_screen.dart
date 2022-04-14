import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_cubit/components/app_text.dart';
import 'package:todo_app_cubit/components/custom_button.dart';
import 'package:todo_app_cubit/components/custom_text_form_field.dart';
import 'package:todo_app_cubit/models/note_model.dart';
import 'package:todo_app_cubit/screens/add_task_screen/components/toggle_button_design.dart';
import 'package:todo_app_cubit/screens/add_task_screen/cubit/add_task_cubit.dart';
import 'package:todo_app_cubit/shared/helper/constants.dart';
import 'package:todo_app_cubit/shared/helper/methods.dart';
import 'package:todo_app_cubit/shared/helper/size_config.dart';
import '../../shared/helper/keyboard.dart';
import 'components/custom_select_color.dart';
import 'components/drop_down_reminder_design.dart';

class AddTaskScreen extends StatelessWidget {
  var title = TextEditingController();
  var noteDesc = TextEditingController();
  var noteDate = TextEditingController();
  var startTime = TextEditingController();
  var endTime = TextEditingController();
  var reminderTime = TextEditingController();

  var formKey = GlobalKey<FormState>();

  //15/4/2022
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddTaskCubit>(
      create: (context) => AddTaskCubit(),
      child: BlocConsumer<AddTaskCubit, AddTaskState>(
        listener: (context, state) {
          if (state is UploadTaskToFireStoreSucess) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          AddTaskCubit cubit = AddTaskCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: AppText(
                text: 'Add Task',
                isTitle: true,
              ),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(getProportionateScreenHeight(15.0)),
                  child: Column(
                    children: [
                      CustomTextFormField(
                        controller: title,
                        lableText: "Task Title",
                        isPassword: false,
                        hintText: "Enter title of the task",
                        type: TextInputType.text,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Task title';
                          }
                        },
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(20.0),
                      ),
                      CustomTextFormField(
                        controller: noteDesc,
                        lableText: "Task Details",
                        isPassword: false,
                        hintText: "Enter Task Details",
                        type: TextInputType.text,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Task Task ';
                          }
                        },
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(20.0),
                      ),
                      CustomTextFormField(
                        controller: noteDate,
                        lableText: "Task Date",
                        hintText: "Enter Task Date",
                        type: TextInputType.datetime,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Task Date';
                          }
                        },
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2030, 12, 31),
                          ).then((value) => noteDate.text =
                              formatDate(value ?? DateTime.now()));
                        },
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(20.0),
                      ),
                      Row(
                        children: [
                          Container(
                            width: SizeConfig.screenWidth * 0.42,
                            child: CustomTextFormField(
                              lableText: 'Start Time',
                              hintText: 'n',
                              controller: startTime,
                              isPassword: false,
                              type: TextInputType.datetime,
                              onTap: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((value) {
                                  startTime.text = value!.format(context);
                                });
                              },
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter Note Start Time';
                                }
                              },
                            ),
                          ),
                          Spacer(),
                          Container(
                            width: SizeConfig.screenWidth * 0.42,
                            child: CustomTextFormField(
                              lableText: 'End Time',
                              hintText: 'n',
                              controller: endTime,
                              isPassword: false,
                              type: TextInputType.datetime,
                              onTap: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((value) {
                                  endTime.text = value!.format(context);
                                });
                              },
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter Note Start Time';
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(20.0),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenHeight(30.0)),
                        child: Row(
                          children: [
                            AppText(
                              text: 'Reminder In ',
                            ),
                            Spacer(),
                            DropDownReminderDesign(AddTaskCubit.get(context)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(20.0),
                      ),
                      CustomToggleButtonDesign(cubit),
                      SizedBox(
                        height: getProportionateScreenHeight(20.0),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenHeight(30.0)),
                        child: Row(
                          children: [
                            AppText(
                              text: 'Select Color ',
                            ),
                            Spacer(),
                            CustomSelectColorDesign(cubit),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(40.0),
                      ),
                      CustomButton(
                        press: () {
                          if (formKey.currentState!.validate()) {
                            if (cubit.storeList[0] == true &&
                                cubit.storeList[1] == false) // store local
                            {
                              cubit.insertIntoLocalDateBase(
                                  noteModel: NoteModel(
                                title: title.text,
                                noteDesc: noteDesc.text,
                                noteDate: noteDate.text,
                                startTime: startTime.text,
                                endTime: endTime.text,
                                remind: cubit.reminderValue,
                                color: cubit.defultSelectedColor,
                                status: 'new',
                              ));
                            } else {
                              cubit.uploadNoteToFireStore(NoteModel(
                                  title: title.text,
                                  noteDesc: noteDesc.text,
                                  noteDate: noteDate.text,
                                  startTime: startTime.text,
                                  endTime: endTime.text,
                                  status: ConstantsManger.InProgress,
                                  remind: cubit.reminderValue,
                                  color: cubit.defultSelectedColor));
                            }
                          }
                        },
                        text: 'Confirm',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
