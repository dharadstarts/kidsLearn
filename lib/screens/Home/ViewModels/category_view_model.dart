import 'package:flutter/material.dart';
import '../Models/category_model.dart';
import '../Data/category_data.dart';

class CategoryViewModel extends ChangeNotifier {
  List<Category> categoryList = categories;

  int? selectedIndex;

  void onCategoryTapped(int index) {
    selectedIndex = index;
    notifyListeners(); // Notify UI to update if needed
    print('Tapped category: ${categoryList[index].label}');
  }
}