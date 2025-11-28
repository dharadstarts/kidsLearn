import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../Home/Data/tap_set_data.dart';

class Tapsetdetailsscreen extends StatefulWidget {
  final String title;
  final List<PuzzleItem> items;

  const Tapsetdetailsscreen({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  State<Tapsetdetailsscreen> createState() => _TapsetdetailsscreenState();
}

class _TapsetdetailsscreenState extends State<Tapsetdetailsscreen> {
  final FlutterTts tts = FlutterTts();

  int currentIndex = 0;
  List<String?> answerBoxes = [];
  List<bool> usedLetters = [];

  @override
  void initState() {
    super.initState();
    _setupTts();
    _initializePuzzle();
  }

  void _setupTts() async {
    await tts.setLanguage("en-US");
    await tts.setSpeechRate(0.4);
    await tts.setPitch(1.0);
  }

  void _initializePuzzle() {
    final currentAnimal = widget.items[currentIndex];
    answerBoxes = List.filled(currentAnimal.name.length, null);
    usedLetters = List.filled(currentAnimal.shuffledLetters.length, false);
  }

  void _onLetterTap(int index) {
    if (usedLetters[index]) return;

    final emptyIndex = answerBoxes.indexWhere((e) => e == null);

    if (emptyIndex != -1) {
      setState(() {
        answerBoxes[emptyIndex] =
        widget.items[currentIndex].shuffledLetters[index];
        usedLetters[index] = true;
      });
    }
  }

  void _onAnswerBoxTap(int index) {
    if (answerBoxes[index] == null) return;

    final letter = answerBoxes[index];
    final letterIndex =
    widget.items[currentIndex].shuffledLetters.indexOf(letter!);

    setState(() {
      answerBoxes[index] = null;
      if (letterIndex != -1) usedLetters[letterIndex] = false;
    });
  }

  void _playWord() {
    tts.speak(widget.items[currentIndex].name);
  }

  Future<void> _playSpelling() async {
    final word = widget.items[currentIndex].name;
    for (var char in word.characters) {
      await tts.speak(char);
      await Future.delayed(const Duration(milliseconds: 900));
    }
  }

  void _checkAnswer() {
    final userAnswer = answerBoxes.join();
    final correctAnswer = widget.items[currentIndex].name;

    if (answerBoxes.every((e) => e == null)) {
      tts.speak("Try again");
      return;
    }

    if (userAnswer == correctAnswer) {
      Fluttertoast.showToast(
        msg: "Good!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );

      tts.speak("Right answer");

      Future.delayed(const Duration(milliseconds: 800), () {
        _nextAnimal();
      });
    } else {
      Fluttertoast.showToast(
        msg: "Incorrect! Try again!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      tts.speak("Incorrect! Try again!");
    }
  }

  void _nextAnimal() {
    if (currentIndex < widget.items.length - 1) {
      setState(() {
        currentIndex++;
        _initializePuzzle();
      });
    } else {
      Fluttertoast.showToast(
        msg: "All puzzles complete!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );

      Future.delayed(const Duration(milliseconds: 1200), () {
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentAnimal = widget.items[currentIndex];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/TapSet/ic_tapset_deatil_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // HEADER
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, size: 28),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Text(
                        '${widget.title}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6B4423),
                        ),
                      ),
                    ),
                    const SizedBox(width: 38),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // MAIN PUZZLE BOX
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.all(12),
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/TapSet/ic_main_box.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            Wrap(
                              alignment: WrapAlignment.spaceEvenly,
                              spacing: 8,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: _playWord,
                                  icon: const Icon(Icons.volume_up),
                                  label: const Text("Word"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF6B4423),
                                    foregroundColor: Colors.white,
                                  ),
                                ),
                                ElevatedButton.icon(
                                  onPressed: _playSpelling,
                                  icon: const Icon(Icons.spellcheck),
                                  label: const Text("Spelling"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF6B4423),
                                    foregroundColor: Colors.white,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 30),

                            Image.asset(
                              currentAnimal.imagePath,
                              height: 180,
                              fit: BoxFit.contain,
                            ),

                            const SizedBox(height: 30),

                            Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 8,
                              runSpacing: 8,
                              children: List.generate(
                                answerBoxes.length,
                                    (index) => GestureDetector(
                                  onTap: () => _onAnswerBoxTap(index),
                                  child: Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFB8956A),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Text(
                                        answerBoxes[index] ?? '',
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // LETTER BUTTONS
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 12,
                          runSpacing: 12,
                          children: List.generate(
                            currentAnimal.shuffledLetters.length,
                                (index) => GestureDetector(
                              onTap: () => _onLetterTap(index),
                              child: Container(
                                width: 45,
                                height: 45,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/TapSet/ic_circle.png'),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    usedLetters[index]
                                        ? ''
                                        : currentAnimal.shuffledLetters[index],
                                    style: const TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // CHECK + NEXT BUTTONS
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: _checkAnswer,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF6B4423),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: const Text(
                                  'CHECK',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: _nextAnimal,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF6B4423),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: const Text(
                                  'NEXT',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
