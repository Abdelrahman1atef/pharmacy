// cubits/navigation_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';

class MainCubit extends Cubit<int> {
  MainCubit() : super(0); // Initial index is 0

  void selectTab(int index) {
    emit(index);
  }
}