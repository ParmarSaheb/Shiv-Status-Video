import 'package:flutter/material.dart';


class BottomNavigationBarController with ChangeNotifier {

  int _selectedIndex = 0;
  late BuildContext context;

  int get selectedIndex => _selectedIndex;

  void updateIndex(int newIndex) {
    _selectedIndex = newIndex;
    notifyListeners();
  }

  // void changeCategory(BuildContext context, String newCategoryId) {
  //   Provider.of<AppChangesProvider>(context, listen: false).updateAppChange(newCategoryId);
  // }


}
