import 'dart:math';

import '../Models/category_item_model.dart';
import 'category_details_list_data.dart';

class PuzzleItem {
  final String name;
  final String imagePath;
  final List<String> shuffledLetters;

  PuzzleItem({
    required this.name,
    required this.imagePath,
    required this.shuffledLetters,
  });
}

class TapsetCategory {
  final String title;
  final String image;
  final List<PuzzleItem> items;

  TapsetCategory({
    required this.title,
    required this.image,
    required this.items,
  });
}


/// -------------------- SHUFFLE LOGIC --------------------

List<String> generateShuffledLetters(String word) {
  final random = Random();

  // Remove spaces & non-letters, uppercase
  final cleanedWord =
  word.replaceAll(RegExp(r'[^A-Za-z]'), '').toUpperCase();

  final letters = cleanedWord.split('');

  const alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

  // Extra letters based on difficulty
  final int extraCount = cleanedWord.length <= 4 ? 4 : 3;

  for (int i = 0; i < extraCount; i++) {
    letters.add(alphabet[random.nextInt(alphabet.length)]);
  }

  // Strong shuffle
  for (int i = 0; i < 3; i++) {
    letters.shuffle(random);
  }

  return letters;
}

/// -------------------- PUZZLE ITEM GENERATOR --------------------

List<PuzzleItem> generatePuzzleItems(List<CategoryItem> items) {
  return items.map((item) {
    return PuzzleItem(
      name: item.label.replaceAll(' ', '').toUpperCase(),
      imagePath: item.imageAsset,
      shuffledLetters: generateShuffledLetters(item.label),
    );
  }).toList();
}

/// -------------------- TAPSET CATEGORIES --------------------

List<TapsetCategory> tapsetCategories = [

  TapsetCategory(
    title: "Animals",
    image: "assets/images/TapSet/ic_shape1.png",
    items: generatePuzzleItems(arrAnimals),
  ),

  TapsetCategory(
    title: "Birds",
    image: "assets/images/TapSet/ic_shape2.png",
    items: generatePuzzleItems(arrBirds),
  ),

  TapsetCategory(
    title: "Numbers",
    image: "assets/images/TapSet/ic_shape3.png",
    items: generatePuzzleItems(arrNumbers),
  ),

  TapsetCategory(
    title: "Colors",
    image: "assets/images/TapSet/ic_shape4.png",
    items: generatePuzzleItems(arrColors),
  ),

  TapsetCategory(
    title: "Sea Animals",
    image: "assets/images/TapSet/ic_shape5.png",
    items: generatePuzzleItems(arrSeaAnimals),
  ),

  TapsetCategory(
    title: "Dry Fruits",
    image: "assets/images/TapSet/ic_shape6.png",
    items: generatePuzzleItems(arrDryFruits),
  ),

  TapsetCategory(
    title: "Festivals",
    image: "assets/images/TapSet/ic_shape7.png",
    items: generatePuzzleItems(arrFestivals),
  ),

  TapsetCategory(
    title: "Flowers",
    image: "assets/images/TapSet/ic_shape8.png",
    items: generatePuzzleItems(arrFlowers),
  ),

  TapsetCategory(
    title: "Fruits",
    image: "assets/images/TapSet/ic_shape9.png",
    items: generatePuzzleItems(arrFruits),
  ),

  TapsetCategory(
    title: "Insects",
    image: "assets/images/TapSet/ic_shape10.png",
    items: generatePuzzleItems(arrInsects),
  ),
];
