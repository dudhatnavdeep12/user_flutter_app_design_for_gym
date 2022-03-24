import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_gym_app/common_widgets/common_textfield.dart';
import 'package:user_gym_app/common_widgets/common_widgets.dart';
import 'package:user_gym_app/controllers/authentication_controller.dart';
import 'package:user_gym_app/utility/colors_utility.dart';
import 'package:user_gym_app/utility/common_methods.dart';
import 'package:user_gym_app/utility/constants.dart';

class ResetPasswordView extends StatefulWidget {

  const ResetPasswordView({Key? key,}) : super(key: key);

  @override
  _ResetPasswordViewState createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  String assignTo = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                commonVerticalSpacing10(height: 15),
                commonHeaderTitle(title: "Reset Password",fontWeight: 2,fontSize: 1.5,ourFontColor: blackColor),
                commonVerticalSpacing10(height: 15),
                CommonTextFiled(
                    fieldTitleText: "Password",
                    hintText: "Password",
                    isPassword: true,
                    isChangeFillColor: true,
                    isBorderEnable: false,
                    textEditingController: passwordController,
                    onChangedFunction: (String value){

                    },
                    validationFunction: (String value) {
                      return value.toString().isEmpty ? notEmptyFieldMessage : null;
                    }
                ),
                commonVerticalSpacing10(height: 15),
                CommonTextFiled(
                    fieldTitleText: "Confirm Password",
                    hintText: "Confirm Password",
                    isPassword: true,
                    isChangeFillColor: true,
                    isBorderEnable: false,
                    textEditingController: confirmPasswordController,
                    onChangedFunction: (String value){

                    },
                    validationFunction: (String value) {
                      if(value.isEmpty){
                        return notEmptyFieldMessage;
                      }else{
                        if(passwordController.text.isEmpty){
                          return notEmptyFieldMessage;
                        }else{
                          if(passwordController.text != value){
                            return passwordMatchingError;
                          }else {
                            return null;
                          }
                        }
                      }
                    }
                ),
                commonVerticalSpacing10(height: 65),
              ],
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: commonBorderButtonView(
                  context: context,
                  title: "Cancel",
                  isLoading: false,
                  tapOnButton: () async {
                    Get.back();
                  }),
            ),
            commonHorizontalSpacing7(width: 10),
            Expanded(
              child: commonFillButtonView(
                  context: context,
                  title: "Save",
                  isLoading: false,
                  tapOnButton: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      AuthenticationController.to.resetPassword({"password": passwordController.text},id: getLoginData()!.data?.id);
                    }
                  }),
            ),
          ],
        )
      ],
    );
  }
}//


