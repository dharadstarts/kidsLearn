import 'package:flutter/material.dart';
import '../Models/category_model.dart';

// class CategoryCard extends StatelessWidget {
//   final int index;
//   final Category arrCategoryList;
//   final double width;
//   final void Function(int)? onTap;
//
//   const CategoryCard({
//     super.key,
//     required this.index,
//     required this.width,
//     required this.arrCategoryList,
//     this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     // Calculate card height proportionally to width
//     final double cardHeight = width * 1.2; // adjust ratio as needed
//
//     return GestureDetector(
//       onTap: () => onTap?.call(index),
//       child: SizedBox(
//         width: width,
//         height: cardHeight,
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             // Background image (fills the card)
//             Container(
//               width: width,
//               height: cardHeight,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage(arrCategoryList.bgImagePath),
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ),
//
//             // Center image + text inside background
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // Center icon/image
//                 Flexible(
//                   flex: 6,
//                   child: FractionallySizedBox(
//                     widthFactor: 0.45, // relative to card width
//                     child: Image.asset(
//                       arrCategoryList.centerImagePath,
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 8),
//
//                 // Text inside the background
//                 Flexible(
//                   flex: 2,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                     child: FittedBox(
//                       fit: BoxFit.scaleDown, // prevents overflow
//                       child: Text(
//                         arrCategoryList.label,
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.black87,
//                           fontFamily: 'Poppins',
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
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
                height: cardHeight * 0.98,
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
                top: -10.0,
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
              bottom: 49,
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
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                      fontFamily: 'Poppins',
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



