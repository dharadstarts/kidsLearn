import 'package:flutter/material.dart';

class NumberScreen extends StatelessWidget {
  final List<int> numbers = List.generate(74, (i) => i); // 0–73

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
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, size: 28, color: Colors.brown),
                    ),
                    const Spacer(),
                    const Text(
                      "Number",
                      style: TextStyle(
                        color: Colors.brown,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),

              // ---------- GRID VIEW WITH 4 COLUMNS ----------
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: GridView.count(
                    crossAxisCount: 4, // This ensures exactly 4 items per row
                    crossAxisSpacing: 20, // horizontal spacing
                    mainAxisSpacing: 20, // vertical spacing
                    childAspectRatio: 1.0, // square items
                    padding: const EdgeInsets.all(8),
                    children: numbers.map((num) {
                      return _gridBox(num);
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================
  //      GRID BOX WIDGET
  // ==========================
  Widget _gridBox(int number) {
    return GestureDetector(
      onTap: () {
        print("Tapped $number");
      },
      child: Container(
        width: 45, // Reduced width
        height: 45,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(147,110,76, 100),
          border: Border.all(
            color: const Color.fromRGBO(202,158,126, 100),
            width: 8,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          "$number",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}