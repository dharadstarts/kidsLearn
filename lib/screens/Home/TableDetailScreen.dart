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

  // ---------- RESPONSIVE HELPERS ----------
  bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide >= 600;

  double sw(BuildContext context) => MediaQuery.of(context).size.width;
  double sh(BuildContext context) => MediaQuery.of(context).size.height;

  double rs(BuildContext context, double size) =>
      isTablet(context) ? size * 1.25 : size;
  // ---------------------------------------

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
    Color(0xFF1A3A3C),
    Color(0xFF7A1E1E),
    Color(0xFF6B5A14),
    Color(0xFF6A3E00),
    Color(0xFF3E1A55),
    Color(0xFF5A351D),
    Color(0xFF0A3A5A),
    Color(0xFF6A1030),
    Color(0xFF305C14),
    Color(0xFF3A2271),
  ];

  @override
  void initState() {
    super.initState();
    tableNumber = widget.initialTable.clamp(1, 20);
    _refreshRandoms();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      isSpeaking = true;
      await speakTable();
    });
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  void _refreshRandoms() {
    final rnd = Random();
    randomImage = cornerImages[rnd.nextInt(cornerImages.length)];
    randomBg = bgColors[rnd.nextInt(bgColors.length)];
    randomBorder = contrastColors[rnd.nextInt(contrastColors.length)];
    setState(() {});
  }

  List<String> getSpeakingTable(int number) {
    const names = [
      "one", "two", "three", "four", "five",
      "six", "seven", "eight", "nine", "ten"
    ];

    return List.generate(
      10,
          (i) => "$number ${names[i]} za ${number * (i + 1)}",
    );
  }

  Future<void> speakTable() async {
    flutterTts.setSpeechRate(0.3);
    flutterTts.setPitch(1.0);

    for (String line in getSpeakingTable(tableNumber)) {
      if (!isSpeaking) break;
      await flutterTts.speak(line);
      await Future.delayed(const Duration(seconds: 4));
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
              // ---------------- TOP BAR ----------------
              Padding(
                padding: EdgeInsets.symmetric(horizontal: rs(context, 10)),
                child: Row(
                  children: [
                    IconButton(
                      icon: SvgPicture.asset(
                        'assets/images/ic_back.svg',
                        width: rs(context, 35),
                        height: rs(context, 35),
                      ),
                      onPressed: () async {
                        isSpeaking = false;
                        await flutterTts.stop();
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
                    IconButton(
                      onPressed: () async {
                        isSpeaking = false;
                        await flutterTts.stop();
                        await Future.delayed(const Duration(seconds: 1));
                        isSpeaking = true;
                        speakTable();
                      },
                      icon: SvgPicture.asset(
                        'assets/images/drawing/ic_sound.svg',
                        width: rs(context, 40),
                        height: rs(context, 40),
                      ),
                    ),
                  ],
                ),
              ),

              // ---------------- MAIN CONTENT ----------------
              Expanded(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      width: isTablet(context)
                          ? sw(context) * 0.55
                          : sw(context) * 0.80,
                      margin: EdgeInsets.symmetric(
                        vertical: isTablet(context)
                            ? sh(context) * 0.12
                            : sh(context) * 0.05,
                      ),
                      padding: EdgeInsets.fromLTRB(
                        rs(context, 30),
                        rs(context, 40),
                        rs(context, 30),
                        rs(context, 20),
                      ),
                      decoration: BoxDecoration(
                        color: randomBg,
                        borderRadius:
                        BorderRadius.circular(rs(context, 40)),
                      ),
                      child: Column(
                        children: [
                          // TABLE NUMBER
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Text(
                                "$tableNumber",
                                style: TextStyle(
                                  fontSize: rs(context, 42),
                                  fontWeight: FontWeight.w900,
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = rs(context, 6)
                                    ..color = randomBorder,
                                ),
                              ),
                              Text(
                                "$tableNumber",
                                style: TextStyle(
                                  fontSize: rs(context, 42),
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: rs(context, 10)),

                          // TABLE LINES
                          ...List.generate(10, (i) {
                            int mul = i + 1;
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: rs(context, 3)),
                              child: Text(
                                "$tableNumber × $mul = ${tableNumber * mul}",
                                style: TextStyle(
                                  fontSize: rs(context, 20),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),

                    // CORNER IMAGE
                    Positioned(
                      top: rs(context, 10),
                      right: rs(context, 16),
                      child: Transform.rotate(
                        angle: -0.25,
                        child: Image.asset(
                          randomImage,
                          height: rs(context, 65),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ---------------- REFRESH BUTTON ----------------
              Padding(
                padding: EdgeInsets.only(
                  bottom: isTablet(context)
                      ? sh(context) * 0.08
                      : sh(context) * 0.03,
                ),
                child: IconButton(
                  onPressed: () async {
                    isSpeaking = false;
                    await flutterTts.stop();
                    _refreshRandoms();
                    await Future.delayed(const Duration(seconds: 1));
                    isSpeaking = true;
                    speakTable();
                  },
                  icon: SvgPicture.asset(
                    'assets/images/ic_refersh.svg',
                    width: rs(context, 50),
                    height: rs(context, 50),
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
