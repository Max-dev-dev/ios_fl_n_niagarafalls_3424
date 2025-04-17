import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteSoundsCubit extends Cubit<Set<String>> {
  FavouriteSoundsCubit() : super({});

  void toggle(String assetPath) {
    final updated = Set<String>.from(state);
    if (updated.contains(assetPath)) {
      updated.remove(assetPath);
    } else {
      updated.add(assetPath);
    }
    emit(updated);
  }

  bool isFavourite(String assetPath) => state.contains(assetPath);
}
