import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app_cubit/shared/helper/assets_manger.dart';
import 'package:todo_app_cubit/shared/styles/styles.dart';
import '../../../../shared/helper/constants.dart';
import '../../../../shared/helper/size_config.dart';
import '../../../components/custom_button.dart';
import '../../../components/form_error.dart';
import '../../../components/no_account_text.dart';
import '../../../shared/helper/methods.dart';
import '../cubit/forget_cubit.dart';


class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.bodyHeight * 0.04),
              Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(28),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Please enter your email and we will send \nyou a link to return to your account",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.bodyHeight * 0.1),
              ForgotPassForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPassForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  var email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetCubit(),
      child: BlocConsumer<ForgetCubit, ForgetState>(
        listener: (context, state) {

          if(state is SendResetEmailLoading){
            showCustomProgressIndicator(context);
          }
          else if(state is SendResetEmailError){
            Navigator.pop(context);
            String errorMsg = state.errorMsg;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(errorMsg),
              backgroundColor: Colors.black,
              duration: Duration(seconds: 5),
            ));
          }
          else if(state is SendResetEmailSuccess){
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Reset Eamil SentSuccessfully'),
              backgroundColor: Colors.black,
              duration: Duration(seconds: 5),
            ));
            Future.delayed(Duration(seconds: 1),(){
              Navigator.pop(context);
            });

          }
        },
        builder: (context, state) {
          ForgetCubit cubit = ForgetCubit.get(context);
          return Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    if (value.isNotEmpty &&
                        cubit.errors.contains(ConstantsManger.kEmailNullError)) {
                      cubit.removeError(error: ConstantsManger.kEmailNullError);
                    } else if (ConstantsManger.emailValidatorRegExp.hasMatch(value) &&
                        cubit.errors.contains(ConstantsManger.kInvalidEmailError)) {
                      cubit.removeError(error: ConstantsManger.kInvalidEmailError);
                    }
                    return null;
                  },
                  validator: (value) {
                    if (value!.isEmpty &&
                        !cubit.errors.contains(ConstantsManger.kEmailNullError)) {
                      cubit.setError(error: ConstantsManger.kEmailNullError);
                    } else if (!ConstantsManger.emailValidatorRegExp.hasMatch(value) &&
                        !cubit.errors.contains(ConstantsManger.kInvalidEmailError)) {
                      cubit.setError(error:ConstantsManger.kInvalidEmailError);
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: ThemeManger.outlineInputBorder(),
                    labelText: "Email",
                    hintText: "Enter your email",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon: SvgPicture.asset(AssetsManger.EMAIL_ICONS),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                FormError(errors: cubit.errors),
                SizedBox(height: SizeConfig.bodyHeight * 0.2),
                CustomButton(
                  text: "Continue",
                  press: () {
                    if (_formKey.currentState!.validate()) {
                      cubit.resetUserPassword(email: email.text);
                    }
                  },
                ),
                SizedBox(height: SizeConfig.bodyHeight * 0.1),
                NoAccountText(),
              ],
            ),
          );
        },
      ),
    );
  }
}
