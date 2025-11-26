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

  final List<CategoryItem> arrDrawShapes = [
    CategoryItem(label: '', imageAsset: 'assets/images/drawing/ic_sequre.png'),
    CategoryItem(label: '', imageAsset: 'assets/images/drawing/ic_circle.png'),
    CategoryItem(label: '', imageAsset: 'assets/images/drawing/ic_tringle.png'),
    CategoryItem(label: '', imageAsset: 'assets/images/drawing/ic_shape3.png'),
    CategoryItem(label: '', imageAsset: 'assets/images/drawing/ic_shape4.png'),
    CategoryItem(label: '', imageAsset: 'assets/images/drawing/ic_shape5.png'),
  ];

  final List<CategoryItem> arrFillShape = [
    CategoryItem(label:'' ,imageAsset: 'assets/images/drawing/ic_fill_image1.png'),
    CategoryItem(label:'' ,imageAsset: 'assets/images/drawing/ic_fill_image2.png'),
    CategoryItem(label:'' ,imageAsset: 'assets/images/drawing/ic_fill_image3.png'),
    CategoryItem(label:'' ,imageAsset: 'assets/images/drawing/ic_fill_image4.png'),
    CategoryItem(label:'' ,imageAsset: 'assets/images/drawing/ic_fill_image5.png'),
    CategoryItem(label:'' ,imageAsset: 'assets/images/drawing/ic_fill_image6.png'),
    CategoryItem(label:'' ,imageAsset: 'assets/images/drawing/ic_fill_image7.png'),
    CategoryItem(label:'' ,imageAsset: 'assets/images/drawing/ic_fill_image8.png'),
    CategoryItem(label:'' ,imageAsset: 'assets/images/drawing/ic_fill_image8.png'),
    CategoryItem(label:'' ,imageAsset: 'assets/images/drawing/ic_fill_image10.png'),
    CategoryItem(label:'' ,imageAsset: 'assets/images/drawing/ic_fill_image11.png'),
    CategoryItem(label:'' ,imageAsset: 'assets/images/drawing/ic_fill_image12.png'),
    CategoryItem(label:'' ,imageAsset: 'assets/images/drawing/ic_fill_image13.png'),
    CategoryItem(label:'' ,imageAsset: 'assets/images/drawing/ic_fill_image14.png'),
    CategoryItem(label:'' ,imageAsset: 'assets/images/drawing/ic_fill_image15.png'),
    CategoryItem(label:'' ,imageAsset: 'assets/images/drawing/ic_fill_image16.png'),
  ];


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
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  pinned: true,
                  automaticallyImplyLeading: false,
                  toolbarHeight: 70,
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(
                            Icons.arrow_back,
                            size: 30,
                            color: Color(0xff6c4e32),
                          ),
                        ),
                        const Spacer(),
                        const Text(
                          "Drawing",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff6c4e32),
                          ),
                        ),
                        const Spacer(),
                        Opacity(opacity: 0, child: Icon(Icons.arrow_back)),
                      ],
                    ),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 60)),

                // -------------------- GRID LIST --------------------
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    delegate: SliverChildListDelegate([
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
                                items: arrDrawShapes,
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
                                title: "FILL Colors",
                                screenType: "drawing",
                                items: arrFillShape,
                              ),
                            ),
                          );
                        },
                      ),
                    ]),
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