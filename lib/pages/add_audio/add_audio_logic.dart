import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:audio_alarm/db_alarm/db_alarm.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../audio_player_service.dart';
import '../../db_alarm/alarm_entity.dart';

class AddAudioLogic extends GetxController {

  DBAlarm dbAlarm = Get.find<DBAlarm>();

  final AudioPlayerService audioService = AudioPlayerService();
  bool isPlaying = false;

  Uint8List? image;
  String name = '';
  String? audioName;
  String? audioPath;
  String? audioSize;

  void imageSelected() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(imageQuality: 90,maxWidth: 1024,source: ImageSource.gallery);
      if (pickedFile != null) {
        final imageBytes = await pickedFile.readAsBytes();
        image = imageBytes;
        update();
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Please check album permissions or select a new image');
      return;
    }
  }

  Future<void> pickAudio() async {
    if (await Permission.storage.request().isGranted) {
      await audioService.stopAudio();
      try {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['mp3', 'wav', 'aac'],
        );
        if (result != null) {
          PlatformFile file = result.files.single;
          File localFile = File(file.path!);

          final appDir = await getApplicationDocumentsDirectory();
          String newPath = '${appDir.path}/${file.name}';
          File savedFile = await localFile.copy(newPath);
          final filePath = savedFile.path;
          final fileName = file.name;
          audioName = fileName;
          audioPath = filePath;
          if (file.size != null && file.size! > 0) {
            audioSize = '${(file.size! / 1024 / 1024).toStringAsFixed(2)} MB';
          }
          update();
        }
      } catch (e) {
        Fluttertoast.showToast(msg: 'Please check storage permissions or select a new audio');
      }
    } else {
      Fluttertoast.showToast(msg: 'Storage permission is required to select audio files');
    }
  }

  void addAudio() async {
    if (image == null) {
      Fluttertoast.showToast(msg: 'Please select image');
      return;
    }
    if (name.isEmpty) {
      Fluttertoast.showToast(msg: 'Please input name');
      return;
    }
    if (audioPath == null) {
      Fluttertoast.showToast(msg: 'Please select audio');
      return;
    }
    AudioEntity entity = AudioEntity(
      id:0,
      createdTime: DateTime.now(),
      image: base64Encode(image!),
      name: name,
      audioName: audioName!,
      audioPath: audioPath!,
    );
    await dbAlarm.insertAudio(entity);
    Get.back();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    audioService.dispose();
    super.onClose();
  }

}
