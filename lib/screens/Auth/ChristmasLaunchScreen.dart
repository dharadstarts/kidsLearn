import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../SoundManager/SoundProvider.dart';
import '../Auth/customLaunchScreen.dart';

class ChristmasLaunchScreen extends StatefulWidget {
  const ChristmasLaunchScreen({super.key});

  @override
  State<ChristmasLaunchScreen> createState() => _ChristmasLaunchScreenState();
}

class _ChristmasLaunchScreenState extends State<ChristmasLaunchScreen> {
  bool animate = false;

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

    // Start animation and play Christmas music
    startTheAnimation();
  }

  bool _shouldShowChristmasScreen() {
    final DateTime now = DateTime.now();
    final DateTime expiryDate = DateTime(2026, 1, 1);
    return now.isBefore(expiryDate);
  }

  Future<void> startTheAnimation() async {
    // Get sound provider and play Christmas music
    final soundProvider = Provider.of<SoundProvider>(context, listen: false);

    await Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        animate = true;
      });
    });

    // Play Christmas music
    soundProvider.playChristmasMusic();

    // Navigate after delay
    await Future.delayed(Duration(milliseconds: 8000), () async {
      // Stop Christmas music before navigating
      soundProvider.stopChristmasMusic();

      // Start background music for the main app
      soundProvider.playBackgroundMusic();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const customLaunchScreen()),
      );
    });
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
}