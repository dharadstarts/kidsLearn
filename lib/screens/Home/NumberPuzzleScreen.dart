import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NumberPuzzleScreen extends StatefulWidget {
  const NumberPuzzleScreen({super.key});

  @override
  State<NumberPuzzleScreen> createState() => _NumberPuzzleScreenState();
}

class _NumberPuzzleScreenState extends State<NumberPuzzleScreen> {
  /// Current puzzle state
  List<String?> numbers = ["3", null, "5", "1", "4", "7", "6", "2", "8"];

  /// Correct solved order
  final List<String?> solved = ["1", "2", "3", "4", "5", "6", "7", "8", null];

  /// TAP → Move tile if possible
  void onTileTap(int index) {
    int emptyIndex = numbers.indexOf(null);

    /// Allowed moves for each index
    List<List<int>> validMoves = [
      [1, 3],       // index 0
      [0, 2, 4],    // index 1
      [1, 5],       // index 2
      [0, 4, 6],    // index 3
      [1, 3, 5, 7], // index 4
      [2, 4, 8],    // index 5
      [3, 7],       // index 6
      [4, 6, 8],    // index 7
      [5, 7],       // index 8
    ];

    /// Check valid move
    if (validMoves[index].contains(emptyIndex)) {
      setState(() {
        numbers[emptyIndex] = numbers[index];
        numbers[index] = null;
      });

      checkPuzzleSolved();
    }
  }

  /// Check if puzzle matches solved pattern
  void checkPuzzleSolved() {
    if (numbers.join() == solved.join()) {
      Fluttertoast.showToast(
        msg: "🎉 Puzzle Solved!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    }
  }

  bool puzzleCompleted = false; // ADD THIS ABOVE BUILD()

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        /// FULL SCREEN BACKGROUND
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Puzzle/ic_puzzle_pg.png"),
            fit: BoxFit.fitHeight,
          ),
        ),

        child: SafeArea(
          child: Column(
            children: [
              /// TOP BAR
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, size: 30, color: Colors.brown),
                    ),
                    const Spacer(),
                    const Text(
                      "Number Puzzle",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(116,74,37,100),
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(width: 30)
                  ],
                ),
              ),

              const SizedBox(height: 55),

              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 35, right: 35),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: numbers.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => onTileTap(index),
                        child: _buildPuzzleCircle(numbers[index]),
                      );
                    },
                  ),
                ),
              ),


              /// SHOW RESET ONLY WHEN PUZZLE COMPLETES
                GestureDetector(
                  onTap: () {
                    setState(() {
                      numbers = ["3", null, "5", "1", "4", "7", "6", "2", "8"];
                      puzzleCompleted = false;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.brown.shade700,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      "RESET",
                      style: TextStyle(
                        color: Color.fromRGBO(247,242,237,100),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 240),
            ],
          ),
        ),
      ),
    );
  }


  /// Puzzle circle widget
  Widget _buildPuzzleCircle(String? number) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          "assets/images/Puzzle/ic_puzzle.png",
          width: 70,
          height: 70,
        ),

        number != null
            ? Text(
          number,
          style: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Color(0xff4B2E2E),
          ),
        )
            : const SizedBox(),
      ],
    );
  }
}
