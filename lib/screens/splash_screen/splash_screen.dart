import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app_cubit/components/app_text.dart';
import 'package:todo_app_cubit/components/custom_button.dart';
import 'package:todo_app_cubit/screens/complete_profile/complete_profile_screen.dart';
import 'package:todo_app_cubit/screens/login_screen/login_screen.dart';
import 'package:todo_app_cubit/screens/on_boarding_screen/on_boarding_screen.dart';
import 'package:todo_app_cubit/screens/splash_screen/cubit/splash_cubit.dart';
import 'package:todo_app_cubit/shared/helper/assets_manger.dart';
import 'package:todo_app_cubit/shared/helper/methods.dart';
import 'package:todo_app_cubit/shared/helper/size_config.dart';

import '../main_screen/main_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider<SplashCubit>(
      create: (context) => SplashCubit()..checkUserState(),
      child: BlocConsumer<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashCompleteState)
          {
            navigateToAndFinish(context, CompleteProfileScreen());
          }
          if (state is SplashOnBoardingState)
          {
            navigateToAndFinish(context, OnBoardingScreen());
          }
          if (state is SplashMainState)
          {
            navigateToAndFinish(context, MainScreen());
          }
          if (state is SplashLoginState)
          {
            navigateToAndFinish(context, LoginScreen());
          }
        },
        builder: (context, state) {
          return Scaffold(
              body: SafeArea(
            child: SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: SizeConfig.bodyHeight * 0.2),
                    BounceInDown(
                      duration: const Duration(seconds: 3),
                      child: Container(
                          height: SizeConfig.bodyHeight * 0.3,
                          width: SizeConfig.bodyHeight * 0.3,
                          child: SvgPicture.asset(AssetsManger.SPLASH_SCREEN)),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.bodyHeight * 0.2),
                      child: CircularProgressIndicator(),
                    ),
                  ],
                ),
              ),
            ),
          ));
        },
      ),
    );
  }
}
