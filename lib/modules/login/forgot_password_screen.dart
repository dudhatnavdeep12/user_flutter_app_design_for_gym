import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:user_gym_app/common_widgets/common_textfield.dart';
import 'package:user_gym_app/common_widgets/common_widgets.dart';
import 'package:user_gym_app/modules/login/login_screen.dart';
import 'package:user_gym_app/utility/asset_utility.dart';
import 'package:user_gym_app/utility/colors_utility.dart';
import 'package:user_gym_app/utility/constants.dart';
import 'package:user_gym_app/utility/screen_size_utility.dart';
import 'package:user_gym_app/utility/text_theme_utility.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget forgotPasswordView(){
    return ListView(
      shrinkWrap: true,
      children: [
        Image(image: appLogo,fit: BoxFit.cover,height: getScreenHeight(context) / 4,width: getScreenWidth(context) - 60),
        Text("Forgot Password",style: primary14PxBold.apply(color: whiteColor,fontSizeFactor: 2),textAlign: TextAlign.center,),
        commonVerticalSpacing10(height: 30.h),
        commonContainerWithShadow(context,child: Form(
          key: _formKey,
          child: Column(
            children: [
              commonVerticalSpacing10(height: 20.h),
              CommonTextFiled(
                  preFixIcon: const Icon(Icons.email_outlined,color: iconsColor),
                  fieldTitleText: "Enter Email",
                  hintText: "Enter Email",
                  textEditingController: emailTextController,
                  isBorderEnable: true,
                  validationFunction: (String value) {
                    return value.toString().isEmpty
                        ? notEmptyFieldMessage
                        : !GetUtils.isEmail(value)
                        ? enterValidEmail
                        : null;
                  }),
              commonVerticalSpacing10(height: 20.h),
              commonFillButtonView(
                  context: context,
                  title: submit,
                  isLoading: false,
                  tapOnButton: (){

                  })
            ],
          ),
        )),

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return commonStructure(
        context: context,
        bottomNavigation: Padding(
          padding: EdgeInsets.all(8.0.w),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(text: "Back to? ", style: darkGray14PxNormal.apply(color: iconsColor,fontSizeFactor: 1.1)),
                TextSpan(
                  text: login,
                  style: primary18PxW700.apply(decoration: TextDecoration.underline,fontSizeFactor: 0.9),
                  recognizer: TapGestureRecognizer()..onTap = () => Get.offAll(() => const LoginScreen()),
                ),
              ],
            ),
          ),
        ),
        child: getCommonViewForAuthentication(context, forgotPasswordView())
    );
  }
}
