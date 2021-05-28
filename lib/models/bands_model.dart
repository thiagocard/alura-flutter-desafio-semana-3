
import 'package:flutter_app/database/bands_dao.dart';
import 'package:flutter_app/models/band.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BandsState {
  final List<Band> bands;
  final int categoryId;

  BandsState(this.bands, this.categoryId);
}

class BandsCubit extends Cubit<BandsState> {
  BandsCubit(int categoryId) : super(BandsState([], categoryId)) {
    init();
  }

  void init() async {
    var bands = await BandsDao.findByCategoryId(state.categoryId);
    emit(BandsState(bands, -1));
  }

  void add(Band band) async {
    print('Adicionando a banda ${band.name}');
    var saved = await BandsDao.save(band);
    if (saved > 0) {
      var bands = state.bands;
      bands.add(band);
      emit(_buildState(bands));
    }
  }

  void remove(String uuid) async {
    print('Removendo a banda $uuid');
    var removed = await BandsDao.remove(uuid);
    if (removed > 0) {
      var bands = state.bands;
      bands.removeWhere((band) => band.uuid == uuid);
      emit(_buildState(bands));
    }
  }

  BandsState _buildState(List<Band> bands) => BandsState(bands, state.categoryId);

/*void removeAll() {
    state.clear();
    emit(state);
  }*/
}
