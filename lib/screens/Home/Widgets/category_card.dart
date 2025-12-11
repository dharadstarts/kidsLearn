import 'package:flutter/material.dart';
import 'package:kids_learn/screens/AppTextStyles.dart';
import 'package:kids_learn/screens/ColorHelper.dart';
import '../Models/category_model.dart';

class CategoryCard extends StatelessWidget {
  final int index;
  final Category arrCategoryList;
  final double width;
  final void Function(int)? onTap;

  const CategoryCard({
    super.key,
    required this.index,
    required this.width,
    required this.arrCategoryList,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double cardHeight = width * 1.35;

    return GestureDetector(
      onTap: () => onTap?.call(index),
      child: SizedBox(
        width: width,
        height: cardHeight,
        child: Stack(
          clipBehavior: Clip.none, // allows pop-out image
          alignment: Alignment.topCenter,
          children: [
            // ✅ Background image
            Positioned(
              bottom: 0,
              child: Container(
                width: width,
                height: cardHeight * 0.75,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(arrCategoryList.bgImagePath),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            // ✅ Center image (only if path is not empty or null)
            if (arrCategoryList.centerImagePath.isNotEmpty)
              Positioned(
                top: 8,
                child: SizedBox(
                  width: arrCategoryList.label.isEmpty ? width * 0.70 : width * 0.55,
                  height: arrCategoryList.label.isEmpty ? width * 0.70 : width * 0.55,
                  child: Image.asset(
                    arrCategoryList.centerImagePath,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

            // ✅ Text inside background
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: width * 0.7,
                  ),
                  child: Text(
                    arrCategoryList.label,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: AppTextStyles.custom(fontSize: 14,fontWeight: FontWeight.normal).withColor(ColorHelper.fromHex('#1e1e1e')
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



