import 'package:flutter/material.dart';
import 'package:todo_app_cubit/screens/settings_screen/cubit/settings_screen_cubit.dart';
class SettingsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container();
  }

 /* ImageProvider setImage(SettingsScreenCubit cubit) {
    if (cubit.userModel!.image == 'DEFULT') {
      return AssetImage('assets/images/user.png');
    } else {
      if (cubit.profileImage != null) {
        return FileImage(cubit.profileImage ?? File(''));
      } else {
        return NetworkImage(cubit.userModel!.image ?? '');
      }
    }
  }*/
}
