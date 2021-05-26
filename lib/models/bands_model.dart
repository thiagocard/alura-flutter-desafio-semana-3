import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_app/models/band.dart';
import 'package:uuid/uuid.dart';

class BandsModel extends ChangeNotifier {
  final List<Band> _bands = [];

  BandsModel() {
    add(Band(Uuid().v4(), 1, 'Alice in Chains', 'https://rollingstone.uol.com.br/media/_versions/alice_in_chains_pequena_widelg.jpg'));
    add(Band(Uuid().v4(), 1, 'Pearl Jam', 'https://catracalivre.com.br/wp-content/uploads/2020/09/pearl-jam-1.jpg'));
    add(Band(Uuid().v4(), 1, 'Tame Imapla', 'https://jpimg.com.br/uploads/2019/01/kp-large.jpg'));
  }

  UnmodifiableListView<Band> bandsByCategory(int categoryId) {
    return UnmodifiableListView(_bands.where((band) => band.categoryId == categoryId));
  }

  void add(Band band) {
    _bands.add(band);
    notifyListeners();
  }

  void remove(String uuid) {
    _bands.removeWhere((band) => band.uuid == uuid);
    notifyListeners();
  }

  void removeAll() {
    _bands.clear();
    notifyListeners();
  }

}
