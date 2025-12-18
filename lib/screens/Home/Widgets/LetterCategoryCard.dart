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
    return GestureDetector(
      onTap: () => onTap(index),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // ✅ Background frame fills the card
          Positioned.fill(
            child: Image.asset(
              'assets/images/categoryDetailList/ic_commonShape.png',
              fit: BoxFit.contain,
            ),
          ),

          // ✅ Foreground content (TEXT / IMAGE)
          Transform.translate(
            offset: const Offset(0, 6), // 👈 pushes content slightly DOWN
            child: categoriesDetailList.label.isNotEmpty
                ? Text(
              categoriesDetailList.label,
              textAlign: TextAlign.center,
              style: AppTextStyles.title
                  .withColor(ColorHelper.fromHex('#5e3001'))
                  .withSize(size * 0.6)
                  .copyWith(
                height: 1, // 👈 removes extra font top space
              ),
            )
                : Image.asset(
              categoriesDetailList.imageAsset,
              width: size * 0.55,
              height: size * 0.55,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}

