part of 'splash_cubit.dart';

@immutable
abstract class SplashState {}

class SplashInitial extends SplashState {}
class SplashOnBoardingState extends SplashState {}
class SplashLoginState extends SplashState {}
class SplashMainState extends SplashState {}
class SplashCompleteState extends SplashState {}
