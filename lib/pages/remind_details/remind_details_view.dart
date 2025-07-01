import 'package:audio_alarm/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import 'remind_details_logic.dart';

class RemindDetailsPage extends GetView<RemindDetailsLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: <Widget>[
            const SizedBox(
              height: 50,
            ),
            Image.asset(
              'assets/bigIcon.webp',
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              controller.entity.alarmTimeStr,
              style: TextStyle(
                  fontSize: 85,
                  fontWeight: FontWeight.bold,
                  color: primaryColor),
            ),
            Text(
              controller.entity.mark,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: primaryColor),
            ),
            const SizedBox(
              height: 150,
            ),
            Container(
              width: 290,
              height: 75,
              alignment: Alignment.center,
              child: const Text(
                'Close remind',
                style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            )
                .decorated(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10))
                .gestures(onTap: () {
              Get.back();
            })
          ].toColumn(),
        ).marginAll(15)),
      ).decorated(
          gradient: const LinearGradient(
              colors: [Color(0xffd1d7ff), Color(0xfff4f4f4)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.7])),
    );
  }
}
