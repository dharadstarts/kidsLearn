import 'package:flutter/material.dart';
import '../Models/category_item_model.dart';

class CategoryItemCard extends StatelessWidget {
  final int index;
  final CategoryItem categoriesDetailList;
  final double width;
  final void Function(int)? onTap;

  const CategoryItemCard({
    super.key,
    required this.index,
    required this.width,
    required this.categoriesDetailList,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate card height proportionally to width
    final double cardHeight = width * 1.5; // adjust ratio as needed

    return GestureDetector(
      onTap: () => onTap?.call(index),
      child: SizedBox(
        width: width,
        height: cardHeight,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background image (fills the card)
            Container(
              width: width,
              height: cardHeight,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/categoryDetailList/ic_commonShape.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // Center image + text inside background
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Center icon/image
                Flexible(
                  flex: 0,
                  child: FractionallySizedBox(
                    widthFactor: 0.48, // relative to card width
                    child: Image.asset(
                      categoriesDetailList.imageAsset,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // Text inside the background
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),  // ✔ 3 px left & right
                    child: Text(
                      categoriesDetailList.label,
                      textAlign: TextAlign.center,
                      maxLines: 2,          // ✔ Wrap into next line
                      overflow: TextOverflow.visible,
                      softWrap: true,       // ✔ Ensure wrapping
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}