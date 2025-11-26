import 'package:flutter/material.dart';

class Tapsetdetailsscreen extends StatelessWidget {
  const Tapsetdetailsscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animal Puzzle',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: const Color(0xFFF5E6D3),
      ),
      home: const AnimalPuzzleScreen(),
    );
  }
}

class Animal {
  final String name;
  final String imagePath;
  final List<String> shuffledLetters;

  Animal({
    required this.name,
    required this.imagePath,
    required this.shuffledLetters,
  });
}

class AnimalPuzzleScreen extends StatefulWidget {
  const AnimalPuzzleScreen({Key? key}) : super(key: key);

  @override
  State<AnimalPuzzleScreen> createState() => _AnimalPuzzleScreenState();
}

class _AnimalPuzzleScreenState extends State<AnimalPuzzleScreen> {
  // Sample animal data
  final List<Animal> animals = [
    Animal(
      name: 'BEAR',
      imagePath: 'assets/images/bear.png',
      shuffledLetters: ['D', 'A', 'R', 'Q', 'C', 'B', 'H', 'E', 'G', 'Y', 'A', 'L'],
    ),
    Animal(
      name: 'ELEPHANT',
      imagePath: 'assets/images/elephant.png',
      shuffledLetters: ['E', 'L', 'P', 'H', 'A', 'N', 'T', 'X', 'R', 'K', 'M', 'S'],
    ),
    Animal(
      name: 'LION',
      imagePath: 'assets/images/lion.png',
      shuffledLetters: ['L', 'I', 'O', 'N', 'B', 'T', 'R', 'A'],
    ),
  ];

  int currentAnimalIndex = 0;
  List<String?> answerBoxes = [];
  List<bool> usedLetters = [];

  @override
  void initState() {
    super.initState();
    _initializePuzzle();
  }

  void _initializePuzzle() {
    final currentAnimal = animals[currentAnimalIndex];
    answerBoxes = List.filled(currentAnimal.name.length, null);
    usedLetters = List.filled(currentAnimal.shuffledLetters.length, false);
  }

  void _onLetterTap(int index) {
    if (usedLetters[index]) return;

    final emptyBoxIndex = answerBoxes.indexWhere((box) => box == null);
    if (emptyBoxIndex != -1) {
      setState(() {
        answerBoxes[emptyBoxIndex] = animals[currentAnimalIndex].shuffledLetters[index];
        usedLetters[index] = true;
      });
    }
  }

  void _onAnswerBoxTap(int index) {
    if (answerBoxes[index] == null) return;

    final letter = answerBoxes[index];
    final letterIndex = animals[currentAnimalIndex].shuffledLetters.indexOf(letter!);

    setState(() {
      answerBoxes[index] = null;
      if (letterIndex != -1) {
        usedLetters[letterIndex] = false;
      }
    });
  }

  void _checkAnswer() {
    final userAnswer = answerBoxes.join();
    final correctAnswer = animals[currentAnimalIndex].name;

    if (userAnswer == correctAnswer) {
      _showDialog('Correct!', 'Well done! 🎉', true);
    } else {
      _showDialog('Incorrect', 'Try again!', false);
    }
  }

  void _showDialog(String title, String message, bool isCorrect) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (isCorrect) {
                _nextAnimal();
              }
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _nextAnimal() {
    if (currentAnimalIndex < animals.length - 1) {
      setState(() {
        currentAnimalIndex++;
        _initializePuzzle();
      });
    } else {
      _showDialog('Completed!', 'You finished all puzzles!', true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentAnimal = animals[currentAnimalIndex];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, size: 28),
                    onPressed: () {},
                  ),
                  const Expanded(
                    child: Text(
                      'Animals',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6B4423),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Animal Image Card
                    Container(
                      margin: const EdgeInsets.all(20),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Animal Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              currentAnimal.imagePath,
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 200,
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.pets, size: 80),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Answer Boxes
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              answerBoxes.length,
                                  (index) => GestureDetector(
                                onTap: () => _onAnswerBoxTap(index),
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  margin: const EdgeInsets.symmetric(horizontal: 4),
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

                    // Letter Circles
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
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: usedLetters[index]
                                    ? const Color(0xFFD4B896)
                                    : const Color(0xFF8B6F47),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  currentAnimal.shuffledLetters[index],
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: usedLetters[index]
                                        ? Colors.grey[400]
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Buttons
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
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
    );
  }
}