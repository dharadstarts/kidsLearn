import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../Auth/customLaunchScreen.dart';

class ChristmasLaunchScreen extends StatefulWidget {
  const ChristmasLaunchScreen({super.key});

  @override
  State<ChristmasLaunchScreen> createState() => _ChristmasLaunchScreenState();
}

class _ChristmasLaunchScreenState extends State<ChristmasLaunchScreen> {
  bool animate = false;
  late AudioPlayer audioPlayer;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();

    // Check date validation first
    if (!_shouldShowChristmasScreen()) {
      // If date is after Jan 1, 2026, navigate directly to custom launch screen
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const customLaunchScreen()),
        );
      });
      return;
    }

    // Initialize audio player and start animation
    audioPlayer = AudioPlayer();

    // Set up player state listeners
    audioPlayer.onPlayerComplete.listen((event) {
      print("Audio completed");
    });


    audioPlayer.onPlayerStateChanged.listen((state) {
      print("Player state: $state");
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    startTheAnimation();
    playChristmasMusic();
  }

  bool _shouldShowChristmasScreen() {
    final DateTime now = DateTime.now();
    final DateTime expiryDate = DateTime(2026, 1, 1); // January 1, 2026
    return now.isBefore(expiryDate);
  }

  Future<void> playChristmasMusic() async {
    try {
      print("Attempting to play audio...");

      // Try different path formats
      await audioPlayer.play(AssetSource('audios/jingle_sound.mp3'));

      print("Audio play command sent successfully");

      // Wait a bit and check state
      await Future.delayed(Duration(milliseconds: 500));

      if (!isPlaying) {
        print("Audio didn't start playing, trying alternative method...");
        await _playAudioWithAlternativeMethod();
      }

    } catch (e) {
      print('Error playing music: $e');
      // Try alternative method if first fails
      await _playAudioWithAlternativeMethod();
    }
  }

  Future<void> _playAudioWithAlternativeMethod() async {
    try {
      // Alternative 1: Try without 'assets/' prefix
      await audioPlayer.play(AssetSource('jingle_sound.mp3'));

      // Set volume and loop
      await audioPlayer.setVolume(0.9);
      await audioPlayer.setReleaseMode(ReleaseMode.loop);

      print("Alternative method - Audio play attempted");
    } catch (e) {
      print('Alternative method also failed: $e');
    }
  }

  Future<void> stopMusic() async {
    try {
      await audioPlayer.stop();
      print("Music stopped");
    } catch (e) {
      print('Error stopping music: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_shouldShowChristmasScreen()) {
      return const Scaffold(body: SizedBox());
    }

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: AnimatedOpacity(
              opacity: animate ? 1 : 0,
              duration: Duration(seconds: 2),
              curve: Curves.easeInOut,
              child: Image(
                image: AssetImage('assets/images/ic_christmas_splsh.jpg'),
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),

        ],
      ),
    );
  }

  Future<void> startTheAnimation() async {
    await Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        animate = true;
      });
    });

    await Future.delayed(Duration(milliseconds: 8000), () async {
      await stopMusic();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const customLaunchScreen()),
      );
    });
  }

  @override
  void dispose() {
    stopMusic();
    audioPlayer.dispose();
    super.dispose();
  }
}