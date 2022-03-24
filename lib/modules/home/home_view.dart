import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_gym_app/common_widgets/common_widgets.dart';
import 'package:user_gym_app/common_widgets/common_textfield.dart';
import 'package:user_gym_app/controllers/general_controller.dart';
import 'package:user_gym_app/modules/gym/gym_card_view.dart';
import 'package:user_gym_app/modules/gym/gym_detail_screen.dart';
import 'package:user_gym_app/utility/colors_utility.dart';
import 'package:user_gym_app/utility/constants.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  void initState() {
    var now = DateTime.now();
    var startFrom = now.subtract(Duration(days: now.weekday));
    GeneralController.to.listOfWeekDays.addAll(List.generate(7, (i) => '${startFrom.add(Duration(days: i)).day}'));
    super.initState();
  }

  addWeightGain(){
    return commonDialogStructure(context,child: Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          commonHeaderTitle(title: "Add Your Weight",fontSize: 1.3, ourFontColor: primaryColor,fontWeight: 3),
          commonVerticalSpacing10(height: 16),

          CommonTextFiled(
            fieldTitleText: "Enter your weight",
            hintText: "Enter your weight",
            isBorderEnable: false,
            isChangeFillColor: true,
            textEditingController: TextEditingController(),
            onChangedFunction: (String value){},
            validationFunction: (String value) {
              return value.toString().isEmpty
                  ? notEmptyFieldMessage
                  : null;
            },
          ),

          commonVerticalSpacing10(height: 16),
          commonFillButtonView(
              context: context,
              title: submit,
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            commonVerticalSpacing10(height: 20),
            commonHeaderTitle(title: "Find Your",fontSize: 1.2, fontWeight: 1),
            commonHeaderTitle(title: "Workout Class",fontSize: 1.3, ourFontColor: primaryColor,fontWeight: 3),
            commonVerticalSpacing10(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonHeaderTitle(title: "Activity",fontSize: 1.2, fontWeight: 1),
                InkWell(
                  onTap: (){
                    addWeightGain();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: commonBorderRadius
                    ),
                    child: const Icon(Icons.add,size: 26,color: primaryColor,),
                  ),
                ),
              ],
            ),

            commonVerticalSpacing10(),
            Container(
              color: Colors.grey[100],
              height: 200,
            ),

            commonVerticalSpacing10(),
            Container(
              color: Colors.grey[100],
              height: 200,
            ),

            commonVerticalSpacing10(height: 20),
            commonHeaderTitle(title: "Gym Timing",fontSize: 1.2, fontWeight: 1,ourFontColor: primaryColor),
            commonVerticalSpacing10(),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: lightPrimaryColor.withOpacity(0.2),
                  borderRadius: commonBorderRadius
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today_rounded,size: 26,),
                  commonHorizontalSpacing7(width: 15),
                  Expanded(child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      commonHeaderTitle(title: "Schedule Workout",ourFontColor: primaryColor,fontWeight: 1),
                      commonHeaderTitle(title: "2 hrs left to go gym")
                    ],
                  )),
                  commonHorizontalSpacing7(width: 15),
                  commonHeaderTitle(title: "Morning, 09:00 AM",fontSize: 0.8)
                ],
              ),
            ),
            commonVerticalSpacing10(height: 70),
            GymCardView(tapOnCallback: (){
              Get.to(() => const GymDetailScreen());
            }),
            GymCardView(tapOnCallback: (){
              Get.to(() => const GymDetailScreen());
            }),
            GymCardView(tapOnCallback: (){
              Get.to(() => const GymDetailScreen());
            })
          ],
        ),
      ),
    );
  }
}
