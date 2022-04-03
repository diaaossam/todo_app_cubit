import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_cubit/components/app_text.dart';
import 'package:todo_app_cubit/screens/login_screen/login_screen.dart';
import 'package:todo_app_cubit/shared/helper/constants.dart';
import '../../shared/helper/methods.dart';
import '../../shared/local/cache_helper.dart';
import '../../shared/styles/colors.dart';
import 'components/body.dart';
import 'cubit/on_boarding_cubit.dart';
import 'cubit/on_boarding_states.dart';

class OnBoardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => OnBoardingCubit(),
        child: BlocConsumer<OnBoardingCubit, OnBoardingStates>(
          listener: (context, state) {
            if (state is GoToSignIn) {
              //   navigateToAndFinish(context, SignInScreen());
            } else if (state is GoToHome) {
              //  navigateToAndFinish(context, MainLayout());
            }
          },
          builder: (context, state) {
            return Scaffold(
              body: Body(),
              appBar: AppBar(
                actions: [
                  TextButton(
                    onPressed: () {
                      submit(context);
                    },
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(end: 20.0),
                      child: AppText(text: 'Skip',color: ColorsManger.primaryColor),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }

  static void submit(BuildContext context) {
    CachedHelper.saveData(key: ConstantsManger.ON_BOARDING, value: true)
        .then((value) {
      if (value) {
        navigateToAndFinish(context, LoginScreen());
      }
    });
  }
}
