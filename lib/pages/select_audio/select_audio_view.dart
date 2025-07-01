import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import 'select_audio_logic.dart';

class SelectAudioPage extends GetView<SelectAudioLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Audio'),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
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
                                  crossAxisAlignment: CrossAxisAlignment.start))
                        ].toRow(),
                        Divider(
                          height: 25,
                          color: Colors.grey[300],
                        )
                      ].toColumn(),
                    ).decorated(color: Colors.transparent).gestures(onTap: () {
                        Get.back(result: entity);
                    });
                  });
        }),
      ).decorated(
              color: Colors.white, borderRadius: BorderRadius.circular(20)).marginAll(15)),
    );
  }
}
