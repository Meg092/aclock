import 'dart:async';

import 'package:audio_alarm/db_alarm/alarm_entity.dart';
import 'package:audio_alarm/db_alarm/db_alarm.dart';
import 'package:audio_alarm/alarm_names.dart';
import 'package:get/get.dart';

class AlarmFirstLogic extends GetxController {

  DBAlarm dbAlarm = Get.find();

  var list = <AlarmEntity>[].obs;

  AlarmEntity? firstAlarm;

  Timer? _timer;

  void startTimer() async {
    _timer?.cancel();
    _timer = null;
    await getData();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
        for (int i = 0; i < list.length; i++) {
          var entity = list[i];
          if (entity.isRemind == 1) {
            if (entity.remindType == 0) {
              if (entity.alarmTime.isBefore(DateTime.now())) {
                Get.toNamed(AlarmNames.remindDetails, arguments: entity);
                entity.alarmTime = entity.alarmTime.add(const Duration(days: 1));
                await dbAlarm.updateAlarm(entity);
                startTimer();
                break;
              }
            } else if (entity.remindType == 1) {
              if (entity.alarmTime.isBefore(DateTime.now())) {
                Get.toNamed(AlarmNames.remindDetails, arguments: entity);
                entity.alarmTime = entity.alarmTime.add(const Duration(days: 365*100));
                await dbAlarm.updateAlarm(entity);
                startTimer();
                break;
              }
            } else if (entity.remindType == 2) {
              if (entity.alarmTime.isBefore(DateTime.now()) && DateTime.now().day == 6) {
                Get.toNamed(AlarmNames.remindDetails, arguments: entity);
                entity.alarmTime = entity.alarmTime.add(const Duration(days: 7));
                await dbAlarm.updateAlarm(entity);
                startTimer();
                break;
              }
            } else if (entity.remindType == 3) {
              if (entity.alarmTime.isBefore(DateTime.now()) && DateTime.now().day == 7) {
                Get.toNamed(AlarmNames.remindDetails, arguments: entity);
                entity.alarmTime = entity.alarmTime.add(const Duration(days: 7));
                await dbAlarm.updateAlarm(entity);
                startTimer();
                break;
              }
            }
          }

        }
    });
  }

  getData() async {
    list.value = await dbAlarm.getAlarmAllData();
    firstAlarm = list.firstWhereOrNull((element) => element.isRemind == 1);
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    startTimer();
    super.onInit();
  }

}
