import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../SoundManager/SoundProvider.dart';
import '../Home/homeScreen.dart';

class customLaunchScreen extends StatefulWidget {
  const customLaunchScreen({Key? key}) : super(key: key);

  @override
  State<customLaunchScreen> createState() => _customLaunchScreenState();
}

class _customLaunchScreenState extends State<customLaunchScreen> {
  bool animate = false;
  @override
  void initState() {
    super.initState();
    startTheAnimation();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final soundProvider = Provider.of<SoundProvider>(context, listen: false);

      // Start background music if sound is on
      if (soundProvider.isSoundOn) {
        soundProvider.playBackgroundMusic();
      }

      // Navigate to HomeScreen after delay
      Future.delayed(Duration(seconds: 10), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: AnimatedOpacity(
                opacity: animate ? 1 : 0,
                duration: Duration(seconds: 3),
                curve: Curves.easeInOut,
                child:   Image(
                  image: AssetImage('assets/images/ic_splash1.jpg'),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              )
          )
        ],
      ),
    );
  }


  Future startTheAnimation() async {
    await Future.delayed(Duration(milliseconds: 30), () {
      setState(() {
        animate = true;
      });
    });
    await Future.delayed(Duration(seconds: 10),() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }
}