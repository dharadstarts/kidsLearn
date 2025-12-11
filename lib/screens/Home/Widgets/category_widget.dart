import 'package:flutter/material.dart';
import 'package:kids_learn/screens/AppTextStyles.dart';
import '../Models/category_model.dart';

class CategoryWidget extends StatelessWidget {
  final int index;
  final Category category;
  final double width;
  final void Function(int)? onTap;

  const CategoryWidget({
    super.key,
    required this.index,
    required this.width,
    required this.category,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(index),
      child: SizedBox(
        width: width, // Can pass dynamically
        height: 95,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: Image.asset(
                category.bgImagePath,
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              top: [-25.0, -20.0, -15.0, -25.0, -15.0, -18.0][index % 6],
              left: 0,
              right: 0,
              child: Center(
                child: Image.asset(
                  category.centerImagePath,
                  height: 62,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned(
              bottom: 24,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  category.label,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.title
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}