import 'package:audio_alarm/alarm_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class AlarmTabLogic extends GetxController {

  PageController pageController = PageController();
  var currentIndex = 0.obs;

  void uihiuhic() async {
    final hadNetwork = await InternetConnectionChecker.instance.hasConnection;
    if (!hadNetwork) {
      Get.toNamed(AlarmNames.brokenPage);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    uihiuhic();
    super.onInit();
  }

}
