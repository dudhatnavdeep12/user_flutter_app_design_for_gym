import 'package:get/get.dart';

import '../authentication_controller.dart';
import '../general_controller.dart';

class AppBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    Get.put<GeneralController>(GeneralController(), permanent: true);
    Get.put<AuthenticationController>(AuthenticationController(), permanent: true);
  }
}
