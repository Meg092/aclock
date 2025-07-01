import 'package:get/get.dart';

import 'alarm_first_logic.dart';

class AlarmFirstBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AlarmFirstLogic());
  }
}
