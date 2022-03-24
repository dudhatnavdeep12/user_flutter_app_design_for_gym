import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_gym_app/modules/gym/gym_card_view.dart';

import 'gym_detail_screen.dart';

class GymListScreen extends StatefulWidget {
  const GymListScreen({Key? key}) : super(key: key);

  @override
  _GymListScreenState createState() => _GymListScreenState();
}

class _GymListScreenState extends State<GymListScreen> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 65,left: 8,right: 8),
      itemCount: 10,
      itemBuilder: (context, index) {
        return GymCardView(tapOnCallback: (){
          Get.to(() => const GymDetailScreen());
        });
    });
  }

}
