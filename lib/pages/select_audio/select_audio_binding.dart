import 'package:get/get.dart';

import 'select_audio_logic.dart';

class SelectAudioBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SelectAudioLogic());
  }
}
