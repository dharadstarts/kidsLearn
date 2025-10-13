import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Home/homeScreen.dart';

class customLaunchScreen extends StatefulWidget {
  const customLaunchScreen({super.key});

  @override
  State<customLaunchScreen> createState() => _customLaunchScreenState();
}

class _customLaunchScreenState extends State<customLaunchScreen>  with SingleTickerProviderStateMixin {
  bool animate = false;

  @override @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTheAnimation();
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
                  image: AssetImage('assets/images/ic_splash1.png'),
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
    await Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        animate = true;
      });
    });
    await Future.delayed(Duration(milliseconds: 4000),() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }
}


