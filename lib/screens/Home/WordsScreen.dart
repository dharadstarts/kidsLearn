import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:math';

class WordsScreen extends StatefulWidget {
  final List<Map<String, String>> wordPairs;

  const WordsScreen({super.key, required this.wordPairs});

  @override
  State<WordsScreen> createState() => _WordsScreenState();
}

class _WordsScreenState extends State<WordsScreen> {
  int? pressedIndex;
  final FlutterTts flutterTts = FlutterTts();

  final List<Color> colors = [
    Color(0xFFCEB7F1), // #ceb7f1
    Color(0xFFB3E2D2), // #b3e2d2
    Color(0xFFB3D8F1), // #b3d8f1
    Color(0xFFE6B5B5), // #e6b5b5
    Color(0xFFF7DFF1), // #f7dff1
    Color(0xFFCBD5E1), // #cbd5e1
  ];


  @override
  void initState() {
    super.initState();
    widget.wordPairs.shuffle(Random());
  }

  Future<void> _speak(String text, String lang) async {
    await flutterTts.setLanguage(lang);
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F4EF),
      body: Stack(
        children: [
          /// 🌤 FULL BACKGROUND IMAGE
          Positioned.fill(
            child: Image.asset(
              "assets/images/spellings/ic_words_bg.png", // Use your background image path
              fit: BoxFit.fitHeight,
            ),
          ),

          /// MAIN CONTENT
          SafeArea(
            child: Column(
              children: [
                /// APP BAR
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: IconButton(
                    icon: SvgPicture.asset(
                      'assets/images/ic_back.svg',
                      width: 35,
                      height: 35,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  title: Column(
                    children: const [
                      Text("Tiny Words",
                          style: TextStyle(fontSize: 16, color: Colors.black)),
                      Text(
                        "(2 Character)",
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                    ],
                  ),
                  centerTitle: true,
                ),

                /// CONTENT AREA
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            buildTab("English", true),
                            const SizedBox(width: 12),
                            buildTab("Gujarati", false),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: ListView.builder(
                            itemCount: widget.wordPairs.length,
                            itemBuilder: (context, index) {
                              final enWord = widget.wordPairs[index]["en"]!;
                              final guWord = widget.wordPairs[index]["gu"]!;
                              final color = colors[index % colors.length];

                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(12),
                                        onTapDown: (_) {
                                          setState(() => pressedIndex = index * 2);
                                        },
                                        onTapUp: (_) {
                                          setState(() => pressedIndex = null);
                                          _speak(enWord, "en-US");
                                        },
                                        onTapCancel: () {
                                          setState(() => pressedIndex = null);
                                        },
                                        child: AnimatedContainer(
                                          duration: const Duration(milliseconds: 280),
                                          curve: Curves.bounceIn,
                                          padding: const EdgeInsets.symmetric(vertical: 12),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12),
                                            gradient: pressedIndex == index * 2
                                                ? LinearGradient(
                                              begin: Alignment.topRight,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                color.withOpacity(0.95),
                                                color.withOpacity(0.65),
                                              ],
                                            )
                                                : null,
                                            color: pressedIndex == index * 2 ? null : color,
                                          ),
                                          child: Text(
                                            enWord,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(12),
                                        onTapDown: (_) {
                                          setState(() => pressedIndex = index * 2 + 1);
                                        },
                                        onTapUp: (_) {
                                          setState(() => pressedIndex = null);
                                          _speak(guWord, "gu-IN");
                                        },
                                        onTapCancel: () {
                                          setState(() => pressedIndex = null);
                                        },
                                        child: AnimatedContainer(
                                          duration: const Duration(milliseconds: 280),
                                          curve: Curves.bounceIn,
                                          padding: const EdgeInsets.symmetric(vertical: 12),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12),
                                            gradient: pressedIndex == index * 2 + 1
                                                ? LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                color.withOpacity(0.85),
                                                color.withOpacity(0.55),
                                              ],
                                            )
                                                : null,
                                            color: pressedIndex == index * 2 + 1 ? null : color,
                                          ),
                                          child: Text(
                                            guWord,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTab(String label, bool active) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black),
        ),
        alignment: Alignment.center,
        child: Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black)),
      ),
    );
  }

  Widget buildWordBox(String text, Color background) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }
}