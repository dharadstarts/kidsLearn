import 'package:flutter/material.dart';
import 'package:kids_learn/screens/Home/BabySleepScreen.dart';
import 'package:kids_learn/screens/Home/MathsScreen.dart';
import 'package:kids_learn/screens/Home/NumberPuzzleScreen.dart';
import 'package:kids_learn/screens/Home/categoryDetailListScreen.dart';
import 'package:kids_learn/screens/Home/tapSetListScreen.dart';
import '../Models/category_model.dart';
import '../Data/category_data.dart';
import '../Data/category_list_data.dart';
import '../categoryList_Screen.dart';
import '../drawingScreen.dart';

class CategoryViewModel extends ChangeNotifier {
  List<Category> categoryList = categories;
  List<Category> arrCategoriesList = categoriesList;

  int? selectedIndex;

  void onCategoryTapped(BuildContext context, int index) {
    selectedIndex = index;
    notifyListeners();

    final Category category = categoryList[index];

    // Navigate to different screens based on screenType
    switch (category.screenType) {
      case 'drawing':
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => DrawingScreen(),
          ),
        );
        break;
      case 'tapSet':
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => Tapsetlistscreen(title: category.label),
          ),
        );
        break;
      case 'puzzle':
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => NumberPuzzleScreen(),
          ),
        );
        break;
      case 'maths':
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => MathsScreen(),
          ),
        );
        break;
      case 'babySleep':
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => BabySleepScreen(),
          ),
        );
        break;
      case 'categoryList':
      default:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => categoryListScreen(title: category.label),
          ),
        );
        break;
    }
  }
  void onSubCategoryTapped(BuildContext context, int index) {
    selectedIndex = index;
    notifyListeners();
    final String title = arrCategoriesList[index].label;
    if (title == null) {
      return;
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => CategoryDetailListScreen(title: title, screenType: '',),
        ),
      );
    }

  }
}