import 'dart:convert';

import 'package:audio_alarm/main.dart';
import 'package:audio_alarm/alarm_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import 'my_audio_logic.dart';

class MyAudioPage extends GetView<MyAudioLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Audio'),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
          child: <Widget>[
        Container(
          width: double.infinity,
          height: 50,
          child: <Widget>[
            const Icon(
              Icons.add,
              size: 24,
              color: Colors.white,
            ),
            const Text(
              'Add audio',
              style: TextStyle(color: Colors.white),
            )
          ].toRow(mainAxisAlignment: MainAxisAlignment.center),
        )
            .decorated(
                color: primaryColor, borderRadius: BorderRadius.circular(12))
            .gestures(onTap: () {
          controller.audioService.pauseAudio();
          controller.isPlaying = false;
          Get.toNamed(AlarmNames.addAudio)?.then((_) {
            controller.getData();
          });
        }),
        const SizedBox(
          height: 10,
        ),
        Expanded(
            child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          child: Obx(() {
            return controller.list.value.isEmpty
                ? const Center(
                    child: Text('No Audio'),
                  )
                : ListView.builder(
                    itemCount: controller.list.value.length,
                    itemBuilder: (_, index) {
                      final entity = controller.list.value[index];
                      return Container(
                        width: double.infinity,
                        child: <Widget>[
                          <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.memory(
                                base64Decode(entity.image),
                                width: 49,
                                height: 49,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: <Widget>[
                              Text(
                                entity.name,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                entity.createdTimeStr,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ].toColumn(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start))
                          ].toRow(),
                          Divider(
                            height: 25,
                            color: Colors.grey[300],
                          )
                        ].toColumn(),
                      ).decorated(color: Colors.transparent).gestures(
                          onTap: () {
                        if (controller.currentPlayIndex != index) {
                          controller.audioService.playAudio(entity.audioPath);
                          controller.isPlaying = true;
                          controller.currentPlayIndex = index;
                        } else {
                          if (controller.isPlaying) {
                            controller.audioService.stopAudio();
                            controller.isPlaying = false;
                            controller.currentPlayIndex = -1;
                          } else {
                            controller.audioService.playAudio(entity.audioPath);
                            controller.isPlaying = true;
                            controller.currentPlayIndex = index;
                          }
                        }
                      });
                    });
          }),
        ).decorated(
                color: Colors.white, borderRadius: BorderRadius.circular(20)))
      ].toColumn().marginAll(15)),
    );
  }
}
