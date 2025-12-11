import 'package:flutter/material.dart';
import 'package:kids_learn/screens/AppTextStyles.dart';
import 'package:kids_learn/screens/ColorHelper.dart';
import '../Models/category_item_model.dart';

class LetterCategoryCard extends StatelessWidget {
  final int index;
  final double size;
  final CategoryItem categoriesDetailList;
  final Function(int) onTap;

  const LetterCategoryCard({
    super.key,
    required this.index,
    required this.size,
    required this.categoriesDetailList,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double cardHeight = size * 1.5;

    return GestureDetector(
      onTap: () => onTap(index),
      child: SizedBox(
        width: size,
        height: cardHeight,
        child: Stack(
          children: [
            // Background Frame
            Positioned.fill(
              child: Image.asset(
                'assets/images/categoryDetailList/ic_commonShape.png',
                fit: BoxFit.contain,
              ),
            ),

            // Foreground Content ALWAYS CENTERED
            Positioned.fill(
              child: Center(
                child: categoriesDetailList.label.isNotEmpty
                    ? Text(
                    categoriesDetailList.label,
                    style: AppTextStyles.title.withColor(ColorHelper.fromHex('#5e3001')).withSize(size * 0.75)
                )
                    : Image.asset(
                  categoriesDetailList.imageAsset,
                  width: size * 0.6,
                  height: size * 0.6,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
