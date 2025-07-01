import 'package:audio_alarm/db_alarm/alarm_entity.dart';
import 'package:get/get.dart';

import '../../audio_player_service.dart';

class RemindDetailsLogic extends GetxController {

  final AudioPlayerService audioService = AudioPlayerService();

  AlarmEntity entity = Get.arguments;

  @override
  void onInit() {
    // TODO: implement onInit
    audioService.playAudio(entity.audio.audioPath);
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    audioService.dispose();
    super.onClose();
  }

}
