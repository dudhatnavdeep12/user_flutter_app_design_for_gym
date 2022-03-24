import 'package:flutter/material.dart';
import 'package:user_gym_app/common_widgets/common_widgets.dart';
import 'package:user_gym_app/controllers/general_controller.dart';
import 'package:user_gym_app/modules/gym/gym_list_screen.dart';
import 'package:user_gym_app/modules/home/home_view.dart';
import 'package:user_gym_app/modules/profile/profile_screen.dart';
import 'package:user_gym_app/utility/colors_utility.dart';
import 'package:user_gym_app/utility/constants.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  void onItemTapped(int index) {
    GeneralController.to.selectedIndex.value = index;
    setState(() {

    });
  }

  Color _getBgColor(int index) =>
      GeneralController.to.selectedIndex.value == index ? secondaryPrimaryColor : whiteColor;

  Color _getItemColor(int index) =>
      GeneralController.to.selectedIndex.value == index ? whiteColor : blackColor;

  Widget _buildIcon(IconData iconData,int index) => SizedBox(
    width: 50,
    height: 50,
    child: Material(
      color: _getBgColor(index),
      child: InkWell(
        child: Icon(iconData,color: _getItemColor(index),size: 26,),
        onTap: () => onItemTapped(index),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return commonStructure(
      appBar: commonSearchAppBar(context: context, title: GeneralController.to.selectedIndex.value == 0 ?
      dashboard : GeneralController.to.selectedIndex.value == 1 ?
      gymList : GeneralController.to.selectedIndex.value == 2 ?
      myProfile : setting),
        context: context,
        bottomNavigation: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: GeneralController.to.selectedIndex.value,
          selectedItemColor: whiteColor,
          unselectedItemColor: blackColor,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (int index){
            onItemTapped(index);
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: _buildIcon(Icons.home_outlined,0),
              label: ''
            ),
            BottomNavigationBarItem(
              icon: _buildIcon(Icons.menu,1),
              label: ''
            ),
            BottomNavigationBarItem(
              icon: _buildIcon(Icons.person_outline_outlined,2),
              label: ''
            ),
            // BottomNavigationBarItem(
            //   icon: _buildIcon(Icons.settings_outlined,3),
            //   label: ''
            // ),
          ],
        ),
        child: GeneralController.to.selectedIndex.value == 0 ? const HomeView() :
        GeneralController.to.selectedIndex.value == 1 ? const GymListScreen() :
        const ProfileScreen()
    );
  }
}
