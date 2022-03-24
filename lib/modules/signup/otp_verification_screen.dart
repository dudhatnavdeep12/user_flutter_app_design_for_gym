import 'package:flutter/material.dart';
import 'package:user_gym_app/common_widgets/common_textfield.dart';
import 'package:user_gym_app/common_widgets/common_widgets.dart';
import 'package:user_gym_app/controllers/authentication_controller.dart';
import 'package:user_gym_app/utility/asset_utility.dart';
import 'package:user_gym_app/utility/colors_utility.dart';
import 'package:user_gym_app/utility/constants.dart';
import 'package:user_gym_app/utility/screen_size_utility.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String email;
  final Function callback;
  const OTPVerificationScreen({Key? key, required this.callback, required this.email}) : super(key: key);

  @override
  _OTPVerificationScreenState createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {

  TextEditingController otpController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return commonStructure(
      context: context,
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
                commonHeaderTitle(title: "Enter Verification Code",
                    fontWeight: 2,
                    fontSize: 1.4,ourFontColor: primaryColor),
                commonVerticalSpacing10(),
                commonHeaderTitle(title: 'Please type the verification code sent to \n ${widget.email}'),
                commonVerticalSpacing10(height: 20),
                CommonTextFiled(
                    fieldTitleText: "Enter OTP",
                    hintText: "Enter OTP",
                    isChangeFillColor: true,
                    isBorderEnable: false,
                    textEditingController: otpController,
                    onChangedFunction: (String value){
                    },
                    validationFunction: (String value) {
                      return value.toString().isEmpty ? notEmptyFieldMessage : null;
                    }
                ),
                // PinFieldAutoFill(
                //   controller: otpController,
                //   keyboardType: TextInputType.number,
                //   decoration: UnderlineDecoration(
                //     textStyle: const TextStyle(fontSize: 20, color: Colors.black),
                //     colorBuilder: FixedColorBuilder(Colors.black.withOpacity(0.3)),
                //   ),
                //   currentCode: otpController.text,
                //   onCodeSubmitted: (code) {},
                //   onCodeChanged: (code) {
                //     if (code!.length == 6) {
                //       FocusScope.of(context).requestFocus(FocusNode());
                //     }
                //   },
                // ),
                commonVerticalSpacing10(height: 30),
                InkWell(
                  onTap: (){
                    AuthenticationController.to.sendOTP({"email": widget.email});
                  },
                    child: commonHeaderTitle(title: "Don’t receive the OTP?",fontSize: 1.2,ourFontColor: titleColor)),
                commonVerticalSpacing10(height: 10),
                commonFillButtonView(
                    context: context,
                    title: verifyOTP,
                    isLoading: false,
                    tapOnButton: (){
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        widget.callback(otpController.text);
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
