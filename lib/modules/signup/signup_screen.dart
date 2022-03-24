import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:user_gym_app/common_widgets/common_widgets.dart';
import 'package:user_gym_app/common_widgets/common_textfield.dart';
import 'package:user_gym_app/controllers/authentication_controller.dart';
import 'package:user_gym_app/controllers/general_controller.dart';
import 'package:user_gym_app/utility/asset_utility.dart';
import 'package:user_gym_app/utility/colors_utility.dart';
import 'package:user_gym_app/utility/common_methods.dart';
import 'package:user_gym_app/utility/constants.dart';
import 'package:user_gym_app/utility/screen_size_utility.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController contactNoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return commonStructure(
      context: context,
      bottomNavigation: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            commonHeaderTitle(title: "If you have an account?",ourFontColor: titleColor,fontSize: 1.0),
            commonHeaderTitle(title: "Please SignIn",ourFontColor: primaryColor,fontWeight: 2,fontSize: 0.9)
          ],
        ),
      ),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 24),
          child: SingleChildScrollView(child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                commonVerticalSpacing10(height: 20),
                Image(image: appLogo,height: getScreenHeight(context)/6),
                commonVerticalSpacing10(height: 40),
                commonHeaderTitle(title: login,
                    fontWeight: 2,
                    fontSize: 1.4,ourFontColor: primaryColor),
                commonVerticalSpacing10(),
                CommonTextFiled(
                  fieldTitleText: "Name",
                  hintText: "Name",
                  isBorderEnable: false,
                  isChangeFillColor: true,
                  textEditingController: nameController,
                  onChangedFunction: (String value){

                  },
                  validationFunction: (String value) {
                    return value.toString().isEmpty
                        ? notEmptyFieldMessage
                        : null;
                  },
                ),
                CommonTextFiled(
                  fieldTitleText: "Email",
                  hintText: "Email",
                  isBorderEnable: false,
                  isChangeFillColor: true,
                  textEditingController: emailController,
                  onChangedFunction: (String value){

                  },
                  validationFunction: (String value) {
                    return value.toString().isEmpty
                        ? notEmptyFieldMessage
                        : !GetUtils.isEmail(value)
                        ? enterValidEmail
                        : null;
                  },
                ),
                CommonTextFiled(
                  fieldTitleText: "Contact No",
                  hintText: "Contact No",
                  isBorderEnable: false,
                  isChangeFillColor: true,
                  keyboardType: TextInputType.number,
                  inputFormatter: [
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  textEditingController: contactNoController,
                  onChangedFunction: (String value){

                  },
                  validationFunction: (String value) {
                    return value.toString().isEmpty
                        ? notEmptyFieldMessage
                        : null;
                  },
                ),
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

                commonFillButtonView(
                    context: context,
                    title: signup,
                    isLoading: false,
                    tapOnButton: (){
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        Map<String, dynamic> params = {
                          "email_id": emailController.text,
                          "name": nameController.text,
                          "contact_no": contactNoController.text,
                          "password": passwordController.text
                        };
                        GeneralController.to.isLoading.value = true;
                        AuthenticationController.to.signupUser(params);
                      }else{
                        showSnackBar(title: "Something went wrong", message: "Please recheck your details");
                      }
                    }),
                commonVerticalSpacing10(),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
