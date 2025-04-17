import 'package:just_audio/just_audio.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;

  final AudioPlayer _player = AudioPlayer();

  AudioService._internal();

  Future<void> init() async {
    await _player.setVolume(1.0);
  }

  Future<void> play(String assetPath) async {
    await _player.setAsset(assetPath);
    await _player.play();
  }

  Future<void> stop() async => _player.stop();

  bool get isPlaying => _player.playing;

  Stream<Duration> get positionStream => _player.positionStream;

  AudioPlayer get player => _player;

  void dispose() {
    _player.dispose();
  }
}
