import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class NumberItemViewScreen extends StatefulWidget {
  final int initialIndex;

  const NumberItemViewScreen({
    super.key,
    required this.initialIndex,
  });

  @override
  State<NumberItemViewScreen> createState() => _NumberItemViewScreenState();
}

class _NumberItemViewScreenState extends State<NumberItemViewScreen> {
  late int currentIndex;
  late FlutterTts flutterTts;
  bool isSpeaking = false;

  // Simple number list (0–75)
  final List<String> numbers = List.generate(76, (i) => i.toString());

  @override
  void initState() {
    super.initState();

    currentIndex = widget.initialIndex.clamp(0, numbers.length - 1);

    _initTts();
  }

  void _initTts() async {
    flutterTts = FlutterTts();
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);

    flutterTts.setCompletionHandler(() {
      setState(() => isSpeaking = false);
    });
  }

  void goPrev() {
    if (currentIndex > 0) {
      setState(() => currentIndex -= 1);
      _speak();
    }
  }

  void goNext() {
    if (currentIndex < numbers.length - 1) {
      setState(() => currentIndex += 1);
      _speak();
    }
  }

  void _speak() async {
    if (isSpeaking) await flutterTts.stop();

    setState(() => isSpeaking = true);

    final text = numbers[currentIndex];

    await flutterTts.speak(text);
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String currentNumber = numbers[currentIndex];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Color(0xFF6E4D3F)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Numbers",
          style: TextStyle(
            color: Color(0xFF6E4D3F),
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: Image.asset(
              'assets/images/categoryDetailList/ic_iteamBg.png',
              fit: BoxFit.fill,
            ),
          ),

          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // BIG NUMBER
                  Text(
                    currentNumber,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 150,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                      shadows: [
                        Shadow(
                          color: Colors.black26,
                          offset: Offset(4, 4),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _OutlinedCircleButton(
                        icon: Icons.arrow_back,
                        onPressed: currentIndex > 0 ? goPrev : null,
                      ),
                      const SizedBox(width: 24),
                      _FilledCircleButton(
                        icon: isSpeaking ? Icons.stop : Icons.volume_up,
                        onPressed: () {
                          if (isSpeaking) {
                            flutterTts.stop();
                            setState(() => isSpeaking = false);
                          } else {
                            _speak();
                          }
                        },
                      ),
                      const SizedBox(width: 24),
                      _OutlinedCircleButton(
                        icon: Icons.arrow_forward,
                        onPressed: currentIndex < numbers.length - 1 ? goNext : null,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Button Widgets
class _OutlinedCircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const _OutlinedCircleButton({required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        shape: const CircleBorder(),
        side: const BorderSide(color: Color(0xFF6E4D3F), width: 2),
        padding: const EdgeInsets.all(12),
      ),
      child: Icon(icon, color: const Color(0xFF6E4D3F), size: 32),
    );
  }
}

class _FilledCircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const _FilledCircleButton({required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.all(16),
        elevation: 4,
      ),
      child: Icon(icon, size: 28),
    );
  }
}
