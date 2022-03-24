import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:user_gym_app/common_widgets/common_widgets.dart';
import 'package:user_gym_app/utility/colors_utility.dart';
import 'package:user_gym_app/utility/screen_size_utility.dart';

class GymPackageListing extends StatefulWidget {
  const GymPackageListing({Key? key}) : super(key: key);

  @override
  _GymPackageListingState createState() => _GymPackageListingState();
}

class _GymPackageListingState extends State<GymPackageListing> {

  Widget gymPackageView({Color bgColor = whiteColor,
    Color lightBgColor = const Color(0xFFF5F5F5),
    Color fontColor = primaryColor,
    double bottomSizeBox = 25
  }){
    return Container(
      margin: EdgeInsets.only(bottom: bottomSizeBox),
      width: getScreenWidth(context),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              // spreadRadius: 3,
              blurRadius: 10,
              offset: const Offset(3,3), // changes position of shadow
            ),
          ],
          color: bgColor
      ),
      padding: EdgeInsets.all(10.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          commonVerticalSpacing10(),
          commonHeaderTitle(title: "Platinum Package",fontSize: 1.3, ourFontColor: fontColor,fontWeight: 2),
          commonVerticalSpacing10(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(flex: 2,child: Column(
                children: [
                  commonHeaderTitle(title: "8",ourFontColor: secondaryPrimaryColor,fontWeight: 3,fontSize: 2),
                  commonHeaderTitle(title: "MONTHS",ourFontColor: secondaryPrimaryColor,fontWeight: 1,fontSize: 1)
                ],
              )),
              Expanded(flex: 3,child: Column(
                children: [
                  commonHeaderTitle(title: "₹8000",ourFontColor: fontColor,fontWeight: 2,fontSize: 1.5),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: commonRoundBorderRadius,
                        color: lightBgColor,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      child: commonHeaderTitle(title: "Personal Training",align: TextAlign.center,fontSize: 0.8,ourFontColor: fontColor)
                  )
                ],
              )),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [Container(height: 40),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey[400]!)
                      ),
                      child: commonHeaderTitle(title: "MORE ->",ourFontColor: fontColor,fontWeight: 1,fontSize: 0.9),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return commonStructure(
      context: context,
      appBar: commonSearchAppBar(context: context, title: "Gym Packages",leadingWidget: InkWell(
        onTap: (){
          Get.back();
        },
        child: const Icon(Icons.arrow_back,color: primaryColor),
      )),
      child: ListView(
        shrinkWrap: true,
        children: [
        Padding(
          padding: const EdgeInsets.only(left: 12,right: 12,top: 12),
          child: gymPackageView(fontColor: whiteColor,bottomSizeBox: 8,bgColor: darkPurpleColor,lightBgColor: lightPrimaryColor),
        ),
        Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.only(left: 12,right: 12,top: 12),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return gymPackageView();
              }),
        )
        ],
      )
      //
    );
  }
}
