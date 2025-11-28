import 'package:kids_learn/screens/Home/Data/category_details_list_data.dart' show arrAnimals;

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

List<String> generateShuffledLetters(String word) {
  final letters = word.toUpperCase().split('');

  const extraLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  for (int i = 0; i < 4; i++) {
    letters.add(extraLetters[(extraLetters.length * (i + 4)) % extraLetters.length]);
  }

  letters.shuffle();
  return letters;
}

List<PuzzleItem> generatePuzzleItems(List<CategoryItem> items) {
  return items.map((animal) {
    return PuzzleItem(
      name: animal.label.toUpperCase(),
      imagePath: animal.imageAsset,
      shuffledLetters: generateShuffledLetters(animal.label),
    );
  }).toList();
}

List<TapsetCategory> tapsetCategories = [

  // ------------------ ANIMALS ------------------
  TapsetCategory(
    title: "Animals",
    image: "assets/images/TapSet/ic_shape1.png",
    items: generatePuzzleItems(arrAnimals),
  ),

  // ------------------ BIRDS ------------------
  TapsetCategory(
    title: "Birds",
    image: "assets/images/TapSet/ic_shape2.png",
    items: generatePuzzleItems(arrBirds),
  ),

  // ------------------ FRUITS ------------------
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
    items: [
      PuzzleItem(
        name: "APPLE",
        imagePath: "assets/images/categoryDetailList/fruits/ic_apple.png",
        shuffledLetters: ['A','P','P','L','E','Q','R'],
      ),
      PuzzleItem(
        name: "BANANA",
        imagePath: "assets/images/categoryDetailList/fruits/ic_banana.png",
        shuffledLetters: ['B','A','N','A','N','A','L'],
      ),
    ],
  ),

  TapsetCategory(
    title: "Dry Fruits",
    image: "assets/images/TapSet/ic_shape6.png",
    items: [
      PuzzleItem(
        name: "APPLE",
        imagePath: "assets/images/categoryDetailList/fruits/ic_apple.png",
        shuffledLetters: ['A','P','P','L','E','Q','R'],
      ),
      PuzzleItem(
        name: "BANANA",
        imagePath: "assets/images/categoryDetailList/fruits/ic_banana.png",
        shuffledLetters: ['B','A','N','A','N','A','L'],
      ),
    ],
  ),

  TapsetCategory(
    title: "Festivals",
    image: "assets/images/TapSet/ic_shape7.png",
    items: [
      PuzzleItem(
        name: "APPLE",
        imagePath: "assets/images/categoryDetailList/fruits/ic_apple.png",
        shuffledLetters: ['A','P','P','L','E','Q','R'],
      ),
      PuzzleItem(
        name: "BANANA",
        imagePath: "assets/images/categoryDetailList/fruits/ic_banana.png",
        shuffledLetters: ['B','A','N','A','N','A','L'],
      ),
    ],
  ),

  TapsetCategory(
    title: "Flowers",
    image: "assets/images/TapSet/ic_shape8.png",
    items: [
      PuzzleItem(
        name: "APPLE",
        imagePath: "assets/images/categoryDetailList/fruits/ic_apple.png",
        shuffledLetters: ['A','P','P','L','E','Q','R'],
      ),
      PuzzleItem(
        name: "BANANA",
        imagePath: "assets/images/categoryDetailList/fruits/ic_banana.png",
        shuffledLetters: ['B','A','N','A','N','A','L'],
      ),
    ],
  ),

  TapsetCategory(
    title: "Fruits",
    image: "assets/images/TapSet/ic_shape9.png",
    items: [
      PuzzleItem(
        name: "APPLE",
        imagePath: "assets/images/categoryDetailList/fruits/ic_apple.png",
        shuffledLetters: ['A','P','P','L','E','Q','R'],
      ),
      PuzzleItem(
        name: "BANANA",
        imagePath: "assets/images/categoryDetailList/fruits/ic_banana.png",
        shuffledLetters: ['B','A','N','A','N','A','L'],
      ),
    ],
  ),

  TapsetCategory(
    title: "Insects",
    image: "assets/images/TapSet/ic_shape10.png",
    items: [
      PuzzleItem(
        name: "APPLE",
        imagePath: "assets/images/categoryDetailList/fruits/ic_apple.png",
        shuffledLetters: ['A','P','P','L','E','Q','R'],
      ),
      PuzzleItem(
        name: "BANANA",
        imagePath: "assets/images/categoryDetailList/fruits/ic_banana.png",
        shuffledLetters: ['B','A','N','A','N','A','L'],
      ),
    ],
  ),

  // Add other categories here (Insects, Flowers, Sea Animals, etc.)
];
