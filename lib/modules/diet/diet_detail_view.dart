import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_gym_app/common_widgets/common_widgets.dart';
import 'package:user_gym_app/utility/colors_utility.dart';

class DietDetailView extends StatefulWidget {
  const DietDetailView({Key? key}) : super(key: key);

  @override
  _DietDetailViewState createState() => _DietDetailViewState();
}

class _DietDetailViewState extends State<DietDetailView> {

  Widget dietView(){
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(flex:2,child: Container(height: 80,width: 80,decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: borderColor
          ))),
          commonHorizontalSpacing7(),
          Expanded(flex:5,child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            textBaseline: TextBaseline.ideographic,
            children: [
              commonHeaderTitle(title: "Honey Pancake 30 g",ourFontColor: primaryColor,fontWeight: 1,fontSize: 1.0),
              commonHeaderTitle(title: "07:00am",ourFontColor: Colors.grey,fontWeight: 1,fontSize: 1.0),
            ],
          )),
          commonHorizontalSpacing7(),
          Expanded(flex:2,child: InkWell(
            onTap: (){

            },
            child: Container(padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),decoration: BoxDecoration(
                border: Border.all(color: secondaryPrimaryColor,width: 2),
              borderRadius: BorderRadius.circular(20)
            ),child: commonHeaderTitle(title: "Done",ourFontColor: blackColor,fontWeight: 1,fontSize: 1.0)),
          )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return commonStructure(
        context: context,
        appBar: commonSearchAppBar(context: context, elevation: 0.0,title: "My Diet",leadingWidget: InkWell(
          onTap: (){
            Get.back();
          },
          child: const Icon(Icons.arrow_back,color: primaryColor),
        )),
        child: ListView(
          shrinkWrap: true,
          children: [
            commonVerticalSpacing10(),
            daySelectionView(selectedDate: DateTime.now()),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return dietView();
                },),
            )
          ],
        )
    );
  }
}
