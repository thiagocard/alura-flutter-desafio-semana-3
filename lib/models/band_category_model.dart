import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_app/models/band.dart';
import 'package:flutter_app/models/band_category.dart';
import 'package:uuid/uuid.dart';

class CategoriesModel extends ChangeNotifier {
  final List<BandCategory> _categories = [];

  UnmodifiableListView<BandCategory> get categories => UnmodifiableListView<BandCategory>(_categories);

  CategoriesModel() {
    add(BandCategory(1, 'Rock', 'https://i.ytimg.com/vi/RlNhD0oS5pk/maxresdefault.jpg'));
    add(BandCategory(2, 'Rap', 'https://i.scdn.co/image/6f0da41419b31d9d2ba55d2df212f59ad0668118'));
    add(BandCategory(3, 'Eletrônica', 'https://i.ytimg.com/vi/DBW-Rq4iEhQ/maxresdefault.jpg'));
  }

  void add(BandCategory category) {
    _categories.add(category);
    notifyListeners();
  }

  void remove(int id) {
    _categories.removeWhere((category) => category.id == id);
    notifyListeners();
  }

  void removeAll() {
    _categories.clear();
    notifyListeners();
  }

}
