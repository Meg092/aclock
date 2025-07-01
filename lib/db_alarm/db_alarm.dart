import 'dart:convert';
import 'package:audio_alarm/db_alarm/alarm_entity.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBAlarm extends GetxService {
  late Database dbBase;

  Future<DBAlarm> init() async {
    await createAlarmDB();
    return this;
  }

  createAlarmDB() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'alarm.db');

    dbBase = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await createAlarmTable(db);
          await createAudioTable(db);
        });
  }

  createAlarmTable(Database db) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS alarm (id INTEGER PRIMARY KEY, createdTime TEXT, audio TEXT, alarmTime TEXT, remindType INTEGER, mark TEXT, isRemind INTEGER)');
  }

  createAudioTable(Database db) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS audio (id INTEGER PRIMARY KEY, createdTime TEXT, image BLOB, name TEXT, audioName TEXT, audioPath TEXT)');
  }

  insertAlarm(AlarmEntity entity) async {
    final id = await dbBase.insert('alarm', {
      'createdTime': entity.createdTime.toIso8601String(),
      'audio': jsonEncode(entity.audio.toJson()),
      'alarmTime': entity.alarmTime.toIso8601String(),
      'remindType': entity.remindType,
      'mark': entity.mark,
      'isRemind': entity.isRemind,
    });
    return id;
  }

  updateAlarm(AlarmEntity entity) async {
    await dbBase.update('alarm', {
      'createdTime': entity.createdTime.toIso8601String(),
      'audio': jsonEncode(entity.audio.toJson()),
      'alarmTime': entity.alarmTime.toIso8601String(),
      'remindType': entity.remindType,
      'mark': entity.mark,
      'isRemind': entity.isRemind,
    }, where: 'id = ?', whereArgs: [entity.id]);
  }

  insertAudio(AudioEntity entity) async {
    final id = await dbBase.insert('audio', {
      'createdTime': entity.createdTime.toIso8601String(),
      'image': entity.image,
      'name': entity.name,
      'audioName': entity.audioName,
      'audioPath': entity.audioPath,
    });
    return id;
  }

  cleanAllData() async {
    await dbBase.delete('alarm');
    await dbBase.delete('audio');
  }

  Future<List<AlarmEntity>> getAlarmAllData() async {
    var result = await dbBase.query('alarm', orderBy: 'alarmTime ASC');
    return result.map((e) => AlarmEntity.fromJson(e)).toList();
  }

  Future<List<AudioEntity>> getAudioAllData() async {
    var result = await dbBase.query('audio', orderBy: 'createdTime DESC');
    return result.map((e) => AudioEntity.fromJson(e)).toList();
  }
}
