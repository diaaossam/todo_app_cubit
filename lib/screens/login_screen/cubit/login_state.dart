
abstract class LoginStates {}

class SignInInitial extends LoginStates {}
class ChangePasswordVisibilty extends LoginStates {}
class SetErrorsLoginState extends LoginStates {}
class RemoveErrorsLoginState extends LoginStates {}


class SignInLoadingState extends LoginStates {}
class SignInSuccessStateAndGoToMain extends LoginStates {}
class SignInSuccessStateAndGoToComplete extends LoginStates {}


class SignInFailuerState extends LoginStates {
  String error;
  SignInFailuerState(this.error);
}
