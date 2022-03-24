import 'package:get/get.dart';
import 'package:user_gym_app/configuration/configfile.dart';
import 'package:user_gym_app/utility/common_methods.dart';

class GeneralController extends GetxController {

  static GeneralController get to => Get.find(); // add this
  RxInt selectedIndex = 0.obs;
  RxList<String> listOfWeekDays = RxList();
  ///ManageLoading
  RxBool isLoading = false.obs;

  void clearPref() {
    setIsLogin(isLogin: false);
    setObject(ApiConfig.loginPref, null);
    GeneralController.to.refresh();
  }
}