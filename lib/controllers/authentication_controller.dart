import 'package:get/get.dart';
import 'package:user_gym_app/configuration/apiutility.dart';
import 'package:user_gym_app/configuration/configfile.dart';
import 'package:dio/dio.dart' as dio;
import 'package:user_gym_app/model/address_response_model.dart';
import 'package:user_gym_app/model/login_response_model.dart';
import 'package:user_gym_app/modules/dashboard/dashboard_screen.dart';
import 'package:user_gym_app/modules/login/login_screen.dart';
import 'package:user_gym_app/modules/signup/otp_verification_screen.dart';
import 'package:user_gym_app/modules/signup/signup_address_screen.dart';
import 'package:user_gym_app/utility/common_methods.dart';
import 'general_controller.dart';

class AuthenticationController extends GetxController {
  static AuthenticationController get to => Get.find(); // add this
  RxList<dynamic> allCountries = RxList();

  void getAllCountryListing() {
    allCountries.clear();
    apiServiceCall(
      params: {},
      serviceUrl: "https://gym.kashsolution.com/api/country-state-city",
      success: (dio.Response<dynamic> response) {
        AddressModelResponse addressModelResponse = AddressModelResponse.fromJson(response.data);
        if(addressModelResponse.status!) {
          allCountries.assignAll(response.data["data"] ?? []);
        }
        GeneralController.to.isLoading.value = false;
      },
      error: (String response) {
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodGET
    );
  }

  void signupUser(Map<String, dynamic> params) {
    apiServiceCall(
      // isLoading: true,
      params: params,
      serviceUrl: ApiConfig.baseURI + ApiConfig.signUp,
      success: (dio.Response<dynamic> response) {
        GeneralController.to.isLoading.value = false;
        showSnackBar(title: ApiConfig.success, message: "Sign up successfully");
        // email: params.values.first,id: response.data["data"]["id"]
        Get.offAll(() => OTPVerificationScreen(email: params.values.first,callback: (String otp){
          validateOTP({"otp": otp},id: response.data["data"]["id"],callback: (){
            Get.offAll(() => SignUpAddressScreen(id: response.data["data"]["id"]));
          });
        },));
      },
      error: (String response) {
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST
    );
  }

  void signupUserOtherDetail(Map<String, dynamic> params,num id) {
    apiServiceCall(
      // isLoading: true,
      params: params,
      serviceUrl: ApiConfig.baseURI + "/users/$id",
      success: (dio.Response<dynamic> response) {
        GeneralController.to.isLoading.value = false;
        showSnackBar(title: ApiConfig.success, message: "Sign up successfully");
        Get.offAll(() => const LoginScreen());
      },
      error: (String response) {
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPUT
    );
  }

  void validateOTP(Map<String, dynamic> params,{num? id,Function? callback}) {
    apiServiceCall(
      params: params,
      serviceUrl: "${ApiConfig.baseURI}/users/validateotp/$id",
      success: (dio.Response<dynamic> response) {
        GeneralController.to.isLoading.value = false;
        showSnackBar(title: ApiConfig.success, message: response.data["message"]);
        callback!();
      },
      error: (String response) {
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST
    );
  }

  void sendOTP(Map<String, dynamic> params) {
    apiServiceCall(
      params: params,
      serviceUrl: "${ApiConfig.baseURI}/users/otp",
      success: (dio.Response<dynamic> response) {
        GeneralController.to.isLoading.value = false;
        showSnackBar(title: ApiConfig.success, message: response.data["message"]);
      },
      error: (String response) {
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST
    );
  }

  void resetPassword(Map<String, dynamic> params,{num? id}) {
    apiServiceCall(
        params: params,
        serviceUrl: "${ApiConfig.baseURI}/users/reset/$id",
        success: (dio.Response<dynamic> response) {
          GeneralController.to.isLoading.value = false;
          Get.back();
          Get.back();
          showSnackBar(title: ApiConfig.success, message: response.data["message"]);
        },
        error: (String response) {
          errorHandling(response);
        },
        isProgressShow: true,
        methodType: ApiConfig.methodPOST
    );
  }

  void loginUser(dio.FormData params) {
    apiServiceCall(
      // isLoading: true,
      params: {},
      formValues: params,
      serviceUrl: ApiConfig.baseURI + ApiConfig.login,
      success: (dio.Response<dynamic> response) {
        LoginResponseModel loginResponseModel = LoginResponseModel.fromJson(response.data);
        GeneralController.to.isLoading.value = false;
        if(loginResponseModel.data?.email_status == null || loginResponseModel.data?.email_status == 0){
          Get.offAll(() => OTPVerificationScreen(email: loginResponseModel.data?.email ?? "",callback: (String otp){
            validateOTP({"otp": otp},id: loginResponseModel.data?.id ?? 0,callback: (){
              setObject(ApiConfig.loginPref, loginResponseModel);
              setIsLogin(isLogin: true);
              Get.offAll(() => const DashboardScreen());
            });
          }));
        }else{
          setObject(ApiConfig.loginPref, loginResponseModel);
          setIsLogin(isLogin: true);
          Get.offAll(() => const DashboardScreen());
        }
      },
      error: (String response) {
        errorHandling(response);
      },
      isProgressShow: true,
      methodType: ApiConfig.methodPOST
    );
  }

  void logOutAPI() {
    apiServiceCall(
      params: {},
      serviceUrl: ApiConfig.baseURI + ApiConfig.logoutURL,
      success: (dio.Response<dynamic> response) {
        setIsLogin(isLogin: false);
        GeneralController.to.clearPref();
        GeneralController.to.isLoading.value = false;
        Get.offAll(() => const LoginScreen(), transition: Transition.rightToLeftWithFade);
      },
      error: (String response) {
        showSnackBar(title: ApiConfig.error, message: response);
      },
      isProgressShow: false,
      methodType: ApiConfig.methodPOST,
    );
  }

  void errorHandling(String response){
    GeneralController.to.isLoading.value = false;
    showSnackBar(title: ApiConfig.error, message: response);
  }
}