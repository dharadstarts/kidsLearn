import 'package:flutter/material.dart';
import 'package:kids_learn/screens/Home/Models/category_item_model.dart';
import 'TapSetDetailsScreen.dart';
import '../Home/Data/tap_set_data.dart';

class Tapsetlistscreen extends StatelessWidget {
  final String title;
  Tapsetlistscreen({
    super.key,
    required this.title,
  });


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
                  height: 70, // Fixed height for header section within the image
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
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    itemCount: (tapsetCategories.length / 2).ceil(),
                    itemBuilder: (context, index) {
                      int first = index * 2;
                      int second = first + 1;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12), // vertical spacing between rows
                        child: Row(
                          children: [
                            /// LEFT ITEM
                            Expanded(
                              child: _gridItem(
                                  tapsetCategories[first].title,
                                  tapsetCategories[first].image,
                                  context
                              ),
                            ),

                            const SizedBox(width: 12), // spacing between left & right

                            /// RIGHT ITEM (if available)
                            if (second < tapsetCategories.length)
                              Expanded(
                                child: _gridItem(
                                    tapsetCategories[second].title,
                                    tapsetCategories[second].image,
                                    context
                                ),
                              )
                            else
                              const Expanded(child: SizedBox()),
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 🔸 Single item card
  Widget _gridItem(String title, String iconPath, BuildContext context) {
    return GestureDetector(
      onTap: () {
        TapsetCategory selected = tapsetCategories.firstWhere(
              (c) => c.title == title,
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => Tapsetdetailsscreen(
              title: selected.title,
              items: selected.items,
            ),
          ),
        );
      },
      child: Container(
        height: 85,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          image: const DecorationImage(
            image: AssetImage("assets/images/TapSet/ic_tapset_box.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Stack(
            children: [
              Positioned(
                top: 18,
                left: 0,
                right: 0,
                child: Center(
                  child: SizedBox(
                    height: 70,
                    child: Image.asset(
                      iconPath,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 18,
                left: 12,
                right: 12,
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF5A371A),
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