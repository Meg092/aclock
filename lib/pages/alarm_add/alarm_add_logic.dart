import 'package:audio_alarm/db_alarm/alarm_entity.dart';
import 'package:audio_alarm/db_alarm/db_alarm.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AlarmAddLogic extends GetxController {
  DBAlarm dbAlarm = Get.find();

  DateTime alarmTime = DateTime.now();

  int remindType = 0;

  AudioEntity? audioEntity;

  String mark = '';

  void addAlarm() async {
    if (audioEntity == null) {
      Fluttertoast.showToast(msg: 'Please select audio');
      return;
    }
    if (mark.isEmpty) {
      Fluttertoast.showToast(msg: 'Please input remind content');
      return;
    }
    final now = DateTime.now();
    if (alarmTime.isBefore(now)) {
      alarmTime = now.add(const Duration(days: 1));
    }
    alarmTime = DateTime(
        alarmTime.year, alarmTime.month, alarmTime.day, alarmTime.hour, alarmTime.minute,0);
    final entity = AlarmEntity(
        id: 0,
        createdTime: DateTime.now(),
        audio: audioEntity!,
        alarmTime: alarmTime,
        remindType: remindType,
        mark: mark,
        isRemind: 1);
    await dbAlarm.insertAlarm(entity);
    Fluttertoast.showToast(msg: 'Add alarm success');
    Get.back();
  }
}
