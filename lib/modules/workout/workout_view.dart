import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_gym_app/common_widgets/common_widgets.dart';
import 'package:user_gym_app/common_widgets/common_textfield.dart';
import 'package:user_gym_app/modules/workout/timerView.dart';
import 'package:user_gym_app/utility/colors_utility.dart';
import 'package:user_gym_app/utility/constants.dart';

class WorkoutView extends StatefulWidget {
  const WorkoutView({Key? key}) : super(key: key);

  @override
  _WorkoutViewState createState() => _WorkoutViewState();
}

class _WorkoutViewState extends State<WorkoutView> {

  Widget exerciseView(){
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(flex:2,child: Container(height: 80,width: 80,decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: borderColor
          ))),
          commonHorizontalSpacing7(),
          Expanded(flex:6,child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            textBaseline: TextBaseline.ideographic,
            children: [
              commonHeaderTitle(title: "Warm Up",ourFontColor: primaryColor,fontWeight: 1,fontSize: 1.0),
              commonHeaderTitle(title: "3set - 12 reps  :  14 mints",ourFontColor: Colors.grey,fontWeight: 1,fontSize: 1.0),
            ],
          )),
          commonHorizontalSpacing7(),
          Expanded(flex:1,child: InkWell(
            onTap: (){
              markAsDonePopup();
            },
            child: Container(height: 24,width: 24,decoration: BoxDecoration(
              border: Border.all(color: hintTextColor),
              shape: BoxShape.circle
            ),child: const Icon(Icons.keyboard_arrow_right_outlined,color: hintTextColor)),
          )),
        ],
      ),
    );
  }

  markAsDonePopup(){
    return commonDialogStructure(context,child: Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          commonHeaderTitle(title: "Squats Done",fontSize: 1.3, ourFontColor: primaryColor,fontWeight: 3),
          commonVerticalSpacing10(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.timer,color: titleColor),
              commonHorizontalSpacing7(),
              commonHeaderTitle(title: "15 Minutes",fontSize: 1.1, ourFontColor: titleColor,fontWeight: 1),
            ],
          ),
          commonVerticalSpacing10(height: 18),
          CommonTextFiled(
            fieldTitleText: "Enter Repetition",
            hintText: "Enter Repetition",
            isBorderEnable: false,
            isChangeFillColor: true,
            textEditingController: TextEditingController(),
            onChangedFunction: (String value){

            },
            validationFunction: (String value) {
              return value.toString().isEmpty
                  ? notEmptyFieldMessage
                  : null;
            },
          ),
          CommonTextFiled(
            fieldTitleText: "Enter Sets",
            hintText: "Enter Sets",
            isBorderEnable: false,
            isChangeFillColor: true,
            textEditingController: TextEditingController(),
            onChangedFunction: (String value){

            },
            validationFunction: (String value) {
              return value.toString().isEmpty
                  ? notEmptyFieldMessage
                  : null;
            },
          ),

          commonFillButtonView(
              context: context,
              title: "Mark As Done",
              isLoading: false,
              tapOnButton: (){
                Get.back();
              }),
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return commonStructure(
        context: context,
        appBar: commonSearchAppBar(context: context, elevation: 0.0,title: "Gym Packages",leadingWidget: InkWell(
          onTap: (){
            Get.back();
          },
          child: const Icon(Icons.arrow_back,color: primaryColor),
        )),
        bottomNavigation: Padding(
          padding: const EdgeInsets.all(12.0),
          child: commonFillButtonView(
              context: context,
              title: "Start Workout".toUpperCase(),
              isLoading: false,
              tapOnButton: (){
                Get.to(() => const CountDownTimer());
              }),
        ),
        child: ListView(
          shrinkWrap: true,
          children: [
            commonVerticalSpacing10(),
            daySelectionView(selectedDate: DateTime.now()),

            commonVerticalSpacing10(height: 30),
            commonHeaderTitle(title: "Tuesday you need to do 4 exercises",ourFontColor: primaryColor,fontWeight: 2,fontSize: 1.3),
            commonVerticalSpacing10(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                return exerciseView();
              },),
            )

          ],
        )
    );
  }
}
