import '../Models/category_model.dart';

final List<Category> categories = [
  Category(
    label: 'Kids Learn',
    bgImagePath: 'assets/images/Home/ic_category1.png',
    centerImagePath: 'assets/images/Home/ic_learn.png',
    screenType: 'categoryList', // This will go to categoryListScreen
  ),
  Category(
    label: 'Draw',
    bgImagePath: 'assets/images/Home/ic_category2.png',
    centerImagePath: 'assets/images/Home/ic_draw.png',
    screenType: 'drawing', // This will go to DrawingScreen
  ),
  Category(
    label: 'Tap / Set',
    bgImagePath: 'assets/images/Home/ic_category3.png',
    centerImagePath: 'assets/images/Home/ic_tap.png',
    screenType: 'tapSet', // You can create this screen later
  ),
  Category(
    label: 'Baby Sleep',
    bgImagePath: 'assets/images/Home/ic_category4.png',
    centerImagePath: 'assets/images/Home/ic_sleep.png',
    screenType: 'babySleep', // You can create this screen later
  ),
  Category(
    label: 'Puzzle',
    bgImagePath: 'assets/images/Home/ic_category5.png',
    centerImagePath: 'assets/images/Home/ic_puzzle.png',
    screenType: 'puzzle', // You can create this screen later
  ),
  Category(
    label: 'Maths',
    bgImagePath: 'assets/images/Home/ic_category6.png',
    centerImagePath: 'assets/images/Home/ic_maths.png',
    screenType: 'maths', // You can create this screen later
  ),
];