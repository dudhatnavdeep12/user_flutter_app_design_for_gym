import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:user_gym_app/common_widgets/common_widgets.dart';
import 'package:user_gym_app/common_widgets/common_textfield.dart';
import 'package:user_gym_app/utility/asset_utility.dart';
import 'package:user_gym_app/utility/colors_utility.dart';
import 'package:user_gym_app/utility/constants.dart';
import 'package:user_gym_app/utility/screen_size_utility.dart';

class GymDetailScreen extends StatefulWidget {
  const GymDetailScreen({Key? key}) : super(key: key);

  @override
  _GymDetailScreenState createState() => _GymDetailScreenState();
}

class _GymDetailScreenState extends State<GymDetailScreen> {

  TextEditingController reviewController = TextEditingController();

  Widget gymDetailView({Color bgColor = darkPurpleColor,
    Color lightBgColor = const Color(0xFFF5F5F5),
    Color fontColor = primaryColor,
    double bottomSizeBox = 25
  }){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottomSizeBox),
          width: getScreenWidth(context),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 10,
                  offset: const Offset(3,3), // changes position of shadow
                ),
              ],
              color: bgColor
          ),
          padding: EdgeInsets.all(10.w),
          child: Row(
            children: [
              Expanded(
                flex: 1, child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(12.w),
                decoration: const BoxDecoration(
                    color: secondaryPrimaryColor,
                    shape: BoxShape.circle
                ),child: Image(image: defaultGymLogo,height: 70,width: 70,),
              )),
              commonHorizontalSpacing7(width: 10),
              Expanded(flex: 4,child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonHeaderTitle(title: "The Health Club",ourFontColor: whiteColor,fontWeight: 2),
                  commonVerticalSpacing10(height: 7),
                  commonHeaderTitle(title: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",align: TextAlign.left,ourFontColor: whiteColor,fontSize: 0.9),
                  commonVerticalSpacing10(height: 7),
                  SizedBox(
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RatingBar.builder(
                              initialRating: 3,
                              itemSize: 18,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: false,
                              ignoreGestures: true,
                              itemCount: 5,
                              unratedColor: whiteColor,
                              itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: secondaryPrimaryColor,
                              ),
                              onRatingUpdate: (rating) {

                              },
                            ),
                            commonHeaderTitle(title: "(345)",ourFontColor: hintTextColor,fontSize: 0.9)
                          ],
                        ),

                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: whiteColor)
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.location_on_outlined,size: 16,color: secondaryPrimaryColor,),
                              commonHorizontalSpacing7(),
                              commonHeaderTitle(title: "Get Direction",ourFontColor: whiteColor,fontWeight: 1,fontSize: 0.7),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
        commonVerticalSpacing10(),
        commonHeaderTitle(title: "Health Club Packages",ourFontColor: primaryColor,fontWeight: 2,fontSize: 1.2)

      ],
    );
  }

  addReview(){
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        backgroundColor: whiteColor,
        context: context,
        isScrollControlled: true,
        builder: (context) => Container(
            margin: const EdgeInsets.all(10.0),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              // padding: MediaQuery.of(context).viewInsets,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    commonVerticalSpacing10(),
                    commonHeaderTitle(title: "Please write your review \n about gym",ourFontColor: primaryColor,fontWeight: 2),
                    commonVerticalSpacing10(height: 20),

                    StatefulBuilder(builder: (context, setState) {
                      return RatingBar.builder(
                        initialRating: 0,
                        itemSize: 40,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star_border_outlined,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {

                        },
                      );
                    },),
                    commonVerticalSpacing10(),
                    Row(
                      children: [
                        commonHeaderTitle(title: "Review Images",align: TextAlign.start,ourFontColor: primaryColor,fontWeight: 2,fontSize: 1.3),
                      ],
                    ),
                    commonVerticalSpacing10(),
                    Row(
                      children: [
                        Expanded(child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.black12
                          ),
                          height: 100,
                        )),
                        commonHorizontalSpacing7(width: 10),
                        Expanded(child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.black12
                          ),height: 100,
                        )),
                        commonHorizontalSpacing7(width: 10),
                        Expanded(child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white54
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4.0),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: primaryColor
                                ),
                                  child: const Icon(Icons.camera_alt,color: whiteColor,size: 20,)),
                              commonVerticalSpacing10(height: 8),
                              commonHeaderTitle(title: "Add your photos",ourFontColor: primaryColor,fontSize: 0.65,fontWeight: 1)
                            ],
                          ),
                        ))
                      ],
                    ),

                    commonVerticalSpacing10(),
                    Row(
                      children: [
                        commonHeaderTitle(title: "Comments",align: TextAlign.start,ourFontColor: primaryColor,fontWeight: 2,fontSize: 1.3),
                      ],
                    ),
                    CommonTextFiled(
                      fieldTitleText: "Comment",
                      hintText: "Comment",
                      isBorderEnable: false,
                      maxLine: 3,
                      isChangeFillColor: true,
                      textEditingController: reviewController,
                      onChangedFunction: (String value){

                      },
                      validationFunction: (String value) {
                        return value.toString().isEmpty
                            ? notEmptyFieldMessage
                            : null;
                      },
                    ),

                    commonVerticalSpacing10(),
                    commonFillButtonView(
                        context: context,
                        title: submit,
                        isLoading: false,
                        tapOnButton: (){

                        })

                  ],
                ),
              ),
            )
        ));
  }

  @override
  Widget build(BuildContext context) {
    return commonStructure(
        context: context,
        appBar: commonSearchAppBar(context: context, title: "Gym Detail",leadingWidget: InkWell(
          onTap: (){
            Get.back();
          },
          child: const Icon(Icons.arrow_back,color: primaryColor),
        )),
        bottomNavigation: Padding(
          padding: const EdgeInsets.all(12.0),
          child: commonFillButtonView(
              context: context,
              title: "Add Review",
              isLoading: false,
              tapOnButton: (){
                addReview();
              }),
        ),
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16,right: 16,top: 16),
              child: gymDetailView(fontColor: whiteColor,
                  bottomSizeBox: 8,bgColor: darkPurpleColor,
                  lightBgColor: lightPrimaryColor),
            ),
            Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.only(left: 16,right: 16,top: 16),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 25),
                      padding: const EdgeInsets.all(12.0),
                      width: getScreenWidth(context),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 10,
                              offset: const Offset(3,3), // changes position of shadow
                            ),
                          ],
                          color: whiteColor
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(12.w),
                              decoration: const BoxDecoration(
                                  color: secondaryPrimaryColor,
                                  shape: BoxShape.circle
                              ),child: Image(image: defaultGymLogo,height: 30,width: 30),
                            ),
                          ),
                          
                          Expanded(flex: 4,child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              commonHeaderTitle(title: "Gold Package",ourFontColor: primaryColor,fontWeight: 2),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  commonHeaderTitle(title: "Rs:5000/m",ourFontColor: secondaryPrimaryColor,fontWeight: 1,fontSize: 0.9),
                                  InkWell(
                                    onTap: (){

                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          border: Border.all(color: primaryColor)
                                      ),
                                      child: commonHeaderTitle(title: "More",ourFontColor: primaryColor,fontWeight: 1,fontSize: 0.9),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ))
                        ],
                      ),
                    );
                  }),
            )
          ],
        )
    );
  }
}
