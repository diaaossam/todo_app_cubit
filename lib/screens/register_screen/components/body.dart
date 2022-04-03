import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
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
import '../cubit/register_cubit.dart';
import '../cubit/register_states.dart';

class Body extends StatelessWidget {
  var userEmail = TextEditingController();
  String? userPassword;
  String? conform_password;
  var formKey = GlobalKey<FormState>();

  void addError({required RegisterCubit cubit, String? error}) {
    if (!cubit.errors.contains(error)) cubit.setErrors(error!);
  }

  void removeError({required RegisterCubit cubit, String? error}) {
    if (cubit.errors.contains(error)) cubit.removeErrors(error!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        if (state is RegisterSuccessSignInState) {
          Navigator.pop(context);
          Navigator.pop(context);
        } else if (state is RegisterLoadingSignInState) {
          showCustomProgressIndicator(context);
        } else if (state is RegisterFailureSignInState) {
          Navigator.pop(context);
          print(state.error);
          showSnackBar(context, state.error);
        }
      },
      builder: (context, state) {
        RegisterCubit cubit = RegisterCubit.get(context);
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
                        text: "Register New Account",
                        isTitle: true,
                        color: Colors.black,
                        align: TextAlign.center,
                      ),
                      SizedBox(height: SizeConfig.bodyHeight * 0.03),
                      SvgPicture.asset(AssetsManger.REGISTER_PIC,
                        height: SizeConfig.bodyHeight * 0.25,
                      ),
                      SizedBox(height: SizeConfig.bodyHeight * 0.04),
                      CustomTextFormField(
                          controller: userEmail,
                          type: TextInputType.emailAddress,
                          onChange: (value) {
                            if (value.isNotEmpty) {
                              removeError(error: ConstantsManger.kEmailNullError, cubit: cubit);
                            } else if (ConstantsManger.emailValidatorRegExp.hasMatch(value)) {
                              removeError(
                                  cubit: cubit, error: ConstantsManger.kInvalidEmailError);
                            }
                            return null;
                          },
                          validate: (value) {
                            if (value!.isEmpty) {
                              addError(cubit: cubit, error:ConstantsManger.kEmailNullError);
                              return "";
                            } else if (!ConstantsManger.emailValidatorRegExp.hasMatch(value)) {
                              addError(cubit: cubit, error: ConstantsManger.kInvalidEmailError);
                              return "";
                            }
                            return null;
                          },
                          lableText: 'Email Address',
                          hintText: 'Please enter your email',
                          suffixIcon: 'assets/icons/Mail.svg'),
                      SizedBox(height: SizeConfig.bodyHeight * 0.03),
                      CustomTextFormField(
                        onSaved: (newValue) => userPassword = newValue,
                        isPassword: true,
                        onChange: (value) {
                          if (value.isNotEmpty) {
                            removeError(cubit: cubit, error: ConstantsManger.kPassNullError);
                          } else if (value.length >= 8) {
                            removeError(cubit: cubit, error: ConstantsManger.kShortPassError);
                          }
                          userPassword = value;
                        },
                        validate: (value) {
                          if (value!.isEmpty) {
                            addError(cubit: cubit, error: ConstantsManger.kPassNullError);
                            return "";
                          } else if (value.length < 8) {
                            addError(cubit: cubit, error:ConstantsManger.kShortPassError);
                            return "";
                          }
                          return null;
                        },
                        lableText: 'Password',
                        hintText: 'Please enter your password',
                        suffixIcon: 'assets/icons/Lock.svg',
                      ),
                      SizedBox(height: SizeConfig.bodyHeight * 0.03),
                      CustomTextFormField(
                        isPassword: true,
                        onSaved: (newValue) => conform_password = newValue,
                        onChange: (value) {
                          if (value.isNotEmpty) {
                            removeError(cubit: cubit, error: ConstantsManger.kPassNullError);
                          } else if (value.isNotEmpty &&
                              userPassword == conform_password) {
                            removeError(cubit: cubit, error:ConstantsManger. kMatchPassError);
                          }
                          conform_password = value;
                        },
                        validate: (value) {
                          if (value!.isEmpty) {
                            addError(cubit: cubit, error:ConstantsManger. kPassNullError);
                            return "";
                          } else if ((userPassword != value)) {
                            addError(cubit: cubit, error:ConstantsManger. kMatchPassError);
                            return "";
                          }
                          return null;
                        },
                        lableText: 'Confirm Password',
                        hintText: 'Re-enter your password',
                        suffixIcon: 'assets/icons/Lock.svg',
                      ),
                      SizedBox(height: SizeConfig.bodyHeight * 0.01),
                      FormError(errors: cubit.errors),
                      SizedBox(height: SizeConfig.bodyHeight * 0.03),
                      CustomButton(
                        text: 'Register',
                        press: () {
                          if (formKey.currentState!.validate()) {
                            cubit.regiterNewUser(
                                context: context,
                                email: userEmail.text,
                                password: userPassword ?? '');
                          }
                        },
                      ),
                      SizedBox(height: SizeConfig.bodyHeight * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(
                            text: 'Already have account ? ',
                            textSize: 18,
                            color: Colors.black,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: AppText(
                              color: ColorsManger.primaryColor,
                              text: 'Login Now ',
                              textSize: 20.0,
                              fontWeight: FontWeight.bold,
                              textDecoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
