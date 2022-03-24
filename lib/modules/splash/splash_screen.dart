import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user_gym_app/utility/asset_utility.dart';
import 'package:user_gym_app/utility/colors_utility.dart';
import 'package:user_gym_app/utility/screen_size_utility.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getScreenHeight(context),
      width: getScreenWidth(context),
      color: primaryColor,
      child: Center(child: Image(image: splashAppLogo,height: getScreenHeight(context)/4.5)),
    );
  }
}
