import 'package:flutter/material.dart';
import 'WordsScreen.dart'; // Make sure this import is correct

class SpellingsScreen extends StatelessWidget {
  SpellingsScreen({super.key});

  final Map<String, List<Map<String, String>>> wordCategories = {
    "Tiny Words": [
      {"en": "An", "gu": "અન"},
      {"en": "Go", "gu": "જાઓ"},
      {"en": "No", "gu": "ના"},
      {"en": "It", "gu": "તે"},
      {"en": "Is", "gu": "છે"},
      {"en": "In", "gu": "માં"},
      {"en": "Up", "gu": "ઉપર"},
      {"en": "On", "gu": "પર"},
      {"en": "At", "gu": "એ"},
      {"en": "By", "gu": "દ્વારા"},
      {"en": "He", "gu": "તે"},
      {"en": "Me", "gu": "મને"},
      {"en": "We", "gu": "અમે"},
      {"en": "So", "gu": "તેથી"},
      {"en": "To", "gu": "તે"},
      {"en": "Of", "gu": "નો"},
      {"en": "My", "gu": "મારું"},
      {"en": "Us", "gu": "અમને"},
      {"en": "Do", "gu": "કરવું"},
      {"en": "Or", "gu": "અથવા"},
      {"en": "Be", "gu": "હોઈ"},
      {"en": "If", "gu": "જો"},
      {"en": "As", "gu": "તરીકે"},
      {"en": "Am", "gu": "હું છું"},
    ],
    "Small Words": [
      {"en": "Cat", "gu": "બિલાડી"},
      {"en": "Dog", "gu": "કૂતરો"},
      {"en": "Bat", "gu": "બેટ"},
      {"en": "Rat", "gu": "ઉંદર"},
      {"en": "Sun", "gu": "સૂર્ય"},
      {"en": "Cup", "gu": "કપ"},
      {"en": "Pen", "gu": "પેન"},
      {"en": "Hen", "gu": "હેન"},
      {"en": "Hat", "gu": "ટોપી"},
      {"en": "Car", "gu": "કાર"},
      {"en": "Bag", "gu": "બેગ"},
      {"en": "Cap", "gu": "કેપ"},
      {"en": "Map", "gu": "નકશો"},
      {"en": "Top", "gu": "ટોપ"},
      {"en": "Lap", "gu": "લેપ"},
      {"en": "Red", "gu": "લાલ"},
      {"en": "Net", "gu": "નેટ"},
      {"en": "Jet", "gu": "જેટ"},
      {"en": "Fan", "gu": "ફેન"},
      {"en": "Bed", "gu": "પથારી"},
      {"en": "Men", "gu": "પુરુષો"},
      {"en": "Pet", "gu": "પાળતુ પ્રાણી"},
      {"en": "Pan", "gu": "પેન"},
      {"en": "Kit", "gu": "કિટ"},
      {"en": "Bit", "gu": "બીટ"},
      {"en": "Hit", "gu": "હિટ"},
      {"en": "Fit", "gu": "ફિટ"},
      {"en": "Sit", "gu": "બેસવું"},
      {"en": "Log", "gu": "લોગ"},
      {"en": "Fog", "gu": "ધુમ્મસ"},
      {"en": "Mug", "gu": "મગ"},
      {"en": "Bus", "gu": "બસ"},
      {"en": "Run", "gu": "દોડવું"},
      {"en": "Gum", "gu": "ગમ"},
      {"en": "Fun", "gu": "મજા"},
      {"en": "Can", "gu": "કરી શકે"},
      {"en": "Mat", "gu": "ચટાઈ"},
      {"en": "Fat", "gu": "ચરબી"},
    ],
    "Little Words": [
      {"en": "Book", "gu": "પુસ્તક"},
      {"en": "Door", "gu": "દરવાજો"},
      {"en": "Fish", "gu": "માછલી"},
      {"en": "Rain", "gu": "વરસાદ"},
      {"en": "Tree", "gu": "વૃક્ષ"},
      {"en": "Frog", "gu": "દેડકો"},
      {"en": "Ball", "gu": "બોલ"},
      {"en": "Milk", "gu": "દૂધ"},
      {"en": "Bell", "gu": "ઘંટ"},
      {"en": "Hand", "gu": "હાથ"},
      {"en": "Ship", "gu": "જહાજ"},
      {"en": "Moon", "gu": "ચંદ્ર"},
      {"en": "Sand", "gu": "રેતી"},
      {"en": "Gold", "gu": "સોનું"},
      {"en": "Ring", "gu": "રિંગ"},
      {"en": "King", "gu": "રાજા"},
      {"en": "Lion", "gu": "સિંહ"},
      {"en": "Star", "gu": "તારો"},
      {"en": "Fire", "gu": "આગ"},
      {"en": "Snow", "gu": "બરફ"},
      {"en": "Rock", "gu": "ખડક"},
      {"en": "Wind", "gu": "પવન"},
      {"en": "Dust", "gu": "ધૂળ"},
      {"en": "Seed", "gu": "બીજ"},
      {"en": "Wood", "gu": "લાકડું"},
      {"en": "Song", "gu": "ગીત"},
      {"en": "Swan", "gu": "હંસ"},
      {"en": "Cake", "gu": "કેક"},
      {"en": "Lake", "gu": "સરોવર"},
      {"en": "Home", "gu": "ઘર"},
      {"en": "Farm", "gu": "ખેતર"},
      {"en": "Road", "gu": "રસ્તો"},
      {"en": "Rice", "gu": "ચોખા"},
      {"en": "Bird", "gu": "પક્ષી"},
      {"en": "Nest", "gu": "માળો"},
      {"en": "Bear", "gu": "રીંછ"},
      {"en": "Worm", "gu": "કીડું"},
      {"en": "Wolf", "gu": "ભેડીયો"},
      {"en": "Doll", "gu": "ગુડિયું"},
      {"en": "Pear", "gu": "નાશપતી"},
      {"en": "Rose", "gu": "ગુલાબ"},
      {"en": "Corn", "gu": "મકાઈ"},
      {"en": "Wine", "gu": "વાઇન"},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 🌤 FADED BACKGROUND IMAGE
          Positioned.fill(
            child: Image.asset(
              "assets/images/spellings/ic_spellings_bg.png",
              fit: BoxFit.cover,
            ),
          ),

          /// MAIN CONTENT
          SafeArea(
            child: Column(
              children: [
                /// 🔙 BACK + TITLE + ICON
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.arrow_back, size: 28, color: Colors.brown),
                        ),
                      ),

                      /// SCREEN TITLE
                      const Text(
                        "Spellings",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.brown,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                /// GRID CONTENT (TAP BOXES)
                Expanded(
                  child: GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    childAspectRatio: 0.95,
                    children: [
                      buildWordBox(
                        context,
                        label: "Tiny Words",
                        subtitle: "(2 Character)",
                        bgColor: const Color(0xFFE6B5B5),
                        icon: "assets/images/spellings/ic_abc.png",
                      ),
                      buildWordBox(
                        context,
                        label: "Small Words",
                        subtitle: "(3 Character)",
                        bgColor: const Color(0xFFCEB7F1),
                        icon: "assets/images/spellings/ic_abc.png",
                      ),
                      buildWordBox(
                        context,
                        label: "Little Words",
                        subtitle: "(4 Character)",
                        bgColor: const Color(0xFFAAD094),
                        icon: "assets/images/spellings/ic_abc.png",
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 🛑 REUSABLE TAPPABLE BOX
  Widget buildWordBox(
      BuildContext context, {
        required String label,
        required String subtitle,
        required Color bgColor,
        required String icon,
      }) {
    return GestureDetector(
      onTap: () {
        // Get the word list for this category
        final words = wordCategories[label] ?? [];

        // Navigate to WordsScreen with the appropriate word list
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => WordsScreen(wordPairs: words), // Pass the words
          ),
        );
      },
      child: Column(
        children: [
          Container(
            height: 105,
            width: 105,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFF5D4435), width: 1),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Image.asset(
                  icon,
                  height: 55,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w700, color: Colors.brown),
          ),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 12, color: Colors.brown),
          ),
        ],
      ),
    );
  }
}