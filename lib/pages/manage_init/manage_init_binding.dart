import 'package:get/get.dart';

import 'manage_init_logic.dart';

class ManageInitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      ManageInitLogic(),
      permanent: true,
    );
  }
}
