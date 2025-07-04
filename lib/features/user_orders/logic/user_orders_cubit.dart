import 'package:bloc/bloc.dart';
import '../repository/user_orders_repository.dart';
import 'user_orders_state.dart';

class UserOrdersCubit extends Cubit<UserOrdersState> {
  final UserOrdersRepository _userOrdersRepository;

  UserOrdersCubit(this._userOrdersRepository) : super(const Initial());

  void getCustomerOrders() {
    emit(const Loading());
    _userOrdersRepository.getCustomerOrders().then((result) {
      result.when(
          success: (data) => emit(Success(data)),
          failure: (e) => const Error());
    });
  }
}
