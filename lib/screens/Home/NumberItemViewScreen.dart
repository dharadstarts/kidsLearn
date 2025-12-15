import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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

  final List<int> numbers = List.generate(76, (i) => i); // 0–75

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
    await flutterTts.setPitch(1.0);

    flutterTts.setCompletionHandler(() {
      setState(() => isSpeaking = false);
    });

    flutterTts.setErrorHandler((msg) {
      setState(() => isSpeaking = false);
    });
  }

  void goPrev() {
    if (currentIndex > 0) {
      setState(() => currentIndex--);
      _speakWithPause();
    }
  }

  void goNext() {
    if (currentIndex < numbers.length - 1) {
      setState(() => currentIndex++);
      _speakWithPause();
    }
  }

  /// Converts number to words
  String spellNumber(int number) {
    const ones = [
      "Zero", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine",
      "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen",
      "Seventeen", "Eighteen", "Nineteen"
    ];

    const tens = [
      "", "", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy"
    ];

    if (number < 20) return ones[number];

    if (number < 100) {
      int t = number ~/ 10;
      int r = number % 10;
      return r == 0 ? tens[t] : "${tens[t]} ${ones[r]}";
    }

    return number.toString();
  }

  void _speakWithPause() async {
    if (isSpeaking) {
      await flutterTts.stop();
    }

    setState(() => isSpeaking = true);

    int number = numbers[currentIndex];
    String word = spellNumber(number);

    try {
      await Future.delayed(const Duration(seconds: 1));
      await flutterTts.speak(word);
    } catch (e) {
      setState(() => isSpeaking = false);
    }
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int number = numbers[currentIndex];
    String word = spellNumber(number);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/images/ic_back.svg',
            width: 35,
            height: 35,
          ),
          onPressed: () => Navigator.of(context).maybePop(),
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
          Positioned.fill(
            child: Image.asset(
              'assets/images/categoryDetailList/ic_iteamBg.png',
              fit: BoxFit.fill,
            ),
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    const SizedBox(height: 40),

                    /// BIG NUMBER
                    Text(
                      "$number",
                      style: const TextStyle(
                        fontSize: 120,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        shadows: [
                          Shadow(
                            color: Colors.black26,
                            offset: Offset(4, 4),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),

                    /// Spelling
                    Text(
                      word,
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        shadows: [
                          Shadow(
                            color: Colors.black26,
                            offset: Offset(2, 3),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 50),

                    /// Buttons (Prev - Speak - Next)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: currentIndex > 0 ? goPrev : null,
                          child: SvgPicture.asset(
                            'assets/images/ic_back.svg',
                            width: 30,
                            height: 30,
                          ),
                        ),
                        const SizedBox(width: 24),
                        GestureDetector(
                          onTap: () {
                            if (isSpeaking) {
                              flutterTts.stop();
                              setState(() {
                                isSpeaking = false;
                              });
                            } else {
                              _speakWithPause();
                            }
                          },
                          child:Image.asset( 'assets/ic_refersh.png',
                            width: 30,
                            height: 30,
                          ),
                        ),
                        const SizedBox(width: 24),
                        GestureDetector(
                          onTap: currentIndex < numbers.length - 1 ? goNext : null,
                          child: Image.asset(
                            'assets/ic_right_arrow.png',
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

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
      child: Icon(icon, color: const Color(0xFF6E4D3F), size: 28),
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
        padding: const EdgeInsets.all(14),
        elevation: 4,
      ),
      child: Icon(icon, size: 26),
    );
  }
}
