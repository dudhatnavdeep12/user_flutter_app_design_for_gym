import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_gym_app/utility/colors_utility.dart';
import 'package:user_gym_app/utility/text_theme_utility.dart';

import 'common_widgets.dart';

class SearchFilterView extends StatefulWidget {
  final List<dynamic> listOfLocation;
  final Function selectionCallback;
  const SearchFilterView({Key? key, required this.listOfLocation, required this.selectionCallback}) : super(key: key);

  @override
  _SearchFilterViewState createState() => _SearchFilterViewState();
}

class _SearchFilterViewState extends State<SearchFilterView> {

  TextEditingController controller = TextEditingController();
  List<dynamic> filteredList = [];

  @override
  void initState() {
    super.initState();
    filteredList = widget.listOfLocation;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          commonVerticalSpacing10(),
          TextField(
            controller: controller,
            style: primary16PxW700.copyWith(
                color: blackColor,fontWeight: FontWeight.normal),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: "Search",
              hintStyle: primary14PxNormal.copyWith(
                  color: iconsColor),
            ),
            onChanged: (value){
              setState(() {
                if(value.isNotEmpty){
                  filteredList = [];
                  for (var element in widget.listOfLocation) {
                    if(element["name"].toLowerCase().startsWith(value.toLowerCase())){
                      filteredList.add(element);
                    }
                  }
                }else{
                  filteredList = [];
                  filteredList = widget.listOfLocation;
                }
              });
            },
          ),
          commonVerticalSpacing10(),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredList.length,
            separatorBuilder: (context, index) {
              return commonDivider();
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    onTap: (){
                      widget.selectionCallback(filteredList[index]);
                      Get.back();
                    },
                    child: commonHeaderTitle(title: filteredList[index]["name"],ourFontColor: blackColor,align: TextAlign.start)),
              );
            },)
        ],
      ),
    );
  }
}
