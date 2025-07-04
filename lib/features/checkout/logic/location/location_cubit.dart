import 'package:flutter_bloc/flutter_bloc.dart';
import 'saved_location.dart';

class LocationCubit extends Cubit<SavedLocation?> {
  LocationCubit() : super(null);

  void selectLocation(SavedLocation location) {
    emit(location);
  }
} 