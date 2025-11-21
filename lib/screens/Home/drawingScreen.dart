import 'package:flutter/material.dart';
import 'Models/category_item_model.dart';
import 'categoryDetailListScreen.dart';

class DrawingScreen extends StatelessWidget {

  final List<CategoryItem> alphabetsList = List.generate(
    26,
        (index) => CategoryItem(
      label: String.fromCharCode(65 + index), // A–Z
      imageAsset: "", // or any placeholder if needed
    ),
  );


  final List<CategoryItem> numbersList = List.generate(
    10,
        (i) => CategoryItem(
      label: i.toString(),
      imageAsset: "",
    ),
  );

  DrawingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ✅ Full screen background
          Positioned.fill(
            child: Image.asset(
              'assets/images/drawing/ic_draw_bg.png',
              fit: BoxFit.cover,
            ),
          ),

          // ✅ Main content
          SafeArea(
            child: Column(
              children: [
                // -------------------- TOP BAR --------------------
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 14),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Back button
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(
                            Icons.arrow_back,
                            size: 30,
                            color: Color(0xff6c4e32),
                          ),
                        ),
                      ),

                      const Text(
                        "Drawing",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff6c4e32),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 90),

                // -------------------- GRID BUTTONS --------------------
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children: [
                      _menuCard(
                        imagePath: "assets/images/drawing/ic_alpha.png",
                        title: "Alphabets",
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => CategoryDetailListScreen(
                                title: "Alphabets",
                                screenType: "drawing",
                                items: alphabetsList,
                              ),
                            ),
                          );
                        },
                      ),
                      _menuCard(
                        imagePath: "assets/images/drawing/ic_numbers.png",
                        title: "Numbers",
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => CategoryDetailListScreen(
                                title: "Numbers",
                                screenType: "drawing",
                                items: numbersList,
                              ),
                            ),
                          );
                        },
                      ),
                      _menuCard(
                        imagePath: "assets/images/drawing/ic_shapes.png",
                        title: "Shapes",
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => CategoryDetailListScreen(
                                title: "Shapes",
                                screenType: "drawing",
                                items: [],
                              ),
                            ),
                          );
                        },
                      ),
                      _menuCard(
                        imagePath: "assets/images/drawing/ic_colors.png",
                        title: "Colors",
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => CategoryDetailListScreen(
                                title: "Colors",
                                screenType: "drawing",
                                items: [],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // -------------------- MENU CARD WIDGET --------------------
  Widget _menuCard({
    required String imagePath,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Image.asset(
          imagePath,
          height: 145,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}