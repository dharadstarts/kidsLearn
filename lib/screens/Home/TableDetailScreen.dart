import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TableDetailScreen extends StatefulWidget {
  final int initialTable;

  const TableDetailScreen({
    super.key,
    required this.initialTable,
  });

  @override
  State<TableDetailScreen> createState() => _TableDetailScreenState();
}

class _TableDetailScreenState extends State<TableDetailScreen> {
  late int tableNumber;
  final FlutterTts flutterTts = FlutterTts();
  late String randomImage;
  late Color randomBg;
  late Color randomBorder;
  bool isSpeaking = false;


  final List<String> cornerImages = [
    "assets/images/Maths/ic_book.png",
    "assets/images/Maths/ic_flower.png",
    "assets/images/Maths/ic_pen.png",
  ];

  final List<Color> bgColors = [
    Color(0xFF8EBBBD),
    Color(0xFFE6B5B5),
    Color(0xFFEDE1B1),
    Color(0xFFEDC890),
    Color(0xFFBA92C6),
    Color(0xFFCFA993),
    Color(0xFFB0DDFE),
    Color(0xFFDF98AE),
    Color(0xFFAAD094),
    Color(0xFFCEB7F1),
  ];

  final List<Color> contrastColors = [
    Color(0xFF1A3A3C), // contrast for 8EBBBD
    Color(0xFF7A1E1E), // contrast for E6B5B5
    Color(0xFF6B5A14), // contrast for EDE1B1
    Color(0xFF6A3E00), // contrast for EDC890
    Color(0xFF3E1A55), // contrast for BA92C6
    Color(0xFF5A351D), // contrast for CFA993
    Color(0xFF0A3A5A), // contrast for B0DDFE
    Color(0xFF6A1030), // contrast for DF98AE
    Color(0xFF305C14), // contrast for AAD094
    Color(0xFF3A2271), // contrast for CEB7F1
  ];

  @override
  void initState() {
    super.initState();

    tableNumber = widget.initialTable.clamp(1, 20);
    _refreshRandoms();

    // 🔥 Auto-start speaking after UI builds
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      isSpeaking = true;
      await speakTable();
    });
  }

  @override
  void dispose() {
    flutterTts.stop(); // stop speaking if active
    super.dispose();
  }

  void _refreshRandoms() {
    final rnd = Random();
    randomImage = cornerImages[rnd.nextInt(cornerImages.length)];
    randomBg = bgColors[rnd.nextInt(bgColors.length)];
    randomBorder = bgColors[rnd.nextInt(contrastColors.length)];

    setState(() {});
  }

  List<String> getSpeakingTable(int number) {
    const names = [
      "one", "two", "three", "four", "five",
      "six", "seven", "eight", "nine", "ten"
    ];

    List<String> lines = [];

    for (int i = 1; i <= 10; i++) {
      String n = names[i - 1];

      // Perfect speaking style (TTS friendly)
      lines.add("$number $n za ${number * i}");
    }

    return lines;
  }

  Future<void> speakTable() async {

    flutterTts.setSpeechRate(0.3);
    flutterTts.setPitch(1.0);

    List<String> lines = getSpeakingTable(tableNumber);

    for (String line in lines) {
      if (!isSpeaking) break;   // stop immediately if refresh pressed
      await flutterTts.speak(line);
      await Future.delayed(Duration(seconds: 2));
    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Maths/ic_table_detail_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // 🔥 TOP BAR (NO EXTRA PADDING)
              Row(
                children: [
                  IconButton(
                    icon: SvgPicture.asset(
                      'assets/images/ic_back.svg',
                      width: 35,
                      height: 35,
                    ),
                      onPressed: () async {
                        isSpeaking = false;
                        await flutterTts.stop();  // ⛔ Stop any active speech
                        Navigator.pop(context);
                      },
                  ),

                  const Expanded(
                    child: Text(
                      "Tables",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6A431D),
                      ),
                    ),
                  ),

                  // SPEAK BUTTON (SAME SIZE AS BEFORE)

                     IconButton(
                      onPressed: () async {
                        isSpeaking = false;
                        await flutterTts.stop();
                        await Future.delayed(Duration(seconds: 2));
                        isSpeaking = true;
                        speakTable();
                      },
                      icon: SvgPicture.asset(
                        'assets/images/drawing/ic_sound.svg',
                        width: 40,
                        height: 40,
                      ),
                    ),

                  const SizedBox(width: 10),
                ],
              ),


              // MAIN AREA
              Expanded(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    // MAIN TABLE CARD
                    Container(
                      width: MediaQuery.of(context).size.width * 0.72,
                      margin: const EdgeInsets.only(top: 40, bottom: 100),
                      padding: const EdgeInsets.only(
                          top: 15, left: 30, right: 30, bottom: 10),
                      decoration: BoxDecoration(
                        color: randomBg,
                        borderRadius: BorderRadius.circular(40),
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // 🔢 TABLE NUMBER (LIFTED UP HIGHER)
                          Stack(
                            children: [
                              // BORDER / STROKE
                              Text(
                                "$tableNumber",
                                style: TextStyle(
                                  fontSize: 38,
                                  fontWeight: FontWeight.w900,
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 9
                                    ..color = randomBorder,  // BORDER COLOR
                                ),
                              ),

                              // FILL / MAIN COLOR
                              Text(
                                "$tableNumber",
                                style: TextStyle(
                                  fontSize: 38,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white, // INSIDE TEXT COLOR
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 8),

                          // TABLE CONTENT
                          ...List.generate(10, (i) {
                            int mul = i + 1;
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3),
                              child: Text(
                                "$tableNumber × $mul = ${tableNumber * mul}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            );
                          }),
                        ],
                      ),
                    ),

                    // RANDOM IMAGE
                    Positioned(
                      top: 5,
                      right: 12,
                      child: Transform.rotate(
                        angle: -0.25,
                        child: Image.asset(
                          randomImage,
                          height: 65,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // REFRESH BUTTON
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                  child: IconButton(
                    onPressed: () async {
                      isSpeaking = false;          // immediately stop loop
                      await flutterTts.stop();     // stop current TTS
                      await Future.delayed(Duration(seconds: 2));
                      isSpeaking = true;
                      await speakTable();          // restart speaking
                    },
                    icon: SvgPicture.asset(
                      'assets/images/ic_refersh.svg',
                      width: 50,
                      height: 50,
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
