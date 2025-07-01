import 'package:audio_alarm/db_alarm/db_alarm.dart';
import 'package:audio_alarm/pages/add_audio/add_audio_binding.dart';
import 'package:audio_alarm/pages/add_audio/add_audio_view.dart';
import 'package:audio_alarm/pages/alarm_add/alarm_add_binding.dart';
import 'package:audio_alarm/pages/alarm_add/alarm_add_view.dart';
import 'package:audio_alarm/pages/alarm_first/alarm_first_binding.dart';
import 'package:audio_alarm/pages/alarm_first/alarm_first_view.dart';
import 'package:audio_alarm/pages/alarm_second/alarm_second_binding.dart';
import 'package:audio_alarm/pages/alarm_second/alarm_second_view.dart';
import 'package:audio_alarm/pages/alarm_tab/alarm_tab_binding.dart';
import 'package:audio_alarm/pages/alarm_tab/alarm_tab_view.dart';
import 'package:audio_alarm/pages/broken_page/broken_page_binding.dart';
import 'package:audio_alarm/pages/broken_page/broken_page_view.dart';
import 'package:audio_alarm/pages/my_audio/my_audio_binding.dart';
import 'package:audio_alarm/pages/my_audio/my_audio_view.dart';
import 'package:audio_alarm/pages/remind_details/remind_details_binding.dart';
import 'package:audio_alarm/pages/remind_details/remind_details_view.dart';
import 'package:audio_alarm/pages/select_audio/select_audio_binding.dart';
import 'package:audio_alarm/pages/select_audio/select_audio_view.dart';
import 'package:audio_alarm/alarm_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Color primaryColor = const Color(0xff4e64ff);
Color bgColor = const Color(0xfff4f4f4);

final titles = ["Every day", "Once", "Saturday", "Sunday"];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => DBAlarm().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: AFS,
      initialRoute: AlarmNames.alarmTab,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: bgColor,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        cardTheme: const CardTheme(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        dialogTheme: const DialogTheme(
          actionsPadding: EdgeInsets.only(right: 10, bottom: 5),
        ),
        dividerTheme: DividerThemeData(
          thickness: 1,
          color: Colors.grey[200],
        ),
      ),
    );
  }
}
List<GetPage<dynamic>> AFS = [
  GetPage(name: AlarmNames.alarmAdd, page: () => AlarmAddPage(), binding: AlarmAddBinding()),
  GetPage(name: AlarmNames.alarmFirst, page: () => AlarmFirstPage(), binding: AlarmFirstBinding()),
  GetPage(name: AlarmNames.alarmSecond, page: () => AlarmSecondPage(), binding: AlarmSecondBinding()),
  GetPage(name: AlarmNames.alarmTab, page: () => AlarmTabPage(), binding: AlarmTabBinding()),
  GetPage(name: AlarmNames.brokenPage, page: () => const BrokenPageView(), binding: BrokenPageBinding()),
  GetPage(name: AlarmNames.addAudio, page: () => AddAudioPage(), binding: AddAudioBinding()),
  GetPage(name: AlarmNames.myAudio, page: () => MyAudioPage(), binding: MyAudioBinding()),
  GetPage(name: AlarmNames.remindDetails, page: () => RemindDetailsPage(), binding: RemindDetailsBinding()),
  GetPage(name: AlarmNames.selectAudio, page: () => SelectAudioPage(), binding: SelectAudioBinding())
];