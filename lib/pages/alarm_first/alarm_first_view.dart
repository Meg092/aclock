import 'package:audio_alarm/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import 'alarm_first_logic.dart';

class AlarmFirstPage extends GetView<AlarmFirstLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: <Widget>[
                Container(
                  width: double.infinity,
                  height: 135,
                  child: <Widget>[
                    const Text(
                      'A recent reminder',
                      style: TextStyle(color: Colors.white),
                    ),
                    GetBuilder<AlarmFirstLogic>(init: AlarmFirstLogic(),builder: (_) {
                      return Text(
                        controller.firstAlarm == null ? 'No data' : controller
                            .firstAlarm!.alarmTimeStr,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 38),
                      );
                    })
                  ]
                      .toColumn(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start)
                      .marginOnly(left: 40),
                ).decorated(
                    image: const DecorationImage(
                        image: AssetImage('assets/img.webp'))),
                <Widget>[
                  Image.asset(
                    'assets/icon0.webp',
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Remind list',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  )
                ].toRow().marginSymmetric(vertical: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  child: Obx(() {
                    return controller.list.value.isEmpty
                        ? const Center(
                      child: Text('No data'),
                    )
                        : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.list.value.length,
                        itemBuilder: (_, index) {
                          var entity = controller.list.value[index];
                          return <Widget>[
                            <Widget>[
                              Expanded(
                                  child: <Widget>[
                                    Text(
                                      entity.alarmTimeStr,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 31,
                                          color: entity.isRemind == 1
                                              ? Colors.black
                                              : Colors.grey),
                                    ),
                                    Text(
                                      '${titles[entity.remindType]} remind',
                                      style: TextStyle(
                                          color: entity.isRemind == 1
                                              ? Colors.black
                                              : Colors.grey),
                                    )
                                  ].toColumn(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start)),
                              Switch(
                                  activeTrackColor: Colors.green,
                                  value: entity.isRemind == 1 ? true : false,
                                  onChanged: (v) {
                                    entity.isRemind = v ? 1 : 0;
                                    controller.dbAlarm.updateAlarm(entity);
                                    controller.startTimer();
                                  })
                            ].toRow(),
                            Divider(
                              height: 25,
                              color: Colors.grey[300],
                            )
                          ].toColumn();
                        });
                  }),
                )
                    .decorated(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20))
                    .constrained(minHeight: 60)
              ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
            ).marginAll(15)),
      ).decorated(
          gradient: const LinearGradient(
              colors: [Color(0xffd1d7ff), Color(0xfff4f4f4)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0, 0.4])),
    );
  }
}
