import 'package:flutter/material.dart';
import '../Home/NumberItemViewScreen.dart';
import 'TableDetailScreen.dart';

class NumberScreen extends StatelessWidget {
  final bool isTableMode; // <-- FLAG FOR TABLE SCREEN

  NumberScreen({super.key, this.isTableMode = false});

  @override
  Widget build(BuildContext context) {
    final List<int> numbers =
    isTableMode ? List.generate(20, (i) => i + 1) : List.generate(76, (i) => i);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              isTableMode
                  ? "assets/images/Maths/ic_table_bg.png"    // <-- TABLE BACKGROUND
                  : "assets/images/Maths/ic_number_bg.png", // NORMAL NUMBERS BACKGROUND
            ),
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
                    Text(
                      isTableMode ? "Tables" : "Numbers",
                      style: const TextStyle(
                        color: Colors.brown,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(width: 48),
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

  // ---------- EACH NUMBER TILE ----------
  Widget _gridBox(BuildContext context, int number) {
    return GestureDetector(
      onTap: () {
        if (isTableMode) {
          // OPEN TABLE SCREEN
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TableDetailScreen(initialTable: number),
            ),
          );
        } else {
          // OPEN NUMBER DETAIL SCREEN
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => NumberItemViewScreen(initialIndex: number),
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(147, 110, 76, 1),
          border: Border.all(
            color: const Color.fromRGBO(202, 158, 126, 1),
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