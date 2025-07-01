import 'package:audio_alarm/db_alarm/db_alarm.dart';
import 'package:get/get.dart';

import '../../audio_player_service.dart';
import '../../db_alarm/alarm_entity.dart';

class MyAudioLogic extends GetxController {

  DBAlarm dbAlarm = Get.find();
  final AudioPlayerService audioService = AudioPlayerService();
  bool isPlaying = false;
  int currentPlayIndex = -1;


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

  @override
  void onClose() {
    // TODO: implement onClose
    audioService.dispose();
    super.onClose();
  }

}
