import 'package:audio_alarm/main.dart';
import 'package:audio_alarm/pages/alarm_add/alarm_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import 'add_audio_logic.dart';

class AddAudioPage extends GetView<AddAudioLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add audio'),
        backgroundColor: Colors.white,
        actions: [
          Text(
            'Commit',
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
          ).marginOnly(right: 20).gestures(onTap: () {
            controller.addAudio();
          })
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: GetBuilder<AddAudioLogic>(builder: (_) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: <Widget>[
              <Widget>[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  child: <Widget>[
                    const SizedBox(
                      height: 80,
                    ),
                    SizedBox(
                      height: 40,
                      child: AlarmTextField(
                          value: controller.name,
                          textAlign: TextAlign.center,
                          maxLength: 20,
                          onChange: (v) {
                            controller.name = v;
                          }),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.grey[300],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    controller.audioName == null
                        ? Container(
                            width: 266,
                            height: 44,
                            alignment: Alignment.center,
                            child: const Text(
                              'Select file',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                            .decorated(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(8),
                          )
                            .gestures(onTap: () {
                            controller.pickAudio();
                          })
                        : Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(15),
                            child: <Widget>[
                              Image.asset(
                                'assets/icon1.webp',
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: <Widget>[
                                Text(controller.audioName!),
                                Text(controller.audioSize!,style: const TextStyle(color: Colors.grey),)
                              ].toColumn(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start)),
                              const SizedBox(
                                width: 10,
                              ),
                              const Icon(
                                Icons.close,
                                size: 25,
                                color: Colors.grey,
                              ).gestures(onTap: () {
                                controller.audioName = null;
                                controller.audioPath = null;
                                controller.audioSize = null;
                                controller.update();
                              }),
                            ].toRow(),
                          )
                            .decorated(
                                color: const Color(0xfff7f7f7),
                                borderRadius: BorderRadius.circular(10))
                            .gestures(onTap: () {
                              if (controller.isPlaying) {
                                controller.audioService.stopAudio();
                                controller.isPlaying = false;
                              } else {
                                controller.audioService.playAudio(controller.audioPath!);
                                controller.isPlaying = true;
                              }
                    }),
                    const SizedBox(
                      height: 40,
                    ),
                  ].toColumn(),
                )
                    .decorated(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    )
                    .marginOnly(top: 57),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 114,
                    height: 114,
                    child: controller.image == null
                        ? const Icon(
                            Icons.add,
                            size: 44,
                            color: Colors.grey,
                          )
                        : Image.memory(
                            controller.image!,
                            fit: BoxFit.cover,
                          ),
                  ).decorated(color: const Color(0xffe8e8e8)).gestures(
                      onTap: () {
                    controller.imageSelected();
                  }),
                )
              ].toStack(alignment: Alignment.topCenter)
            ].toColumn(),
          );
        }).marginAll(15)),
      ),
    );
  }
}
