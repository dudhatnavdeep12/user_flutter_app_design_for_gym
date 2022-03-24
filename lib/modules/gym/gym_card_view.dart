import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:user_gym_app/common_widgets/common_widgets.dart';
import 'package:user_gym_app/modules/gym_package/gym_package_listing.dart';
import 'package:user_gym_app/utility/asset_utility.dart';
import 'package:user_gym_app/utility/colors_utility.dart';
import 'package:user_gym_app/utility/screen_size_utility.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class GymCardView extends StatefulWidget {
  final Function tapOnCallback;
  const GymCardView({Key? key, required this.tapOnCallback}) : super(key: key);

  @override
  _GymCardViewState createState() => _GymCardViewState();
}

class _GymCardViewState extends State<GymCardView> {


  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: <Widget>[
        InkWell(
          onTap: (){
            widget.tapOnCallback();
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 70,left: 5,right: 5),
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
                color: whiteColor
            ),
            padding: EdgeInsets.all(10.w),
            child: Column(
              children: [
                commonVerticalSpacing10(height: 70),
                commonHeaderTitle(title: "The Health Club",fontSize: 1.1, ourFontColor: primaryColor,fontWeight: 3),
                commonHeaderTitle(title: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",fontSize: 0.8),
                commonVerticalSpacing10(height: 6),
                SizedBox(
                  height: 35,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RatingBar.builder(
                        initialRating: 3,
                        itemSize: 22,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {

                        },
                      ),

                      commonHeaderTitle(title: "(345)",ourFontColor: hintTextColor,fontSize: 1)
                    ],
                  ),
                ),
                commonVerticalSpacing10(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
                        Get.to(() => const GymPackageListing());
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: primaryColor)
                        ),
                        child: commonHeaderTitle(title: "View All Packages",ourFontColor: primaryColor,fontWeight: 2,fontSize: 0.9),
                      ),
                    ),
                    const Icon(Icons.location_on_outlined,color: secondaryPrimaryColor,size: 26)
                  ],
                )
              ],
            ),
          ),
        ),
        Positioned(
            top: -50,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(12.w),
              decoration: const BoxDecoration(
                  color: secondaryPrimaryColor,
                  shape: BoxShape.circle
              ),child: Image(image: defaultGymLogo,height: 80,width: 80,),
            )
        )
      ],
    );
  }
}
