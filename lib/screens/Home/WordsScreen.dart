import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:math';

class WordsScreen extends StatefulWidget {
  final List<Map<String, String>> wordPairs;

  const WordsScreen({super.key, required this.wordPairs});

  @override
  State<WordsScreen> createState() => _WordsScreenState();
}

class _WordsScreenState extends State<WordsScreen> {
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
                    icon: Icon(Icons.arrow_back, color: Colors.black),
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
                                      child: GestureDetector(
                                        onTap: () => _speak(enWord, "en-US"),
                                        child: buildWordBox(enWord, color),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () => _speak(guWord, "gu-IN"),
                                        child: buildWordBox(guWord, color),
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