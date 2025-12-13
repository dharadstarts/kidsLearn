import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class SoundProvider with ChangeNotifier {
  bool _isSoundOn = true;
  AudioPlayer? _backgroundPlayer;
  AudioPlayer? _christmasPlayer;
  bool _isBackgroundPlaying = false;
  bool _isChristmasPlaying = false;

  bool get isSoundOn => _isSoundOn;
  bool get isBackgroundPlaying => _isBackgroundPlaying;
  bool get isChristmasPlaying => _isChristmasPlaying;

  SoundProvider() {
    _initPlayers();
  }

  Future<void> _initPlayers() async {
    try {
      _backgroundPlayer = AudioPlayer();
      _christmasPlayer = AudioPlayer();

      await _backgroundPlayer?.setReleaseMode(ReleaseMode.loop);
      await _christmasPlayer?.setReleaseMode(ReleaseMode.loop);

      // Set volume
      await _backgroundPlayer?.setVolume(0.7);
      await _christmasPlayer?.setVolume(0.7);
    } catch (e) {
      print('Error initializing players: $e');
    }
  }

  // Christmas music methods
  Future<void> playChristmasMusic() async {
    if (!_isSoundOn) return;

    try {
      print('Playing Christmas music from: audios/jingle_sound.mp3');

      // Stop background music if playing
      if (_isBackgroundPlaying) {
        await _backgroundPlayer?.stop();
        _isBackgroundPlaying = false;
      }

      await _christmasPlayer?.play(AssetSource('audios/jingle_sound.mp3'));
      _isChristmasPlaying = true;
      print('✓ Christmas music started');
    } catch (e) {
      print('Error playing Christmas music: $e');
    }
  }

  Future<void> stopChristmasMusic() async {
    try {
      await _christmasPlayer?.stop();
      _isChristmasPlaying = false;
      print('Christmas music stopped');
    } catch (e) {
      print('Error stopping Christmas music: $e');
    }
  }

  // Background music methods
  Future<void> playBackgroundMusic() async {
    if (!_isSoundOn) return;

    try {
      print('Playing background music from: audios/background_audio.mp3');

      // Stop Christmas music if playing
      if (_isChristmasPlaying) {
        await _christmasPlayer?.stop();
        _isChristmasPlaying = false;
      }

      await _backgroundPlayer?.play(AssetSource('audios/background_audio.mp3'));
      _isBackgroundPlaying = true;
      print('✓ Background music started');
    } catch (e) {
      print('========Error playing background music: $e');
    }
  }

  Future<void> stopBackgroundMusic() async {
    try {
      await _backgroundPlayer?.stop();
      _isBackgroundPlaying = false;
      print('Background music stopped');
    } catch (e) {
      print('========Error stopping background music: $e');
    }
  }

  // Toggle methods
  void toggleSound() {
    _isSoundOn = !_isSoundOn;
    print('Sound toggled to: $_isSoundOn');

    if (_isSoundOn) {
      // ALWAYS resume background music when turning sound ON
      playBackgroundMusic();
    } else {
      // Stop everything when sound OFF
      stopBackgroundMusic();
      stopChristmasMusic();
    }

    notifyListeners();
  }

  void setSound(bool value) {
    _isSoundOn = value;
    print('Sound set to: $_isSoundOn');

    if (value) {
      // Resume appropriate music
      if (_isBackgroundPlaying) {
        playBackgroundMusic();
      } else if (_isChristmasPlaying) {
        playChristmasMusic();
      }
    } else {
      // Stop all music
      stopBackgroundMusic();
      stopChristmasMusic();
    }

    notifyListeners();
  }

  @override
  void dispose() {
    _backgroundPlayer?.dispose();
    _christmasPlayer?.dispose();
    super.dispose();
  }
}