import 'package:flutter/material.dart';
import 'package:kids_learn/screens/Auth/ChristmasLaunchScreen.dart';
import 'package:kids_learn/screens/Auth/customLaunchScreen.dart';
import 'package:provider/provider.dart';
import 'package:kids_learn/screens/SoundManager/SoundProvider.dart'; // Create this file
import 'package:audioplayers/audioplayers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Configure audio for better performance
  AudioPlayer.global.setAudioContext(
     AudioContext(
      android: AudioContextAndroid(
        contentType: AndroidContentType.music,
        usageType: AndroidUsageType.media,
        audioFocus: AndroidAudioFocus.gain,
      ),
      iOS: AudioContextIOS(
        category: AVAudioSessionCategory.playback,
        options: {AVAudioSessionOptions.mixWithOthers},
      ),
    ),
  );


  runApp(
    ChangeNotifierProvider(
      create: (context) => SoundProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: _getLaunchScreen(),
      ),
    ),
  );
}

Widget _getLaunchScreen() {
  final DateTime now = DateTime.now();
  final DateTime expiryDate = DateTime(2026, 1, 1); // January 1, 2026

  // Show Christmas screen only if date is before Jan 1, 2026
  if (now.isBefore(expiryDate)) {
    return ChristmasLaunchScreen();
  } else {
    return const customLaunchScreen();
  }
}