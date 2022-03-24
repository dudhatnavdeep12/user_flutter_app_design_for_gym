import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:user_gym_app/controllers/general_controller.dart';
import 'package:user_gym_app/modules/login/login_screen.dart';
import 'package:user_gym_app/utility/colors_utility.dart';
import 'package:user_gym_app/utility/common_methods.dart';
import 'package:user_gym_app/utility/constants.dart';

import '../main.dart';
import 'Configfile.dart';
import 'apiservice.dart';

const String somethingWrong = "Something Went Wrong";
const String responseMessage = "NO RESPONSE DATA FOUND";
const String interNetMessage = "NO INTERNET CONNECTION, PLEASE CHECK YOUR INTERNET CONNECTION AND TRY AGAIN LATTER.";
const String connectionTimeOutMessage = "Opps.. Server not working or might be in maintenance .Please Try Again Later";
const String authenticationMessage = "The session has been Expired. Please log in again.";
const String tryAgain = "Try Again";

Map<String, dynamic>? tempParams;
dynamic listTempParams;
FormData? tempFormData;
String? tempServiceUrl;
Function? tempSuccess;
Function? tempError;
bool? tempIsProgressShow;
bool? isTempFormData;
bool? tempIsLoading;
bool? tempIsFromLogout;
bool? tempIsHideLoader;
String? tempMethodType;

///Status Code with message type array or string
// 501 : sql releated err
// 401: validation array
// 201 : string error
// 400 : string error
// 200: responce, string/null
// 422: array

apiServiceCall({
  required Map<String, dynamic> params,
  required String serviceUrl,
  required Function success,
  required Function error,
  required bool isProgressShow,
  required String methodType,
  dynamic listParams,
  bool isFromLogout = false,
  bool? isLoading,
  bool? isHideLoader = true,
  FormData? formValues,
}) async {
  tempParams = params;
  listTempParams = listParams;
  tempServiceUrl = serviceUrl;
  tempSuccess = success;
  tempMethodType = methodType;
  tempError = error;
  tempIsProgressShow = isProgressShow;
  tempIsLoading = isLoading;
  tempIsFromLogout = isFromLogout;
  tempFormData = formValues;
  tempIsHideLoader = isHideLoader;

  if (await checkInternet()) {
    if (tempIsProgressShow != null && tempIsProgressShow!) {
      showProgressDialog();
    }
    // if (tempFormData != null) {
    //   Map<String, dynamic> tempMap = Map<String, dynamic>();
    //   tempFormData!.fields.forEach((element) {
    //     tempMap[element.key] = element.value;
    //   });
    //   FormData reGenerateFormData = new FormData.fromMap(tempMap);
    //   tempFormData!.files.forEach((element) {
    //     reGenerateFormData.files.add(MapEntry(element.key, element.value));
    //   });
    //   tempFormData = reGenerateFormData;
    // }

    Map<String, dynamic> headerParameters = {
      "accept": "application/json",
      "Content-Type": "application/json",
      "X-CSRF-TOKEN": "",
      "Authorization": getLoginData() != null ? getLoginData()!.accessToken != null ? "Bearer ${getLoginData()!.accessToken}" : "" : "",
    };

    if (kDebugMode) {
      print(getLoginData() != null ? getLoginData()!.accessToken != null ? "${getLoginData()!.accessToken}" : "" : "");
    }

    try {
      Response response;
      if (tempMethodType == ApiConfig.methodGET) {
        response = await APIProvider.getDio().get(tempServiceUrl!, queryParameters: listTempParams ?? tempParams, options: Options(headers: headerParameters));
      } else if (tempMethodType == ApiConfig.methodPUT) {
        response = await APIProvider.getDio().put(tempServiceUrl!, data: listTempParams ?? tempParams, options: Options(headers: headerParameters));
      } else if (tempMethodType == ApiConfig.methodDELETE) {
        response = await APIProvider.getDio().delete(tempServiceUrl!, data: listTempParams ?? tempParams, options: Options(headers: headerParameters));
      } else {
        response = await APIProvider.getDio()
            .post(tempServiceUrl!, data: tempFormData ?? (listTempParams ?? tempParams), options: Options(headers: headerParameters));
      }
      if (handleResponse(response)) {
        if (tempIsHideLoader!) {
          hideProgressDialog();
        }
        if(response.statusCode == 200){
          tempSuccess!(response);
        }else if (response.statusCode == 401) {
          handleAuthentication(boolResponse: authenticationMessage);
        } else if(response.statusCode == 400 || response.statusCode == 404 || response.statusCode == 403){
          /// statusCode 400 Bad Request - Error Message.
          tempError!(response.data["detail"]);
        }else if(response.statusCode == 500){
          /// statusCode 500 Internal Server Error - Error Message.
          tempError!("Internal Server Error");
        } else{
          tempError!(response.toString());
        }
        // else if(response.statusCode == 403){
        //   /// statusCode 403 Forbidden Request - Error Message.
        //   tempError!("Forbidden Error");
        // }

      } else {
        if (tempIsHideLoader!) {
          hideProgressDialog();
        }
        showErrorMessage(message: somethingWrong, isRecall: true);
        tempError!(response.toString());
      }
    } on DioError catch (dioError) {
      dioErrorCall(
          dioError: dioError,
          onCallBack: (String message, bool isRecallError) {
            showErrorMessage(message: message, isRecall: isRecallError);
          });
    }
  } else {
    showErrorMessage(message: interNetMessage, isRecall: true);
  }
}

void handleAuthentication({required String boolResponse}) {
  if (!tempIsFromLogout!) {
    apiAlertDialog(
        buttonTitle: logInAgain,
        message: boolResponse,
        isShowGoBack: false,
        buttonCallBack: () {
          GeneralController.to.clearPref();
          setIsLogin(isLogin: false);
          getx.Get.offAll(() => const LoginScreen(), transition: getx.Transition.rightToLeftWithFade);
        });
  } else {
    GeneralController.to.clearPref();
    setIsLogin(isLogin: false);
    getx.Get.offAll(() => const LoginScreen(), transition: getx.Transition.rightToLeftWithFade);
  }
}


int serviceCallCount = 0;

showErrorMessage({required String message, required bool isRecall, Function? callBack}) {
  serviceCallCount = 0;
  hideProgressDialog();
  apiAlertDialog(
      buttonTitle: serviceCallCount < 3 ? tryAgain : "Restart App",
      message: message,
      buttonCallBack: () {
        if (serviceCallCount < 3) {
          if (isRecall) {
            getx.Get.back();
            apiServiceCall(
                params: tempParams!,
                listParams: listTempParams!,
                serviceUrl: tempServiceUrl!,
                success: tempSuccess!,
                error: tempError!,
                isProgressShow: tempIsProgressShow!,
                methodType: tempMethodType!,
                formValues: tempFormData,
                isFromLogout: tempIsFromLogout!,
                isHideLoader: tempIsHideLoader,
                isLoading: tempIsLoading);
          } else {
            if (callBack != null) {
              callBack();
            } else {
              getx.Get.back(); // For redirecting to back screen
            }
          }
        } else {
          getx.Get.back(); // For redirecting to back screen
          getx.Get.offAll(() => const MyHomePage());
        }
      });
}

void showProgressDialog() {
  if (tempIsLoading != null) {
    tempIsLoading = true;
    // FeedListController.to.isFetching.value = true;
  }
  getx.Get.dialog(
    const Center(
      child: SizedBox(
        child:
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
        ),
        // height: 50.0,
        // width: 50.0,
      ),
    ),
    barrierDismissible: false,
  );
}

void hideProgressDialog() {
  if (tempIsLoading != null) {
    tempIsLoading = false;
    // FeedListController.to.isFetching.value = false;
  }
  if ((tempIsProgressShow! || tempIsHideLoader!) && getx.Get.isDialogOpen!) {
    getx.Get.back();
  }
}

dioErrorCall({required DioError dioError, required Function onCallBack}) {
  switch (dioError.type) {
    case DioErrorType.other:
    case DioErrorType.connectTimeout:
    // onCallBack(connectionTimeOutMessage, false);
      onCallBack(dioError.message, true);
      break;
    case DioErrorType.response:
    case DioErrorType.cancel:
    case DioErrorType.receiveTimeout:
    case DioErrorType.sendTimeout:
    default:
      onCallBack(dioError.message, true);
      break;
  }
}

Future<bool> checkInternet() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}

bool handleResponse(Response response) {
  try {
    if (isNotEmptyString(response.toString())) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

apiAlertDialog({required String message, String? buttonTitle, Function? buttonCallBack, bool isShowGoBack = true}) {
  if (!getx.Get.isDialogOpen!) {
    getx.Get.dialog(
      WillPopScope(
        onWillPop: () {
          return isShowGoBack ? Future.value(true) : Future.value(false);
        },
        child: CupertinoAlertDialog(
          title: const Text(appName),
          content: Text(message),
          actions: isShowGoBack
              ? [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text(isNotEmptyString(buttonTitle) ? buttonTitle! : "Try again"),
              onPressed: () {
                if (buttonCallBack != null) {
                  buttonCallBack();
                } else {
                  getx.Get.back();
                }
              },
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text("Go Back"),
              onPressed: () {
                getx.Get.back();
                getx.Get.back();
              },
            )
          ]
              : [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text(isNotEmptyString(buttonTitle) ? buttonTitle! : "Try again"),
              onPressed: () {
                if (buttonCallBack != null) {
                  buttonCallBack();
                } else {
                  getx.Get.back();
                }
              },
            ),
          ],
        ),
      ),
      barrierDismissible: false,
      transitionCurve: Curves.easeInCubic,
      transitionDuration: const Duration(milliseconds: 400),
    );
  }
}
