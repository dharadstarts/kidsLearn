import 'package:flutter/material.dart';
import 'package:kids_learn/screens/Home/categoryDetailListScreen.dart';
import '../Models/category_model.dart';
import '../Data/category_data.dart';
import '../Data/category_list_data.dart';
import '../categoryList_Screen.dart';

class CategoryViewModel extends ChangeNotifier {
  List<Category> categoryList = categories;
  List<Category> arrCategoriesList = categoriesList;


  int? selectedIndex;

  void onCategoryTapped(BuildContext context, int index) {
    selectedIndex = index;
    notifyListeners();
    final String title = categoryList[index].label;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => categoryListScreen(title: title),
      ),
    );
  }

  void onSubCategoryTapped(BuildContext context, int index) {
    selectedIndex = index;
    notifyListeners();
    final String title = arrCategoriesList[index].label;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CategoryDetailListScreen(title: title),
      ),
    );
  }
}