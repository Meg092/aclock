import 'package:audio_alarm/main.dart';
import 'package:audio_alarm/pages/alarm_add/alarm_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../alarm_names.dart';
import 'alarm_add_logic.dart';

class AlarmAddPage extends GetView<AlarmAddLogic> {
  Widget _remindTypeWidget(int index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
      child: Text(
        titles[index],
        textAlign: TextAlign.center,
        style: TextStyle(
            color:
                controller.remindType == index ? Colors.white : Colors.black),
      ),
    )
        .decorated(
            color: controller.remindType == index
                ? primaryColor
                : const Color(0xffeaeaea),
            borderRadius: BorderRadius.circular(15))
        .gestures(onTap: () {
      controller.remindType = index;
      controller.update();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
        backgroundColor: Colors.white,
        actions: [
          Text(
            'Commit',
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
          ).marginOnly(right: 20).gestures(onTap: () {
            controller.addAlarm();
          })
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: GetBuilder<AlarmAddLogic>(builder: (_) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: <Widget>[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                child: DateTimePickerWidget(
                  dateFormat: 'HH:mm',
                  pickerTheme: const DateTimePickerTheme(
                      cancel: SizedBox(),
                      confirm: SizedBox(),
                      titleHeight: 0,
                      itemHeight: 80,
                      itemTextStyle:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  onChange: (dateTime, List<int> index) {
                    controller.alarmTime = dateTime;
                  },
                ),
              ).decorated(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0xffbebebe).withOpacity(0.35),
                        blurRadius: 10,
                        offset: const Offset(6, 1))
                  ]),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                child: <Widget>[
                  const Text(
                    'Select the reminder time',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    spacing: 7,
                    runSpacing: 7,
                    children: [
                      _remindTypeWidget(0),
                      _remindTypeWidget(1),
                      _remindTypeWidget(2),
                      _remindTypeWidget(3)
                    ],
                  )
                ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
              ).decorated(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0xffbebebe).withOpacity(0.35),
                        blurRadius: 10,
                        offset: const Offset(6, 1))
                  ]),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                height: 56,
                padding: const EdgeInsets.all(12),
                child: <Widget>[
                  const Text(
                    'Select audio',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: IgnorePointer(
                      child: AlarmTextField(
                          textAlign: TextAlign.right,
                          value: controller.audioEntity?.name ?? '',
                          hintText: 'Select audio',
                          onChange: (_) {}),
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_right,
                    size: 25,
                    color: Colors.grey,
                  )
                ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
              ).decorated(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0xffbebebe).withOpacity(0.35),
                        blurRadius: 10,
                        offset: const Offset(6, 1))
                  ]).gestures(onTap: (){
                    Get.toNamed(AlarmNames.selectAudio)?.then((value) {
                      controller.audioEntity = value;
                      controller.update();
                    });
              }),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                child: <Widget>[
                  const Text(
                    'Remind content',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  AlarmTextField(
                      maxLines: 5,
                      maxLength: 50,
                      padding: EdgeInsets.zero,
                      value: controller.mark,
                      onChange: (v) {
                        controller.mark = v;
                      })
                ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
              ).decorated(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0xffbebebe).withOpacity(0.35),
                        blurRadius: 10,
                        offset: const Offset(6, 1))
                  ]),
            ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
          );
        }).marginAll(15)),
      ),
    );
  }
}
