import 'package:bloc/bloc.dart';

import 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(const FavoriteState.initial()); // Initial state

  void toggleFavorite() {
    if (state is Favorited) {
      emit(const FavoriteState.notFavorited());
    } else {
      emit(const FavoriteState.favorited());
    }
  }
}
