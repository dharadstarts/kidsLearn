import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Models/category_item_model.dart';

class CategoryItemViewScreen extends StatefulWidget {
  final String title; // e.g., Alphabets
  final List<CategoryItem> items;
  final int initialIndex;

  const CategoryItemViewScreen({
    super.key,
    required this.title,
    required this.items,
    required this.initialIndex,
  });

  @override
  State<CategoryItemViewScreen> createState() => _CategoryItemViewScreenState();
}

class _CategoryItemViewScreenState extends State<CategoryItemViewScreen> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex.clamp(0, widget.items.length - 1);
  }

  void goPrev() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex -= 1;
      });
    }
  }

  void goNext() {
    if (currentIndex < widget.items.length - 1) {
      setState(() {
        currentIndex += 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final CategoryItem current = widget.items[currentIndex];
    final String bigLetter = current.label.isNotEmpty ? current.label[0].toUpperCase() : '';

    return Scaffold(
      // backgroundColor: const Color(0xFFF7EFE8),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent ,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Color(0xFF6E4D3F)),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Text(
          // textAlign: TextAlign.center,
          widget.title,
          style: const TextStyle(
            color: Color(0xFF6E4D3F),
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/categoryDetailList/ic_iteamBg.png',
              fit: BoxFit.fill,
            ),
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Big Letter with shadow
                        Text(
                          bigLetter,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 140,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            shadows: [
                              Shadow(
                                color: Colors.black26,
                                offset: Offset(4, 6),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Image with soft drop shadow
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: SizedBox(
                            height: constraints.maxHeight * 0.3,
                            child: Image.asset(
                              current.imageAsset,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Spelling/Label with subtle shadow
                        Text(
                          current.label,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 36,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            shadows: [
                              Shadow(
                                color: Colors.black26,
                                offset: Offset(2, 3),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _OutlinedCircleButton(
                              icon: Icons.arrow_back,
                              onPressed: currentIndex > 0 ? goPrev : null,
                            ),
                            const SizedBox(width: 24),
                            _FilledCircleButton(
                              icon: Icons.refresh,
                              onPressed: () {
                                setState(() {
                                  currentIndex = 0;
                                });
                              },
                            ),
                            const SizedBox(width: 24),
                            _OutlinedCircleButton(
                              icon: Icons.arrow_forward,
                              onPressed: currentIndex < widget.items.length - 1 ? goNext : null,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _OutlinedCircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  const _OutlinedCircleButton({required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        shape: const CircleBorder(),
        side: const BorderSide(color: Color(0xFF6E4D3F), width: 2),
        padding: const EdgeInsets.all(12),
      ),
      child: Icon(icon, color: const Color(0xFF6E4D3F), size: 28),
    );
  }
}

class _FilledCircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  const _FilledCircleButton({required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor: const Color(0xFF8B6A5A),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.all(14),
        elevation: 4,
      ),
      child: Icon(icon, size: 26),
    );
  }
}


