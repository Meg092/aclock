import 'package:get/get.dart';

import '../../db_alarm/alarm_entity.dart';
import '../../db_alarm/db_alarm.dart';

class SelectAudioLogic extends GetxController {

  DBAlarm dbAlarm = Get.find();

  var list = <AudioEntity>[].obs;

  void getData() async {
    list.value = await dbAlarm.getAudioAllData();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getData();
    super.onInit();
  }



}
