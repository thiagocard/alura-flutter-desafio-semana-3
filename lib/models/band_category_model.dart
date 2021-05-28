import 'dart:collection';

import 'package:flutter_app/models/band_category.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesCubit extends Cubit<List<BandCategory>> {
  CategoriesCubit()
      : super([
          BandCategory(1, 'Rock',
              'https://i.ytimg.com/vi/RlNhD0oS5pk/maxresdefault.jpg'),
          BandCategory(2, 'Rap',
              'https://i.scdn.co/image/6f0da41419b31d9d2ba55d2df212f59ad0668118'),
          BandCategory(3, 'Eletrônica',
              'https://i.ytimg.com/vi/DBW-Rq4iEhQ/maxresdefault.jpg'),
          BandCategory(4, 'Alternativa/Indie',
              'https://imgsapp2.correiobraziliense.com.br/app/noticia_127983242361/2017/11/13/640681/20171113124348332866i.jpg'),
        ]);

  BandCategory selectedCategory;

  void add(BandCategory category) {
    state.add(category);
    emit(state);
  }

  void remove(int id) {
    state.removeWhere((category) => category.id == id);
    emit(state);
  }

  void removeAll() {
    state.clear();
    emit(state);
  }

}
