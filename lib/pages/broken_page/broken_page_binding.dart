import 'package:get/get.dart';

import 'broken_page_logic.dart';

class BrokenPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BrokenPageLogic());
  }
}
