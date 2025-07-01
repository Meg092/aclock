import 'package:audio_alarm/main.dart';
import 'package:audio_alarm/pages/alarm_add/alarm_add_view.dart';
import 'package:audio_alarm/pages/alarm_first/alarm_first_view.dart';
import 'package:audio_alarm/pages/alarm_second/alarm_second_view.dart';
import 'package:audio_alarm/alarm_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import '../alarm_first/alarm_first_logic.dart';
import 'alarm_tab_logic.dart';

class AlarmTabPage extends GetView<AlarmTabLogic> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        children: [AlarmFirstPage(),AlarmAddPage(),AlarmSecondPage()],
      ),
      bottomNavigationBar: Obx(() => _navAlarmBars()),
    );
  }

  Widget _navAlarmBars() {
    return BottomNavigationBar(
      items: [
       BottomNavigationBarItem(
          icon:const Icon(Icons.home,size: 24,color: Color(0xffd8d8d8),),
          activeIcon: Icon(Icons.home,size: 24,color: primaryColor,),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Container(
            width: 48,
            height: 48,
            child: <Widget>[
              const Icon(
                Icons.add,
                size: 32,
                color: Colors.white,
              )
            ].toColumn(mainAxisAlignment: MainAxisAlignment.center),
          ).decorated(
              color: primaryColor, borderRadius: BorderRadius.circular(24)),
          label: '',
        ),
        BottomNavigationBarItem(
          icon:const Icon(Icons.settings,size: 24,color: Color(0xffd8d8d8),),
          activeIcon: Icon(Icons.settings,size: 24,color: primaryColor,),
          label: 'Setting',
        ),
      ],
      currentIndex: controller.currentIndex.value,
      onTap: (index) async {
        if (index == 1) {
          Get.toNamed(AlarmNames.alarmAdd)?.then((_) {
            AlarmFirstLogic firstLogic = Get.put(AlarmFirstLogic());
            firstLogic.getData();
          });
        } else {
          controller.currentIndex.value = index;
          controller.pageController.jumpToPage(index);
        }
      },
    );
  }
}
