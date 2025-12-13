import 'package:audioplayers/audioplayers.dart';

class SoundManager {
  static final SoundManager _instance = SoundManager._internal();
  factory SoundManager() => _instance;

  SoundManager._internal();

  AudioPlayer? _player;
  bool isPlaying = false;
  bool _isInitialized = false;

  Future<void> _initialize() async {
    if (!_isInitialized) {
      _player = AudioPlayer();
      await _player?.setReleaseMode(ReleaseMode.loop);
      await _player?.setVolume(0.5); // Set volume (0.0 to 1.0)
      _isInitialized = true;
    }
  }

  Future<void> playBackgroundMusic() async {
    await _initialize();

    if (!isPlaying) {
      try {
        await _player?.play(AssetSource('background_audio.mp3'));
        isPlaying = true;
      } catch (e) {
        print('Error playing music: $e');
      }
    }
  }

  Future<void> stopBackgroundMusic() async {
    await _initialize();

    if (isPlaying) {
      await _player?.stop();
      isPlaying = false;
    }
  }

  Future<void> toggleMusic() async {
    await _initialize();

    if (isPlaying) {
      await stopBackgroundMusic();
    } else {
      await playBackgroundMusic();
    }
  }

  Future<void> setVolume(double volume) async {
    await _initialize();
    await _player?.setVolume(volume);
  }

  bool get musicStatus => isPlaying;

  void dispose() {
    _player?.dispose();
    _player = null;
    _isInitialized = false;
    isPlaying = false;
  }
}