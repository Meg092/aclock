import 'package:audio_alarm/pages/alarm_first/alarm_first_logic.dart';
import 'package:audio_alarm/pages/alarm_second/alarm_second_logic.dart';
import 'package:get/get.dart';

import 'alarm_tab_logic.dart';

class AlarmTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AlarmTabLogic());
    Get.lazyPut(() => AlarmFirstLogic());
    Get.lazyPut(() => AlarmSecondLogic());
  }
}
