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
      PuzzleItem(name: "CRAB", imagePath: "assets/images/categoryDetailList/sea animals/ic_crab.png", shuffledLetters: ['C','R','A','B','L','P']),
      PuzzleItem(name: "DOLPHIN", imagePath: "assets/images/categoryDetailList/sea animals/ic_dolphin.png", shuffledLetters: ['D','O','L','P','H','I','N','A']),
      PuzzleItem(name: "EEL", imagePath: "assets/images/categoryDetailList/sea animals/ic_eel.png", shuffledLetters: ['E','E','L','T','P']),
      PuzzleItem(name: "JELLYFISH", imagePath: "assets/images/categoryDetailList/sea animals/ic_jellyfish.png", shuffledLetters: ['J','E','L','L','Y','F','I','S','H']),
      PuzzleItem(name: "LOBSTER", imagePath: "assets/images/categoryDetailList/sea animals/ic_lobster.png", shuffledLetters: ['L','O','B','S','T','E','R','A']),
      PuzzleItem(name: "MANTEE", imagePath: "assets/images/categoryDetailList/sea animals/ic_mantee.png", shuffledLetters: ['M','A','N','T','E','E','L']),
      PuzzleItem(name: "OCTOPUS", imagePath: "assets/images/categoryDetailList/sea animals/ic_octopus.png", shuffledLetters: ['O','C','T','O','P','U','S','R']),
      PuzzleItem(name: "OYSTER", imagePath: "assets/images/categoryDetailList/sea animals/ic_oyster.png", shuffledLetters: ['O','Y','S','T','E','R','A']),
      PuzzleItem(name: "PENGUIN", imagePath: "assets/images/categoryDetailList/sea animals/ic_penguin.png", shuffledLetters: ['P','E','N','G','U','I','N','L']),
      PuzzleItem(name: "POLARBEAR", imagePath: "assets/images/categoryDetailList/sea animals/ic_polarbear.png", shuffledLetters: ['P','O','L','A','R','B','E','A','R']),
      PuzzleItem(name: "SEAHORSE", imagePath: "assets/images/categoryDetailList/sea animals/ic_seahorse.png", shuffledLetters: ['S','E','A','H','O','R','S','E']),
      PuzzleItem(name: "SEAL", imagePath: "assets/images/categoryDetailList/sea animals/ic_seal.png", shuffledLetters: ['S','E','A','L','T','P']),
      PuzzleItem(name: "SEAOTTER", imagePath: "assets/images/categoryDetailList/sea animals/ic_seaotter.png", shuffledLetters: ['S','E','A','O','T','T','E','R']),
      PuzzleItem(name: "SHARK", imagePath: "assets/images/categoryDetailList/sea animals/ic_sharktank.png", shuffledLetters: ['S','H','A','R','K','L']),
      PuzzleItem(name: "SQUID", imagePath: "assets/images/categoryDetailList/sea animals/ic_squid.png", shuffledLetters: ['S','Q','U','I','D','A']),
      PuzzleItem(name: "STARFISH", imagePath: "assets/images/categoryDetailList/sea animals/ic_starfish.png", shuffledLetters: ['S','T','A','R','F','I','S','H']),
      PuzzleItem(name: "TURTLE", imagePath: "assets/images/categoryDetailList/sea animals/ic_tutrle.png", shuffledLetters: ['T','U','R','T','L','E','A']),
      PuzzleItem(name: "WHALE", imagePath: "assets/images/categoryDetailList/sea animals/ic_whale.png", shuffledLetters: ['W','H','A','L','E','R']),
    ],
  ),

  TapsetCategory(
    title: "Dry Fruits",
    image: "assets/images/TapSet/ic_shape6.png",
    items: [
      PuzzleItem(name: "ALMOND", imagePath: "assets/images/categoryDetailList/dry druits/ic_almond.png", shuffledLetters: ['A','L','M','O','N','D','R']),
      PuzzleItem(name: "BETELNUT", imagePath: "assets/images/categoryDetailList/dry druits/ic_betelnut.png", shuffledLetters: ['B','E','T','E','L','N','U','T']),
      PuzzleItem(name: "CASHEWNUT", imagePath: "assets/images/categoryDetailList/dry druits/ic_cashewnut.png", shuffledLetters: ['C','A','S','H','E','W','N','U','T']),
      PuzzleItem(name: "DATES", imagePath: "assets/images/categoryDetailList/dry druits/ic_datesdried.png", shuffledLetters: ['D','A','T','E','S','R']),
      PuzzleItem(name: "FIG", imagePath: "assets/images/categoryDetailList/dry druits/ic_fig.png", shuffledLetters: ['F','I','G','A','P']),
      PuzzleItem(name: "FLAXSEEDS", imagePath: "assets/images/categoryDetailList/dry druits/ic_flaxseeds.png", shuffledLetters: ['F','L','A','X','S','E','E','D','S']),
      PuzzleItem(name: "GROUNDNUT", imagePath: "assets/images/categoryDetailList/dry druits/ic_groundnut.png", shuffledLetters: ['G','R','O','U','N','D','N','U','T']),
      PuzzleItem(name: "PISTACHIO", imagePath: "assets/images/categoryDetailList/dry druits/ic_pistachio.png", shuffledLetters: ['P','I','S','T','A','C','H','I','O']),
      PuzzleItem(name: "PUMPKINSEEDS", imagePath: "assets/images/categoryDetailList/dry druits/ic_pumpkinseeds.png", shuffledLetters: ['P','U','M','P','K','I','N','S','E','E','D','S']),
      PuzzleItem(name: "RAISIN", imagePath: "assets/images/categoryDetailList/dry druits/ic_raisin.png", shuffledLetters: ['R','A','I','S','I','N','L']),
      PuzzleItem(name: "SAFFRON", imagePath: "assets/images/categoryDetailList/dry druits/ic_saffron.png", shuffledLetters: ['S','A','F','F','R','O','N']),
      PuzzleItem(name: "WALNUT", imagePath: "assets/images/categoryDetailList/dry druits/ic_walnut.png", shuffledLetters: ['W','A','L','N','U','T','R']),
    ],
  ),

  TapsetCategory(
    title: "Festivals",
    image: "assets/images/TapSet/ic_shape7.png",
    items: [
      PuzzleItem(name: "BAISAKHI", imagePath: "assets/images/categoryDetailList/festivals/ic_baisakhi.png", shuffledLetters: ['B','A','I','S','A','K','H','I']),
      PuzzleItem(name: "BUDDHAJAYANTI", imagePath: "assets/images/categoryDetailList/festivals/ic_budhajayanti.png", shuffledLetters: ['B','U','D','D','H','A','J','A','Y','A','N','T','I']),
      PuzzleItem(name: "CHRISTMAS", imagePath: "assets/images/categoryDetailList/festivals/ic_christmas.png", shuffledLetters: ['C','H','R','I','S','T','M','A','S']),
      PuzzleItem(name: "DIWALI", imagePath: "assets/images/categoryDetailList/festivals/ic_diwali.png", shuffledLetters: ['D','I','W','A','L','I','R']),
      PuzzleItem(name: "DURGA POOJA", imagePath: "assets/images/categoryDetailList/festivals/ic_durgapooja.png", shuffledLetters: ['D','U','R','G','A','P','O','O','J','A']),
      PuzzleItem(name: "EID", imagePath: "assets/images/categoryDetailList/festivals/ic_eid.png", shuffledLetters: ['E','I','D','A','L']),
      PuzzleItem(name: "GANESH CHATURTHI", imagePath: "assets/images/categoryDetailList/festivals/ic_ganeshcharturthi.png", shuffledLetters: ['G','A','N','E','S','H','C','H','A','T','U','R','T','H','I']),
      PuzzleItem(name: "GURU NANAK JAYANTI", imagePath: "assets/images/categoryDetailList/festivals/ic_gurunanakjayanti.png", shuffledLetters: ['G','U','R','U','N','A','N','A','K','J','A','Y','A','N','T','I']),
      PuzzleItem(name: "HOLI", imagePath: "assets/images/categoryDetailList/festivals/ic_holi.png", shuffledLetters: ['H','O','L','I','A']),
      PuzzleItem(name: "INDEPENDENCE DAY", imagePath: "assets/images/categoryDetailList/festivals/ic_independence.png", shuffledLetters: ['I','N','D','E','P','E','N','D','E','N','C','E']),
      PuzzleItem(name: "JANMASHTAMI", imagePath: "assets/images/categoryDetailList/festivals/ic_janmashtami.png", shuffledLetters: ['J','A','N','M','A','S','H','T','A','M','I']),
      PuzzleItem(name: "MAKAR SANKRANTI", imagePath: "assets/images/categoryDetailList/festivals/ic_mahasankranti.png", shuffledLetters: ['M','A','K','A','R','S','A','N','K','R','A','N','T','I']),
      PuzzleItem(name: "MAHA SHIVRATRI", imagePath: "assets/images/categoryDetailList/festivals/ic_mahashivratri.png", shuffledLetters: ['M','A','H','A','S','H','I','V','R','A','T','R','I']),
      PuzzleItem(name: "ONAM", imagePath: "assets/images/categoryDetailList/festivals/ic_onam.png", shuffledLetters: ['O','N','A','M','P']),
      PuzzleItem(name: "RAKSHA BANDHAN", imagePath: "assets/images/categoryDetailList/festivals/ic_rakshabandhan.png", shuffledLetters: ['R','A','K','S','H','A','B','A','N','D','H','A','N']),
      PuzzleItem(name: "RATH YATRA", imagePath: "assets/images/categoryDetailList/festivals/ic_rathyatra.png", shuffledLetters: ['R','A','T','H','Y','A','T','R','A']),
      PuzzleItem(name: "REPUBLIC DAY", imagePath: "assets/images/categoryDetailList/festivals/ic_republicday.png", shuffledLetters: ['R','E','P','U','B','L','I','C','D','A','Y']),
    ],
  ),

  TapsetCategory(
    title: "Flowers",
    image: "assets/images/TapSet/ic_shape8.png",
    items: [
      PuzzleItem(name: "ORCHID", imagePath: "assets/images/categoryDetailList/flowers/ic_archid.png", shuffledLetters: ['O','R','C','H','I','D','A']),
      PuzzleItem(name: "ASTER", imagePath: "assets/images/categoryDetailList/flowers/ic_asterflower.png", shuffledLetters: ['A','S','T','E','R','L']),
      PuzzleItem(name: "DAHLIA", imagePath: "assets/images/categoryDetailList/flowers/ic_dahila.png", shuffledLetters: ['D','A','H','L','I','A']),
      PuzzleItem(name: "DAISY", imagePath: "assets/images/categoryDetailList/flowers/ic_daisyflower.png", shuffledLetters: ['D','A','I','S','Y','L']),
      PuzzleItem(name: "HIBISCUS", imagePath: "assets/images/categoryDetailList/flowers/ic_hibiscus.png", shuffledLetters: ['H','I','B','I','S','C','U','S']),
      PuzzleItem(name: "LOTUS", imagePath: "assets/images/categoryDetailList/flowers/ic_lotus.png", shuffledLetters: ['L','O','T','U','S','A']),
      PuzzleItem(name: "MOGRA", imagePath: "assets/images/categoryDetailList/flowers/ic_mograflower.png", shuffledLetters: ['M','O','G','R','A','L']),
      PuzzleItem(name: "NARCISSUS", imagePath: "assets/images/categoryDetailList/flowers/ic_narcissusflower.png", shuffledLetters: ['N','A','R','C','I','S','S','U','S']),
      PuzzleItem(name: "ROSE", imagePath: "assets/images/categoryDetailList/flowers/ic_rose.png", shuffledLetters: ['R','O','S','E','L']),
      PuzzleItem(name: "SUNFLOWER", imagePath: "assets/images/categoryDetailList/flowers/ic_sunflower.png", shuffledLetters: ['S','U','N','F','L','O','W','E','R']),
      PuzzleItem(name: "TULIP", imagePath: "assets/images/categoryDetailList/flowers/ic_tulip.png", shuffledLetters: ['T','U','L','I','P','A']),
    ],
  ),

  TapsetCategory(
    title: "Fruits",
    image: "assets/images/TapSet/ic_shape9.png",
    items: [
      PuzzleItem(name: "APPLE", imagePath: "assets/images/categoryDetailList/fruits/ic_apple.png", shuffledLetters: ['A','P','P','L','E','R']),
      PuzzleItem(name: "APRICOT", imagePath: "assets/images/categoryDetailList/fruits/ic_apricot.png", shuffledLetters: ['A','P','R','I','C','O','T']),
      PuzzleItem(name: "BANANA", imagePath: "assets/images/categoryDetailList/fruits/ic_banana.png", shuffledLetters: ['B','A','N','A','N','A','L']),
      PuzzleItem(name: "BLACKBERRY", imagePath: "assets/images/categoryDetailList/fruits/ic_blackberry.png", shuffledLetters: ['B','L','A','C','K','B','E','R','R','Y']),
      PuzzleItem(name: "CHERRY", imagePath: "assets/images/categoryDetailList/fruits/ic_cherry.png", shuffledLetters: ['C','H','E','R','R','Y']),
      PuzzleItem(name: "CUSTARD APPLE", imagePath: "assets/images/categoryDetailList/fruits/ic_custardapple.png", shuffledLetters: ['C','U','S','T','A','R','D','A','P','P','L','E']),
      PuzzleItem(name: "GRAPES", imagePath: "assets/images/categoryDetailList/fruits/ic_grapes.png", shuffledLetters: ['G','R','A','P','E','S']),
      PuzzleItem(name: "GUAVA", imagePath: "assets/images/categoryDetailList/fruits/ic_guava.png", shuffledLetters: ['G','U','A','V','A','L']),
      PuzzleItem(name: "JACKFRUIT", imagePath: "assets/images/categoryDetailList/fruits/ic_jackfruit.png", shuffledLetters: ['J','A','C','K','F','R','U','I','T']),
      PuzzleItem(name: "JAMUN", imagePath: "assets/images/categoryDetailList/fruits/ic_javaplum.png", shuffledLetters: ['J','A','M','U','N','L']),
      PuzzleItem(name: "KIWI", imagePath: "assets/images/categoryDetailList/fruits/ic_kiwi.png", shuffledLetters: ['K','I','W','I','A']),
      PuzzleItem(name: "LEMON", imagePath: "assets/images/categoryDetailList/fruits/ic_lemon.png", shuffledLetters: ['L','E','M','O','N','T']),
      PuzzleItem(name: "MANGO", imagePath: "assets/images/categoryDetailList/fruits/ic_mango.png", shuffledLetters: ['M','A','N','G','O','R']),
      PuzzleItem(name: "MUSKMELON", imagePath: "assets/images/categoryDetailList/fruits/ic_muskmelon.png", shuffledLetters: ['M','U','S','K','M','E','L','O','N']),
      PuzzleItem(name: "PAPAYA", imagePath: "assets/images/categoryDetailList/fruits/ic_papaya.png", shuffledLetters: ['P','A','P','A','Y','A','L']),
      PuzzleItem(name: "PERU", imagePath: "assets/images/categoryDetailList/fruits/ic_peru.png", shuffledLetters: ['P','E','R','U','A']),
      PuzzleItem(name: "PINEAPPLE", imagePath: "assets/images/categoryDetailList/fruits/ic_pineapple.png", shuffledLetters: ['P','I','N','E','A','P','P','L','E']),
      PuzzleItem(name: "PLUM", imagePath: "assets/images/categoryDetailList/fruits/ic_plum.png", shuffledLetters: ['P','L','U','M','A']),
      PuzzleItem(name: "POMEGRANATE", imagePath: "assets/images/categoryDetailList/fruits/ic_pomegrante.png", shuffledLetters: ['P','O','M','E','G','R','A','N','A','T','E']),
      PuzzleItem(name: "SAPODILLA", imagePath: "assets/images/categoryDetailList/fruits/ic_sapodila.png", shuffledLetters: ['S','A','P','O','D','I','L','L','A']),
      PuzzleItem(name: "STRAWBERRY", imagePath: "assets/images/categoryDetailList/fruits/ic_starwberry.png", shuffledLetters: ['S','T','R','A','W','B','E','R','R','Y']),
      PuzzleItem(name: "TAMARIND", imagePath: "assets/images/categoryDetailList/fruits/ic_tamarind.png", shuffledLetters: ['T','A','M','A','R','I','N','D']),
      PuzzleItem(name: "WATERMELON", imagePath: "assets/images/categoryDetailList/fruits/ic_watermelon.png", shuffledLetters: ['W','A','T','E','R','M','E','L','O','N']),
    ],
  ),

  TapsetCategory(
    title: "Insects",
    image: "assets/images/TapSet/ic_shape10.png",
    items: [
      PuzzleItem(name: "ANT", imagePath: "assets/images/categoryDetailList/insects/ic_ant.png", shuffledLetters: ['A','N','T','L']),
      PuzzleItem(name: "BEE", imagePath: "assets/images/categoryDetailList/insects/ic_bee.png", shuffledLetters: ['B','E','E','A']),
      PuzzleItem(name: "BUTTERFLY", imagePath: "assets/images/categoryDetailList/insects/ic_butterfly.png", shuffledLetters: ['B','U','T','T','E','R','F','L','Y']),
      PuzzleItem(name: "COCKROACH", imagePath: "assets/images/categoryDetailList/insects/ic_cockroach.png", shuffledLetters: ['C','O','C','K','R','O','A','C','H']),
      PuzzleItem(name: "EARTHWORM", imagePath: "assets/images/categoryDetailList/insects/ic_earthworm.png", shuffledLetters: ['E','A','R','T','H','W','O','R','M']),
      PuzzleItem(name: "FROG", imagePath: "assets/images/categoryDetailList/insects/ic_frog.png", shuffledLetters: ['F','R','O','G','L']),
      PuzzleItem(name: "LADYBUG", imagePath: "assets/images/categoryDetailList/insects/ic_ladybug.png", shuffledLetters: ['L','A','D','Y','B','U','G']),
      PuzzleItem(name: "LIZARD", imagePath: "assets/images/categoryDetailList/insects/ic_lizard.png", shuffledLetters: ['L','I','Z','A','R','D']),
      PuzzleItem(name: "MOSQUITO", imagePath: "assets/images/categoryDetailList/insects/ic_mosquito.png", shuffledLetters: ['M','O','S','Q','U','I','T','O']),
      PuzzleItem(name: "SCORPION", imagePath: "assets/images/categoryDetailList/insects/ic_scorpion.png", shuffledLetters: ['S','C','O','R','P','I','O','N']),
      PuzzleItem(name: "SNAKE", imagePath: "assets/images/categoryDetailList/insects/ic_snake.png", shuffledLetters: ['S','N','A','K','E','L']),
      PuzzleItem(name: "SPIDER", imagePath: "assets/images/categoryDetailList/insects/ic_spider.png", shuffledLetters: ['S','P','I','D','E','R']),
      PuzzleItem(name: "TERMITE", imagePath: "assets/images/categoryDetailList/insects/ic_termite.png", shuffledLetters: ['T','E','R','M','I','T','E']),
    ],
  ),
];


