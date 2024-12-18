import 'package:flexpay/controller/authController.dart';
import 'package:get/get.dart';

class DependencyInjection {
  static void init() {
    Get.put(AuthController());
  }
}