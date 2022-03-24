import 'package:flutter/material.dart';

getScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

getScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

getScreenDynamicHeight(BuildContext context,{double deskTopHeight = 1, bool isDivide = true, bool isMinus = false}) {
  if(isDivide) {
    return getScreenHeight(context) / deskTopHeight;
  } else if(isMinus) {
    return getScreenHeight(context) - deskTopHeight;
  }
}

getScreenDynamicWidth(BuildContext context,{double deskTopWidth = 1, bool isDivide = true, bool isMinus = false}) {
  if(isDivide) {
    return getScreenWidth(context) / deskTopWidth;
  } else if(isMinus) {
    return getScreenWidth(context) - deskTopWidth;
  }
}