import 'package:flutter/material.dart';
import '../Home/NumberItemViewScreen.dart';

class NumberScreen extends StatelessWidget {
  final List<int> numbers = List.generate(76, (i) => i); // 0–75

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Maths/ic_number_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // ---------- TOP BAR ----------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, size: 28, color: Colors.brown),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Spacer(),
                    const Text(
                      "Numbers",
                      style: TextStyle(
                        color: Colors.brown,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(width: 48), // Balance the back button space
                  ],
                ),
              ),

              // ---------- GRID VIEW ----------
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 1.0,
                    ),
                    padding: const EdgeInsets.all(8),
                    itemCount: numbers.length,
                    itemBuilder: (context, index) {
                      return _gridBox(context, numbers[index]);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _gridBox(BuildContext context, int number) {
    return GestureDetector(
      onTap: () {
        // Navigate to NumberItemViewScreen with the selected number
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NumberItemViewScreen(
              initialNumber: number, // Changed parameter name for clarity
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(147,110,76, 100),
          border: Border.all(
            color: const Color.fromRGBO(202,158,126, 100),
            width: 8,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          number.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w900,
            shadows: [
              Shadow(
                color: Colors.black54,
                blurRadius: 2,
                offset: Offset(1, 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}