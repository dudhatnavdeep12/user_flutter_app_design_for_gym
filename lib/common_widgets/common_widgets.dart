import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:user_gym_app/controllers/general_controller.dart';
import 'package:user_gym_app/utility/colors_utility.dart';
import 'package:user_gym_app/utility/common_methods.dart';
import 'package:user_gym_app/utility/constants.dart';
import 'package:user_gym_app/utility/screen_size_utility.dart';
import 'package:user_gym_app/utility/text_theme_utility.dart';

import 'common_textfield.dart';

double commonHorizontalPadding = 10.0.w;
const double imageHeight = 80.0;
BorderRadius commonButtonBorderRadius = BorderRadius.circular(5.0.r);
BorderRadius commonBorderRadius = BorderRadius.circular(8.0.r);
BorderRadius commonRoundBorderRadius = BorderRadius.circular(20.r);
double commonPadding = 16.0.w;
double commonMargin = 16.0.w;

BoxShadow commonBoxShadow = BoxShadow(
  color: Colors.grey.withOpacity(0.1),
  spreadRadius: 5,
  blurRadius: 7,
  offset: const Offset(0, 3), // changes position of shadow
);

SizedBox commonVerticalSpacing10({double height = 10.0}) {
  return SizedBox(height: height.h);
}

Widget commonProfileView({required imageUrl,required String name,required String designation,required String date,required String time,}) {
  return Container(
    padding: EdgeInsets.all(8.w),
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: commonBorderRadius),
    child: Container(
      child: ListTile(
          leading: CircleAvatar(backgroundImage: AssetImage(imageUrl)),
          title: Text(name),
          subtitle: Text(designation,style: TextStyle(color: Colors.grey.shade800)),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(date,style: const TextStyle(),),
              Text(time),
            ],)
      ),
      decoration: BoxDecoration(
          color: Colors.grey.shade100, borderRadius: commonBorderRadius),),
  );
}

SizedBox commonHorizontalSpacing7({double width = 5.0}) {
  return SizedBox(width: width.w);
}

PreferredSize commonSearchAppBar(
    {BuildContext? context, Widget? leadingWidget, String? title, Widget? actionIcon,double elevation = 2.0}) {
  return PreferredSize(
      preferredSize: const Size.fromHeight(56.0),
      child: AppBar(
        backgroundColor: whiteColor,
        leading: leadingWidget,
        elevation: elevation,
        centerTitle: true,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            title!,
            textAlign: TextAlign.center,
            style: primary12PxNormal.apply(fontSizeFactor: 1.5),
          ),
        ),
        actions: [actionIcon ?? Container()],
      )
  );
}

Widget userImageOrInitials({double margin = 0.0}){
  return Container(
    margin: EdgeInsets.only(top: margin),
    height: 75,width: 75,decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: secondaryPrimaryColor.withOpacity(0.2)
  ),child:
  Text("UH",
    style: primary16PxW700.apply(fontSizeFactor: 1.6),textAlign: TextAlign.center,),
    alignment: Alignment.center,);
}

Widget commonDateViewForList({String title = '',double frontViewHeight = imageHeight}){
  return Container(
      height: frontViewHeight.h,
      width: frontViewHeight.w,
      decoration: BoxDecoration(
        color: primaryFontColor.withOpacity(0.10),
        borderRadius: BorderRadius.all(Radius.circular(16.r)),
      ),
      child: Center(
        child: commonHeaderTitle(title: title,ourFontColor: secondaryPrimaryColor,fontSize: 1.2,fontWeight: 3),
      )
  );
}

commonDialogStructure(BuildContext context,{Widget? child}){
  return Get.dialog(
    Dialog(
        insetPadding: const EdgeInsets.all(16.0),
        // clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: getScreenWidth(context),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: whiteColor
              ),
              padding: EdgeInsets.all(10.w),
              child: child,
            ),
            Positioned(
                top: -30,right: 0,
                child: Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: const BoxDecoration(
                      color: secondaryPrimaryColor,
                      shape: BoxShape.circle
                  ),child: const Icon(Icons.close,color: whiteColor),
                )
            )
          ],
        )
    ),
    useSafeArea: true,
    barrierDismissible: true,
    transitionCurve: Curves.easeInCubic,
    transitionDuration: const Duration(milliseconds: 400),
  );
}

Widget commonFillButtonView({required BuildContext context,
  required String title,
  required Function tapOnButton,
  required bool isLoading,
  bool isLightButton = false,
  Color? color,
  Color? fontColor,
  double? height = 50.0,
  double? width}) {
  return SizedBox(
    width: width ?? getScreenWidth(context),
    height: height!.h,
    child: ElevatedButton(
        onPressed: () {
          if (!isLoading) {
            tapOnButton();
          }
        },
        style: ElevatedButton.styleFrom(
          primary: secondaryPrimaryColor,
          shape: RoundedRectangleBorder(borderRadius: commonRoundBorderRadius),
          padding: EdgeInsets.symmetric(vertical: height == 50.0 ? 10.w : 2.w),
          elevation: 0.0,
        ),
        child: isLoading
            ?
        SizedBox(
          height: 20.h,
          child: const SpinKitThreeBounce(
              color: whiteColor,
              size: 30.0
          ),
        )
            : Text(
          title.toUpperCase(),
          style: primary16PxW700.copyWith(
              color: whiteColor,
              fontWeight: FontWeight.w500,
              fontSize: height >= 50.0 ? 16.sp : 12.sp),
        )

    ),
  );
}

Widget commonBorderButtonView(
    {required BuildContext context,
      required String title,
      required Function tapOnButton,
      required bool isLoading,
      Color? color,
      double height = 50.0,
      IconData? iconData}) {
  return SizedBox(
    width: MediaQuery.of(context).size.width - (commonHorizontalPadding * 2),
    height: height.h,
    child:
    ElevatedButton(
      onPressed: () {
        if (!isLoading) {
          tapOnButton();
        }
      },
      style: ElevatedButton.styleFrom(
        alignment: Alignment.center,
        primary: bgColor,
        side: const BorderSide(
          color: primaryColor,
          width: 1.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: commonRoundBorderRadius,
        ),
        padding: EdgeInsets.symmetric(vertical: height == 50.0 ? 10.w : 2.w),
        elevation: 0.0,
      ),
      child: isLoading
          ? SizedBox(
        height: 20.h,
        child: SpinKitThreeBounce(
          color: primaryColor,
          size: 30.0.sh,
        ),
      )
          : Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title.toUpperCase(),
            style: primary16PxW700.copyWith(
                color: primaryColor,
                fontWeight: FontWeight.w500,
                fontSize: height >= 50.0 ? 16.sp : 12.sp),
          ),
          iconData != null ? commonHorizontalSpacing7() : const SizedBox(),
          iconData != null
              ? Obx(() {
            return Icon(
              iconData,
              size: 20.sh,
              color: primaryColor,
            );
          })
              : const SizedBox(),
        ],
      ),
    ),
  );
}

Widget commonTextFiledWithTitle({
  required String fieldTitleText,
  required String hintText,
  bool isPassword = false,
  bool isRequired = true,
  required TextEditingController textEditingController,
  Function? validationFunction,
  int? maxLength,
  Function? onSavedFunction,
  Function? onFieldSubmit,
  TextInputType? keyboardType,
  TextInputAction inputAction = TextInputAction.next,
  Function? onTapFunction,
  Function? onChangedFunction,
  Function? onEditingComplete,
  List<TextInputFormatter>? inputFormatter,
  bool isEnabled = true,
  bool isChangeFillColor = false,
  // bool isReadOnly = false,
  int? errorMaxLines,
  int? maxLine,
  FocusNode? textFocusNode,
  // String? initialText = "",
  GlobalKey<FormFieldState>? key,
  Widget? suffixIcon,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      textTitleWithColon(fieldTitleText, isRequiredField: isRequired),
      commonVerticalSpacing10(height: 8.h),
      CommonTextFiled(
        fieldTitleText: fieldTitleText,
        hintText: hintText,
        isPassword: isPassword,
        textEditingController: textEditingController,
        validationFunction: validationFunction,
        onSavedFunction: onSavedFunction,
        onFieldSubmit: onFieldSubmit,
        isChangeFillColor: isChangeFillColor,
        // isReadOnly: isReadOnly,
        keyboardType: keyboardType,
        onTapFunction: onTapFunction,
        onChangedFunction: onChangedFunction,
        inputFormatter: inputFormatter,
        maxLine: maxLine,
        isEnabled: isEnabled,
        errorMaxLines: errorMaxLines,
        textFocusNode: textFocusNode,
        suffixIcon: suffixIcon,
      ),
    ],
  );
}

textTitleWithColon(String text, {bool isRequiredField = false,TextAlign align = TextAlign.left}) {
  return Text(
    text,
    style: primary16PxW700.copyWith(color: blackColor, fontSize: 14.sp,fontWeight: FontWeight.w500),maxLines: 2,textAlign: align,
  );
}

Widget backArrowWithTitle(BuildContext context,
    {String? title, Function? backCallBack}) {
  return Column(
    children: [
      Row(
        children: [
          InkWell(
              onTap: () {
                backCallBack!();
              },
              child: Icon(Icons.arrow_back_ios, size: 24.sh, color: whiteColor,)),
        ],
      ),
      commonVerticalSpacing10(height: 10.h),
      Text(title!, style: primary14PxBold.apply(color: whiteColor,
          fontSizeFactor: 1.5.sp),
        textAlign: TextAlign.center,),
    ],
  );
}

Widget commonContainerWithShadow(BuildContext context,
    {double margin = 8, Widget? child}) {
  return Container(
    margin: EdgeInsets.only(bottom: 8.sh),
    padding: EdgeInsets.all(
        8.w),
    decoration: BoxDecoration(
      color: whiteColor,
      borderRadius: commonBorderRadius,
      boxShadow: [commonBoxShadow],
    ),
    child: child,
  );
}

confirmationAlertDialog(
    {String? title, required String message, Function? buttonCallBack, Function? noButtonCallBack}) {
  Get.dialog(
    CupertinoAlertDialog(
      title: Text(
        isNotEmptyString(title) ? title! : appName.capitalize!,
        // style: primary18PxW700,
      ),
      content: Text(
        message,
        // style: black14PxNormal,
      ),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          child: const Text("No"),
          onPressed: () {
            Get.back();
            if (noButtonCallBack != null) {
              noButtonCallBack();
            }
          },
        ),
        CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text("Yes"),
            onPressed: () {
              buttonCallBack!();
            }),
      ],
    ),
    barrierDismissible: false,
    transitionCurve: Curves.easeInCubic,
    transitionDuration: const Duration(milliseconds: 400),
  );
  // }
}

Widget getCommonViewForAuthentication(BuildContext context, Widget child) {
  return Stack(
    children: [
      Container(
        height: getScreenHeight(context) / 2,
        width: getScreenWidth(context),
        decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16.r),
                bottomRight: Radius.circular(16.r))
        ),
      ),
      Positioned(
          top: getScreenHeight(context)*0.025,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: commonPadding),
            child: child,
          ))
    ],
  );
}

Widget commonAddButtonView({Function? onChange,String title = "ADD",Color ourBorderColor = whiteColor}){
  return InkWell(
    onTap: () => onChange!(),
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0.w,vertical: 8.h),
      padding: EdgeInsets.all(8.0.w),
      decoration: BoxDecoration(
          borderRadius: commonBorderRadius,
          border: Border.all(color: ourBorderColor)
      ),
      child: Row(
        children: [
          Icon(Icons.add,color: ourBorderColor,size: 20.h),
          commonHeaderTitle(title: title,ourFontColor: ourBorderColor)
        ],
      ),
    ),
  );
}

Widget commonDivider(){
  return const Divider(color: borderColor);
}

Widget commonHeaderTitle(
    {TextAlign align = TextAlign.center,
      String? title,
      Color ourFontColor = titleColor,
      int fontWeight = 0,
      double fontSize = 1
    }) {
  return Text(title ?? "",
      style: primary14PxNormal.apply(color: ourFontColor, fontSizeFactor: fontSize.sp,fontWeightDelta: fontWeight,),
      textAlign: align);
}

Widget commonSubTitle({TextAlign align = TextAlign.center, String? subTitle}) {
  return Text(subTitle!,
    style: primary14Pxw300.apply(color: titleColor, fontWeightDelta: 1),
    textAlign: align,
    maxLines: 4,);
}

Widget commonWhiteBg(
    {Widget? child,
      bool isClose = false,
      Function? closeButtonCallback,
      double? radius = 36,
      Alignment alignment = Alignment.center}) {
  return ClipRRect(
    borderRadius: BorderRadius.only(topLeft: Radius.circular(radius!.r),
        topRight: Radius.circular(radius.r)),
    child: Container(
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: commonBorderRadius
      ),
      child: Stack(
        alignment: alignment,
        children: [
          Container(
            padding: EdgeInsets.all(12.0.w),
            decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: commonBorderRadius
            ),
            child: child,
          ),
          isClose ? Positioned(right: 5.w, top: 0.h, child: InkWell(onTap: () {
            closeButtonCallback!();
          }, child: const Icon(Icons.close))) : Container()
        ],
      ),
    ),
  );
}

Widget commonStructure({
  required BuildContext context,
  required Widget child,
  PreferredSize? appBar,
  Widget? bottomNavigation,
  Widget? floatingButtonView,
}) {
  ///Pass null in appbar when it's optional ex = appBar : null
  return Stack(
    children: [
      commonAppBackground(),
      Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        appBar: appBar,
        bottomNavigationBar: bottomNavigation,
        floatingActionButton: floatingButtonView,
        ///adding listView cause scroll issue
        body: Center(
          child: Container(
            height: getScreenHeight(context),
            width: getScreenWidth(context),
            color: Colors.transparent,
            child: child,
          ),
        ),
      ),
    ],
  );
}

Widget commonAppBackground() {
  return Container(
    decoration: const BoxDecoration(
      color: whiteColor,
    ),
  );
}

Widget commonHeaderAndSubTitleView({String? title,value}){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      commonSubTitle(align: TextAlign.left,subTitle: title),
      commonHorizontalSpacing7(width: 5.w),
      // value ?? "-"
      Flexible(child: textTitleWithColon(value ?? "-")),
    ],
  );
}

Widget detailView({bool isPadding = true,String? title,value}){
  return Padding(
    padding: EdgeInsets.all(isPadding ? 8.0.w : 0.0.w),
    child: commonHeaderAndSubTitleView(title: title,value: value),
  );
}

Widget paginationLoaderWidget() {
  return Center(
    child: SizedBox(
      height: 35.h,
      width: 35.w,
      child: const CircularProgressIndicator(
        strokeWidth: 3.0,
        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
      ),
    ),
  );
}

dayView(BuildContext context,{String title = '',int? index}){
  return Container(
    width: getScreenWidth(context) / 7,
    padding: const EdgeInsets.symmetric(vertical: 8),
    // decoration: BoxDecoration(
    //     color: GeneralController.to.allDaysValues[index!].isSelected ? secondaryPrimaryColor : whiteColor,
    //     borderRadius: BorderRadius.all(Radius.circular(GeneralController.to.allDaysValues[index].isSelected ? 5.0 : 0.0))
    // ),
    child: commonHeaderTitle(title: title,fontSize: 1.2,ourFontColor: blackColor),
  );
}

commonFilterViewForEmployee({
  BuildContext? context,
  int? radioSelected,
  String? firstButtonText,
  String? secondButtonText,
  Function? callbackOnTap,
}){
  return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      backgroundColor: whiteColor,
      context: context!,
      builder: (context){
        return Wrap(
          children: [
            StatefulBuilder(builder: (context, newSetState) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                // height: getScreenHeight(context) / 3,
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    commonVerticalSpacing10(height: 20),
                    commonHeaderTitle(title: "Filter",fontSize: 2,fontWeight: 2,ourFontColor: primaryColor),
                    commonVerticalSpacing10(),
                    Row(
                      children: [
                        Radio(
                          value: 1,
                          groupValue: radioSelected,
                          activeColor: secondaryPrimaryColor,
                          onChanged: (int? value) {
                            newSetState((){
                              radioSelected = value;
                            });
                            callbackOnTap!(radioSelected);
                          },
                        ),
                        commonHeaderTitle(title: firstButtonText ?? "",fontSize: 1.4,fontWeight: 1,)
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 2,
                          groupValue: radioSelected,
                          activeColor: secondaryPrimaryColor,
                          onChanged: (int? value) {
                            newSetState((){
                              radioSelected = value;
                            });
                            callbackOnTap!(radioSelected);
                          },
                        ),
                        commonHeaderTitle(title: secondButtonText ?? "",fontSize: 1.4,fontWeight: 1,)
                      ],
                    ),
                    commonVerticalSpacing10(height: 20),
                  ],
                ),
              );
            },)
          ],
        );
      }
  );
}

commonFilterViewForEquipment({
  BuildContext? context,
  int? radioSelected,
  String? firstButtonText,
  Function? callbackOnTap,
}){
  return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      backgroundColor: whiteColor,
      context: context!,
      builder: (context){
        return Wrap(
          children: [
            StatefulBuilder(builder: (context, newSetState) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                // height: getScreenHeight(context) / 3,
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    commonVerticalSpacing10(height: 20),
                    commonHeaderTitle(title: "Filter",fontSize: 2,fontWeight: 2,ourFontColor: primaryColor),
                    commonVerticalSpacing10(),
                    Row(
                      children: [
                        Radio(
                          value: 1,
                          groupValue: radioSelected,
                          activeColor: secondaryPrimaryColor,
                          onChanged: (int? value) {
                            newSetState((){
                              radioSelected = value;
                            });
                            callbackOnTap!(radioSelected);
                          },
                        ),
                        commonHeaderTitle(title: firstButtonText ?? "",fontSize: 1.4,fontWeight: 1,)
                      ],
                    ),
                    commonVerticalSpacing10(height: 20),
                  ],
                ),
              );
            },)
          ],
        );
      }
  );
}

Widget selectedDayView({String? title, subtitle,selectedTitle}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 3),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: selectedTitle == subtitle ? secondaryPrimaryColor : lightBorderColor
    ),
    child: Column(
      children: [
        commonHeaderTitle(title: title,ourFontColor: selectedTitle == subtitle ? whiteColor : primaryColor,fontWeight: 1),
        commonVerticalSpacing10(),
        commonHeaderTitle(title: subtitle,ourFontColor: selectedTitle == subtitle ? whiteColor : Colors.grey)
      ],
    ),
  );
}

Widget daySelectionView({DateTime? selectedDate}){
  String selectedTitle = selectedDate!.day.toString();
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 24.0),
    decoration: const BoxDecoration(
      color: lightBorderColor
    ),
    child: StatefulBuilder(
      builder: (context, newSetState) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            commonHeaderTitle(title: DateFormat("MMMM yyyy").format(selectedDate),ourFontColor: primaryColor,fontWeight: 2,fontSize: 1.3),
            commonVerticalSpacing10(),
            Row(
              children: [
                Expanded(
                  child: InkWell(onTap: () {
                    newSetState((){selectedTitle = GeneralController.to.listOfWeekDays[0];});
                  },child:selectedDayView(title: "S",subtitle: GeneralController.to.listOfWeekDays[0],selectedTitle: selectedTitle)),
                ),
                Expanded(
                  child: InkWell(onTap: () {
                    newSetState((){selectedTitle = GeneralController.to.listOfWeekDays[1];});
                  },child:selectedDayView(title: "M",subtitle: GeneralController.to.listOfWeekDays[1],selectedTitle: selectedTitle)),
                ),
                Expanded(
                  child: InkWell(onTap: () {
                    newSetState((){selectedTitle = GeneralController.to.listOfWeekDays[2];});
                  },child:selectedDayView(title: "T",subtitle: GeneralController.to.listOfWeekDays[2],selectedTitle: selectedTitle)),
                ),
                Expanded(
                  child: InkWell(onTap: () {
                    newSetState((){selectedTitle = GeneralController.to.listOfWeekDays[3];});
                  },child:selectedDayView(title: "W",subtitle: GeneralController.to.listOfWeekDays[3],selectedTitle: selectedTitle)),
                ),
                Expanded(
                  child: InkWell(onTap: () {
                    newSetState((){selectedTitle = GeneralController.to.listOfWeekDays[4];});
                  },child:selectedDayView(title: "T",subtitle: GeneralController.to.listOfWeekDays[4],selectedTitle: selectedTitle)),
                ),
                Expanded(
                  child: InkWell(onTap: () {
                    newSetState((){selectedTitle = GeneralController.to.listOfWeekDays[5];});
                  },child:selectedDayView(title: "F",subtitle: GeneralController.to.listOfWeekDays[5],selectedTitle: selectedTitle)),
                ),
                Expanded(
                  child: InkWell(onTap: () {
                    newSetState((){selectedTitle = GeneralController.to.listOfWeekDays[6];});
                  },child:selectedDayView(title: "S",subtitle: GeneralController.to.listOfWeekDays[6],selectedTitle: selectedTitle)),
                ),
              ],
            )
          ],
        );
      },
    ),
  );
}