import 'package:get/get.dart';

import 'alarm_second_logic.dart';

class AlarmSecondBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AlarmSecondLogic());
  }
}
