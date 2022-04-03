import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app_cubit/shared/helper/constants.dart';
import 'package:todo_app_cubit/shared/local/cache_helper.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  static SplashCubit get(BuildContext context) => BlocProvider.of(context);

  void checkUserState() {
    Future.delayed(
      Duration(seconds: 3),
      () {
        bool onBoarding =
            CachedHelper.getBooleon(key: ConstantsManger.ON_BOARDING) ?? false;
        if (onBoarding) {
          FirebaseAuth.instance.authStateChanges().listen((user) {
            if (user == null) {
              emit(SplashLoginState());
            } else {
              FirebaseFirestore.instance
                  .collection(ConstantsManger.USERS)
                  .doc(user.uid)
                  .get()
                  .then((value) {
                if (value.exists) {
                  emit(SplashMainState());
                } else {
                  emit(SplashCompleteState());
                }
              });
            }
          });
        } else {
          emit(SplashOnBoardingState());
        }
      },
    );
  }
}
