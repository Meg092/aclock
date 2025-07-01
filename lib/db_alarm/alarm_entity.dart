import 'dart:convert';

import 'package:intl/intl.dart';

class AudioEntity {
  int id;
  DateTime createdTime;
  String image;
  String name;
  String audioName;
  String audioPath;

  AudioEntity({
    required this.id,
    required this.createdTime,
    required this.image,
    required this.name,
    required this.audioName,
    required this.audioPath,
  });

  factory AudioEntity.fromJson(Map<String, dynamic> json) {
    return AudioEntity(
      id: json['id'],
      createdTime: DateTime.parse(json['createdTime']),
      image: json['image'],
      name: json['name'],
      audioName: json['audioName'],
      audioPath: json['audioPath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdTime': createdTime.toIso8601String(),
      'image': image,
      'name': name,
      'audioName': audioName,
      'audioPath': audioPath,
    };
  }

  String get createdTimeStr => DateFormat('MM/dd/yyyy').format(createdTime);
}

class AlarmEntity {
  int id;
  DateTime createdTime;
  AudioEntity audio;
  DateTime alarmTime;
  int remindType;
  String mark;
  int isRemind;

  AlarmEntity({
    required this.id,
    required this.createdTime,
    required this.audio,
    required this.alarmTime,
    required this.remindType,
    required this.mark,
    required this.isRemind,
  });

  factory AlarmEntity.fromJson(Map<String, dynamic> json) {
    return AlarmEntity(
      id: json['id'],
      createdTime: DateTime.parse(json['createdTime']),
      audio: AudioEntity.fromJson(jsonDecode(json['audio'])),
      alarmTime: DateTime.parse(json['alarmTime']),
      remindType: json['remindType'],
      mark: json['mark'],
      isRemind: json['isRemind'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdTime': createdTime.toIso8601String(),
      'audio': jsonEncode(audio.toJson()),
      'alarmTime': alarmTime.toIso8601String(),
      'remindType': remindType,
      'mark': mark,
      'isRemind': isRemind,
    };
  }

  String get alarmTimeStr => DateFormat('HH:mm').format(alarmTime);
}