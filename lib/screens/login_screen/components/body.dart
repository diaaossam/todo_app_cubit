import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app_cubit/screens/complete_profile/complete_profile_screen.dart';
import 'package:todo_app_cubit/shared/helper/assets_manger.dart';
import 'package:todo_app_cubit/shared/helper/constants.dart';
import 'package:todo_app_cubit/shared/styles/colors.dart';
import '../../../components/app_text.dart';
import '../../../components/background.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_text_form_field.dart';
import '../../../components/form_error.dart';
import '../../../shared/helper/methods.dart';
import '../../../shared/helper/size_config.dart';
import '../../forgot_password/forgot_password_screen.dart';
import '../../main_screen/main_screen.dart';
import '../../register_screen/register_screen.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';

class Body extends StatelessWidget {
  var email = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var password = TextEditingController();

  void addError({required LoginCubit cubit, String? error}) {
    if (!cubit.errors.contains(error)) cubit.setErrors(error!);
  }

  void removeError({required LoginCubit cubit, String? error}) {
    if (cubit.errors.contains(error)) cubit.removeErrors(error!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is SignInLoadingState) {
            showCustomProgressIndicator(context);
          } else if (state is SignInFailuerState) {
            Navigator.pop(context);
            showSnackBar(context, state.error);
          } else if (state is SignInSuccessStateAndGoToMain) {
            Navigator.pop(context);
            navigateToAndFinish(context, MainScreen());
          } else if (state is SignInSuccessStateAndGoToComplete) {
            Navigator.pop(context);
            navigateToAndFinish(context, CompleteProfileScreen());
          }
        },
        builder: (context, state) {
          LoginCubit cubit = LoginCubit.get(context);
          return SafeArea(
            child: Background(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenHeight(20.0)),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: SizeConfig.bodyHeight * 0.06),
                        AppText(
                          text:
                              "Sign in with your email and password  \nor continue with social media",
                          textSize: 22,
                          align: TextAlign.center,
                        ),
                        SizedBox(height: SizeConfig.bodyHeight * 0.02),
                        SvgPicture.asset(
                          AssetsManger.LOGIN_PIC,
                          height: SizeConfig.bodyHeight * 0.25,
                        ),
                        SizedBox(height: SizeConfig.bodyHeight * 0.02),
                        CustomTextFormField(
                            controller: email,
                            isPassword: false,
                            onChange: (s) {
                              if (s.isNotEmpty) {
                                removeError(
                                    error: ConstantsManger.kEmailNullError,
                                    cubit: cubit);
                              } else if (ConstantsManger.emailValidatorRegExp
                                  .hasMatch(s)) {
                                removeError(
                                    error: ConstantsManger.kInvalidEmailError,
                                    cubit: cubit);
                              }
                              return null;
                            },
                            validate: (value) {
                              if (value!.isEmpty) {
                                addError(
                                    error: ConstantsManger.kEmailNullError,
                                    cubit: cubit);
                                return "";
                              } else if (!ConstantsManger.emailValidatorRegExp
                                  .hasMatch(value)) {
                                addError(
                                    error: ConstantsManger.kInvalidEmailError,
                                    cubit: cubit);
                                return "";
                              }
                              return null;
                            },
                            lableText: 'Email Address',
                            hintText: 'Please enter your email',
                            suffixIcon: AssetsManger.EMAIL_ICONS),
                        SizedBox(height: SizeConfig.bodyHeight * 0.03),
                        CustomTextFormField(
                          controller: password,
                          isPassword: !cubit.isPasswordVisible,
                          onChange: (value) {
                            if (value.isNotEmpty) {
                              removeError(
                                  error: ConstantsManger.kPassNullError,
                                  cubit: cubit);
                            } else if (value.length >= 8) {
                              removeError(
                                  error: ConstantsManger.kShortPassError,
                                  cubit: cubit);
                            }
                            return null;
                          },
                          validate: (value) {
                            if (value!.isEmpty) {
                              addError(
                                  error: ConstantsManger.kPassNullError,
                                  cubit: cubit);
                              return "";
                            } else if (value.length < 8) {
                              addError(
                                  cubit: cubit,
                                  error: ConstantsManger.kShortPassError);
                              return "";
                            }
                            return null;
                          },
                          lableText: 'Password',
                          hintText: 'Please enter your password',
                          suffixIcon: 'assets/icons/Lock.svg',
                        ),
                        SizedBox(height: SizeConfig.bodyHeight * 0.01),
                        FormError(errors: cubit.errors),
                        Row(
                          children: [
                            Checkbox(
                              value: cubit.isPasswordVisible,
                              activeColor: ColorsManger.primaryColor,
                              onChanged: (value) {
                                cubit.changePasswordVisibaltySignIn();
                              },
                            ),
                            AppText(
                                text: 'Show Password',
                                color: Colors.black,
                                textSize: 17.0),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                navigateTo(context, ForgotPasswordScreen());
                              },
                              child: AppText(
                                text: 'Forgot Password',
                                color: Colors.black,
                                textSize: 17.0,
                                textDecoration: TextDecoration.underline,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: SizeConfig.bodyHeight * 0.03),
                        CustomButton(
                          text: 'Login',
                          press: () {
                            if (formKey.currentState!.validate()) {
                              cubit.signInWithEmailAndPassword(
                                  email: email.text, password: password.text);
                            }
                          },
                        ),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppText(
                              text: 'Don’t have an account? ',
                              textSize: 18,
                              color: Colors.black,
                            ),
                            GestureDetector(
                              onTap: () {
                                navigateTo(context, RegisterScreen());
                              },
                              child: AppText(
                                color: ColorsManger.primaryColor,
                                text: 'Register Now',
                                textSize: 20.0,
                                fontWeight: FontWeight.bold,
                                textDecoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
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
