import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_gym_app/configuration/configfile.dart';
import 'package:user_gym_app/controllers/authentication_controller.dart';
import 'package:user_gym_app/model/login_response_model.dart';
import '../main.dart';

isNotEmptyString(String? string) {
  return string != null && string.isNotEmpty;
}

bool isNotEmptyList(List? list) {
  return list != null && list.isNotEmpty && list.isNotEmpty;
}

setIsLogin({required bool isLogin}) {
  getPreferences.write('isLogin', isLogin);
}

bool getIsLogin() {
  return (getPreferences.read('isLogin') ?? false);
}

writeUserRolePref({required String key, required String value}) {
  getPreferences.write(key, value);
}

getObject(String key) {
  return getPreferences.read(key) != null ? json.decode(
      getPreferences.read(key)) : null;
}

setFCMToken({required String token}) {
  getPreferences.write('fcmToken', token);
}

String getFCMToken() {
  return (getPreferences.read('fcmToken') ?? "");
}

setObject(String key, value) {
  getPreferences.write(key, json.encode(value));
}

LoginResponseModel? getLoginData() {
  if (getObject(ApiConfig.loginPref) != null) {
    LoginResponseModel loginResponse = LoginResponseModel.fromJson(
        getObject(ApiConfig.loginPref));
    return loginResponse;
  } else {
    return null;
  }
}

getStateCountryWise(Map<String, dynamic> selectedCountry) {
  List<dynamic> states = [];
  if(selectedCountry["id"] != null || selectedCountry["id"] != "") {
    for (int i = 0; i < AuthenticationController.to.allCountries.length; i++) {
      if (AuthenticationController.to.allCountries[i]["id"] ==
          selectedCountry["value"]) {
        states = AuthenticationController.to.allCountries[i]["states"];
        break;
      }
    }
  }
  return states;
}

getCityStateWise(Map<String, dynamic> selectedState) {
  List<dynamic> cities = [];
  if(selectedState["id"] != null || selectedState["id"] != "") {
    if(AuthenticationController.to.allCountries.isNotEmpty) {
      for (int i = 0; i <
          AuthenticationController.to.allCountries[0]["states"]
              .length; i++) {
        if (AuthenticationController.to
            .allCountries[0]["states"][i]["id"] == selectedState["value"]) {
          cities = AuthenticationController.to
              .allCountries[0]["states"][i]["cities"];
          break;
        }
      }
    }
  }
  return cities;
}

showSnackBar({required String title, required String message}) {
  return Get.snackbar(
    title, // title
    message, // message
    backgroundColor: title.isEmpty || title == ApiConfig.warning
        ? const Color(0xffFFCC00)
        : title == ApiConfig.success
        ? Colors.green
        : Colors.red,
    colorText: title.isEmpty || title == ApiConfig.warning
        ? Colors.black
        : Colors.white,
    icon: Icon(
      title.isEmpty || title == ApiConfig.warning
          ? Icons.warning_amber_outlined
          : title == ApiConfig.success
          ? Icons.check_circle
          : Icons.error,
      color: title.isEmpty || title == ApiConfig.warning ? Colors.black : Colors
          .white,
    ),
    onTap: (_) {},
    shouldIconPulse: true,
    barBlur: 10,
    isDismissible: true,
    duration: const Duration(seconds: 2),
  );
}
