import 'package:get/get.dart';

import 'add_audio_logic.dart';

class AddAudioBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddAudioLogic());
  }
}
