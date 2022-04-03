part of 'main_cubit.dart';

@immutable
abstract class MainState {}

class MainInitial extends MainState {}
class GetUserLoading extends MainState {}
class GetUserSucess extends MainState {}
class GetUserFailed extends MainState {
  String errorMsg;

  GetUserFailed(this.errorMsg);
}
