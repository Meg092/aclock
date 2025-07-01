import 'package:just_audio/just_audio.dart';

class AudioPlayerService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> playAudio(String filePath) async {
    try {
      await _audioPlayer.stop();
      await _audioPlayer.setFilePath(filePath);
      await _audioPlayer.play();
    } catch (e) {
      print("Play audio error: $e");
    }
  }

  Future<void> pauseAudio() async {
    await _audioPlayer.pause();
  }

  Future<void> stopAudio() async {
    await _audioPlayer.stop();
  }

  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  Stream<PlayerState> get playerState => _audioPlayer.playerStateStream;
  Stream<Duration?> get durationStream => _audioPlayer.durationStream;
  Stream<Duration> get positionStream => _audioPlayer.positionStream;

  void dispose() {
    _audioPlayer.dispose();
  }
}