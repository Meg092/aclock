import 'package:get/get.dart';

import 'my_audio_logic.dart';

class MyAudioBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyAudioLogic());
  }
}
