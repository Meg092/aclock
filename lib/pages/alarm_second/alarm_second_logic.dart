import 'package:audio_alarm/db_alarm/db_alarm.dart';
import 'package:audio_alarm/pages/alarm_first/alarm_first_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AlarmSecondLogic extends GetxController {

  DBAlarm dbAlarm = Get.find();

  cleanAlarmData() async {
    Get.dialog(AlertDialog(
      title: const Text('Warm reminder'),
      content: const Text('Do you want to clean all records?'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Cancel',style: TextStyle(color: Colors.black),),
        ),
        TextButton(
          onPressed: () async {
            await dbAlarm.cleanAllData();
            AlarmFirstLogic firstLogic = Get.put(AlarmFirstLogic());
            firstLogic.getData();
            Get.back();
          },
          child: const Text(
            'OK',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    ));
  }

  aboutAlarmUS(BuildContext context) async {
    var info = await PackageInfo.fromPlatform();
    showAboutDialog(
      applicationName: info.appName,
      applicationVersion: info.version,
      applicationIcon: Image.asset(
        'assets/launcher.webp',
        width: 72,
        height: 72,
      ),
      children: [
        const Text(
            """We can provide you with a customized alarm"""),
      ],
      context: context,
    );
  }

}
