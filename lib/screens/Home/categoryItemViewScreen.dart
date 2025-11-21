import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Models/category_item_model.dart';
import 'package:flutter_tts/flutter_tts.dart';

class CategoryItemViewScreen extends StatefulWidget {
  final String title; // e.g., Alphabets
  final List<CategoryItem> items;
  final int initialIndex;


  const CategoryItemViewScreen({
    super.key,
    required this.title,
    required this.items,
    required this.initialIndex,

  });

  @override
  State<CategoryItemViewScreen> createState() => _CategoryItemViewScreenState();
}

class _CategoryItemViewScreenState extends State<CategoryItemViewScreen> {
  late int currentIndex;
  late FlutterTts flutterTts;
  bool isSpeaking = false;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex.clamp(0, widget.items.length - 1);
    _initTts();
  }

  void _initTts() async {
    flutterTts = FlutterTts();

    // Configure TTS for both Android and iOS
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.5); // Slightly slower for clarity
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);

    // Set completion handler
    flutterTts.setCompletionHandler(() {
      setState(() {
        isSpeaking = false;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        isSpeaking = false;
      });
    });
  }

  void goPrev() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex -= 1;
      });
      _speakCurrentItem();
    }
  }

  void goNext() {
    if (currentIndex < widget.items.length - 1) {
      setState(() {
        currentIndex += 1;
      });
      _speakCurrentItem();
    }
  }

  void _speakCurrentItem() async {
    if (isSpeaking) {
      await flutterTts.stop();
    }

    setState(() {
      isSpeaking = true;
    });

    final CategoryItem current = widget.items[currentIndex];
    final String letter = current.label.isNotEmpty ? current.label[0].toUpperCase() : '';
    final String word = current.label;
    if (widget.title == 'Alphabets') {
      // Speak letter first
      await flutterTts.speak(letter);
      // Wait for 2 seconds pause
      await Future.delayed(const Duration(seconds: 1));
      // Then speak "A for Apple" format
      await flutterTts.speak("$letter for $word");
    } else {
      await flutterTts.speak("$word");
    }
  }

  void _speakWithPause() async {
    if (isSpeaking) {
      await flutterTts.stop();
    }

    setState(() {
      isSpeaking = true;
    });

    final CategoryItem current = widget.items[currentIndex];
    final String letter = current.label.isNotEmpty ? current.label[0].toUpperCase() : '';
    final String word = current.label;

    try {
      // Speak just the letter first (e.g., "A")
      if (widget.title == 'Alphabets') {
        await flutterTts.speak(letter);

        // Wait for the letter to finish + 2 seconds pause
        await Future.delayed(const Duration(seconds: 2));

        // Then speak the full phrase (e.g., "A for Apple")
        await flutterTts.speak("$letter for $word");
      } else {
        await flutterTts.speak("$word");
      }


    } catch (e) {
      setState(() {
        isSpeaking = false;
      });
    }
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CategoryItem current = widget.items[currentIndex];
    final String bigLetter = current.label.isNotEmpty ? current.label[0].toUpperCase() : '';
    final bool shouldShowBigLetter = widget.title.trim().toLowerCase().contains('alphabet');

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(CupertinoIcons.back, color: const Color(0xFF6E4D3F)),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Text(
          widget.title,
          style: const TextStyle(
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Big Letter with shadow (only for Alphabets); otherwise keep vertical spacing
                        shouldShowBigLetter
                            ? Text(
                          bigLetter,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 120,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            shadows: [
                              Shadow(
                                color: Colors.black26,
                                offset: Offset(4, 4),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                        )
                            : const SizedBox(height: 85),
                        const SizedBox(height: 2),
                        // Image with soft drop shadow
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: SizedBox(
                            height: constraints.maxHeight * 0.27,
                            child: Stack(
                              children: [
                                Image.asset(
                                  current.imageAsset,
                                  fit: BoxFit.contain,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: shouldShowBigLetter ? 16 : 45),
                        // Spelling/Label with subtle shadow
                        Text(
                          current.label,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
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
                        SizedBox(height: shouldShowBigLetter ? 16 : 45),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _OutlinedCircleButton(
                              icon: Icons.arrow_back,
                              onPressed: currentIndex > 0 ? goPrev : null,
                            ),
                            const SizedBox(width: 24),
                            _FilledCircleButton(
                              icon: isSpeaking ? Icons.stop : Icons.refresh_sharp,
                              onPressed: () {
                                if (isSpeaking) {
                                  flutterTts.stop();
                                  setState(() {
                                    isSpeaking = false;
                                  });
                                } else {
                                  _speakWithPause();
                                }
                              },
                            ),
                            const SizedBox(width: 24),
                            _OutlinedCircleButton(
                              icon: Icons.arrow_forward,
                              onPressed: currentIndex < widget.items.length - 1 ? goNext : null,
                            ),
                          ],
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