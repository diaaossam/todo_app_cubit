import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_cubit/screens/register_screen/cubit/register_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(InitialRegisterStates());

  static RegisterCubit get(context) => BlocProvider.of(context);

  final List<String?> errors = [];

  void setErrors(String error) {
    errors.add(error);
    print(errors.length);
    emit(SetErrorsRegisterState());
  }

  void removeErrors(String error) {
    errors.remove(error);
    print(errors.length);
    emit(RemoveErrorsRegisterState());
  }

  void regiterNewUser(
      {required context,
      required String email,
      required String password}) async {
    emit(RegisterLoadingSignInState());
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(RegisterSuccessSignInState());
    }).catchError((error) {
      emit(RegisterFailureSignInState(error.toString()));
    });
  }
}
