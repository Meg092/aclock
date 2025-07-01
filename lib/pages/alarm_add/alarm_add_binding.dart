import 'package:get/get.dart';

import 'alarm_add_logic.dart';

class AlarmAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AlarmAddLogic());
  }
}
