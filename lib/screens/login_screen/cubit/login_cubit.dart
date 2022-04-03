import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_cubit/shared/helper/constants.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(SignInInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isPasswordVisible = false;

  void changePasswordVisibaltySignIn() {
    isPasswordVisible = !isPasswordVisible;
    emit(ChangePasswordVisibilty());
  }

  final List<String?> errors = [];

  void setErrors(String error) {
    errors.add(error);
    print(errors.length);
    emit(SetErrorsLoginState());
  }

  void removeErrors(String error) {
    errors.remove(error);
    print(errors.length);
    emit(RemoveErrorsLoginState());
  }

  Future signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(SignInLoadingState());
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      FirebaseFirestore.instance
          .collection(ConstantsManger.USERS)
          .doc(value.user!.uid)
          .get()
          .then((value) {
            if(value.exists){
              emit(SignInSuccessStateAndGoToMain());
            }else{
              emit(SignInSuccessStateAndGoToComplete());
            }
      });
    }).catchError((error) {
      emit(SignInFailuerState(error.toString()));
    });
  }
}
