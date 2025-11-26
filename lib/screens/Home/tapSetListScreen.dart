import 'package:flutter/material.dart';
import 'package:kids_learn/screens/Home/Models/category_item_model.dart';

class Tapsetlistscreen extends StatelessWidget {
  final String title;
  Tapsetlistscreen({
    super.key,
    required this.title,
  });

  final List<CategoryItem> fillItems = [
    CategoryItem(label: 'Animals', imageAsset: 'assets/images/TapSet/ic_shape1.png'),
    CategoryItem(label: 'Birds', imageAsset: 'assets/images/TapSet/ic_shape2.png'),
    CategoryItem(label: 'Numbers', imageAsset: 'assets/images/TapSet/ic_shape3.png'),
    CategoryItem(label: 'Colors', imageAsset: 'assets/images/TapSet/ic_shape4.png'),
    CategoryItem(label: 'Sea animals', imageAsset: 'assets/images/TapSet/ic_shape5.png'),
    CategoryItem(label: 'Dry Fruits', imageAsset: 'assets/images/TapSet/ic_shape6.png'),
    CategoryItem(label: 'Festivals', imageAsset: 'assets/images/TapSet/ic_shape7.png'),
    CategoryItem(label: 'Flowers', imageAsset: 'assets/images/TapSet/ic_shape8.png'),
    CategoryItem(label: 'Fruits', imageAsset: 'assets/images/TapSet/ic_shape9.png'),
    CategoryItem(label: 'Insects', imageAsset: 'assets/images/TapSet/ic_shape10.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 🔵 Full-screen background
          Positioned.fill(
            child: Image.asset(
              "assets/images/TapSet/ic_tapset_bg.png",
              fit: BoxFit.cover,
            ),
          ),

          /// 🔹 Content positioned over the background image
          SafeArea(
            child: Column(
              children: [
                /// 🔹 Header - positioned at the top of the background image
                SizedBox(
                  height: 100, // Fixed height for header section within the image
                  child: Stack(
                    children: [
                      // Center the title within the image design area
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF6E4D3F),
                            ),
                          ),
                        ),
                      ),
                      // Back button positioned at top-left
                      Positioned(
                        left: 16,
                        top: 16,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            child: const Icon(Icons.arrow_back,
                                color: Color(0xFF6E4D3F), size: 28),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// 🔹 Grid view taking remaining space
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 90,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: fillItems.length,
                      itemBuilder: (context, index) {
                        return _gridItem(
                          fillItems[index].label,
                          fillItems[index].imageAsset,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 🔸 Single item card
  Widget _gridItem(String title, String iconPath) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/TapSet/ic_tapset_box.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // ICON (centered)
          Positioned(
            top: 20,
            child: SizedBox(
              height: 60,
              child: Image.asset(
                iconPath,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // TITLE (left aligned, but still centered as a block)
          Positioned(
            bottom: 27,
            left: 20,
            right: 20,
            child: Text(
              title,
              textAlign: TextAlign.left,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Color(0xFF5A371A),
              ),
            ),
          ),
        ],
      ),
    );
  }


}