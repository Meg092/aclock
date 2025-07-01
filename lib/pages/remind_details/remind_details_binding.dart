import 'package:get/get.dart';

import 'remind_details_logic.dart';

class RemindDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RemindDetailsLogic());
  }
}
