import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_gym_app/common_widgets/common_widgets.dart';
import 'package:user_gym_app/controllers/authentication_controller.dart';
import 'package:user_gym_app/modules/diet/diet_detail_view.dart';
import 'package:user_gym_app/modules/gym/gym_detail_screen.dart';
import 'package:user_gym_app/modules/login/reset_password_view.dart';
import 'package:user_gym_app/modules/workout/workout_view.dart';
import 'package:user_gym_app/utility/colors_utility.dart';
import 'package:user_gym_app/utility/constants.dart';
import 'package:user_gym_app/utility/screen_size_utility.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  commonRoundedContainerForProfile({Widget? child, double? width}){
    return Container(
        width: width,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[100]!,
              blurRadius: 5.0,
              spreadRadius: 2.0,
            ),
          ]
        ),
        child: child
    );
  }

  Widget commonProfileView({String? title, subTitle}){
    return commonRoundedContainerForProfile(
      width: getScreenWidth(context) / 3 - 30,
      child: Column(
        children: [
          commonHeaderTitle(title: title,ourFontColor: secondaryPrimaryColor,fontWeight: 1,fontSize: 1.0),
          commonVerticalSpacing10(),
          commonHeaderTitle(title: subTitle,fontWeight: 0,fontSize: 0.9)
        ],
      ),
    );
  }

  Widget accountViewWidget({String? title,Function? onTap}){
    return InkWell(
      onTap: (){
        onTap!();
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            commonHeaderTitle(title: title),
            commonHorizontalSpacing7(),
            const Icon(Icons.arrow_forward_ios_rounded,color: primaryColor,size: 20,)
          ],
        ),
      ),
    );
  }

  resetPasswordView(){
    return commonDialogStructure(context,child: const ResetPasswordView());
  }

  @override
  Widget build(BuildContext context) {
    return commonStructure(context: context, child: Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 24.0),
      child: ListView(
        children: [
          Row(
            children: [
              Container(height: 90,width:90,decoration: const BoxDecoration(
                color: borderColor,
                shape: BoxShape.circle
              )),
              commonHorizontalSpacing7(width: 10),
              Expanded(child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonHeaderTitle(title: "Avinash Sharma",fontWeight: 2,ourFontColor: blackColor),
                  commonHeaderTitle(title: "Lose a Fat Program",fontWeight: 0,fontSize: 0.95)
                ],
              )),

              Container(padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 8),
                  decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: secondaryPrimaryColor
              ),child: commonHeaderTitle(title: "Edit",ourFontColor: whiteColor,fontSize: 0.9))
            ],
          ),
          commonVerticalSpacing10(height: 30),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              commonProfileView(title: "180cm",subTitle: "Height"),
              commonHorizontalSpacing7(width: 12),

              commonProfileView(title: "65kg",subTitle: "Weight"),
              commonHorizontalSpacing7(width: 12),

              commonProfileView(title: "22yr",subTitle: "Age"),
            ],
          ),
          commonVerticalSpacing10(height: 30),
          commonRoundedContainerForProfile(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                commonVerticalSpacing10(),
                commonHeaderTitle(title: "Account",fontSize: 1.5,fontWeight: 2,ourFontColor: blackColor),
                accountViewWidget(title: "My Gym",onTap: (){
                  Get.to(() => const GymDetailScreen());
                }),
                accountViewWidget(title: "My Workout",onTap: (){
                  Get.to(() => const WorkoutView());
                }),
                accountViewWidget(title: "My Diet",onTap: (){
                  Get.to(() => const DietDetailView());
                })
              ],
            )
          ),

          commonVerticalSpacing10(height: 30),
          commonRoundedContainerForProfile(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonVerticalSpacing10(),
                  commonHeaderTitle(title: "Other",fontSize: 1.5,fontWeight: 2,ourFontColor: blackColor),
                  accountViewWidget(title: "Contact Us",onTap: (){
                  }),
                  accountViewWidget(title: "Privacy Policy",onTap: (){
                  }),
                  accountViewWidget(title: "Reset Password",onTap: (){
                    resetPasswordView();
                  }),
                  accountViewWidget(title: "Logout",onTap: (){
                    confirmationAlertDialog(
                        title: logout.capitalizeFirst,
                        message: logOutMessage,
                        buttonCallBack: () {
                          AuthenticationController.to.logOutAPI();
                        });
                  }),
                  // accountViewWidget(title: "Settings")
                ],
              )
          ),
          commonVerticalSpacing10(height: 30),

        ],
      ),
    ));
  }

}
