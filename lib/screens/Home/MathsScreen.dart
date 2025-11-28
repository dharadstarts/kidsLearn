import 'package:flutter/material.dart';
import 'package:kids_learn/screens/Home/NumberScreen.dart';

class MathsScreen extends StatelessWidget {
  const MathsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// FULL SCREEN BACKGROUND IMAGE
          Positioned.fill(
            child: Image.asset(
              "assets/images/Maths/ic_math_bg.png",
              fit: BoxFit.cover,
            ),
          ),

          /// MAIN CONTENT
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                /// TOP BAR
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      /// BACK ICON
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(
                            Icons.arrow_back,
                            size: 28,
                            color: Colors.brown,
                          ),
                        ),
                      ),

                      /// TITLE
                      const Text(
                        "Maths",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.brown,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 70),

                /// ----------- NUMBERS CARD WITH BG IMAGE -----------
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NumberScreen(),
                        ),
                      );
                    },
                    child: Container(
                      height: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: const DecorationImage(
                          image:
                          AssetImage("assets/images/Maths/ic_card1.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Stack(
                        children: [
                          /// TEXT
                          const Positioned(
                            left: 20,
                            top: 35,
                            child: Text(
                              "Numbers",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                                color: Colors.brown,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                /// ----------- TABLES CARD WITH BG IMAGE -----------
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: const DecorationImage(
                          image:
                          AssetImage("assets/images/Maths/ic_card2.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Stack(
                        children: [
                          /// TEXT
                          const Positioned(
                            left: 20,
                            top: 35,
                            child: Text(
                              "Tables",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                                color: Colors.brown,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const Spacer(),
                const SizedBox(height: 10),
              ],
            ),
          )
        ],
      ),
    );
  }
}
