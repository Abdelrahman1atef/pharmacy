import 'package:bloc/bloc.dart';

import '../../../../core/enum/order_status.dart';
import '../repository/orders_repository.dart';
import 'admin_orders_state.dart';

class AdminOrdersCubit extends Cubit<AdminOrdersState> {
  final AdminOrdersRepository _adminOrdersRepository;

  AdminOrdersCubit(this._adminOrdersRepository) : super(const Initial());

  void getAdminOrders() {
    emit(const Loading());
    _adminOrdersRepository.getAdminOrders().then((result) {
      result.when(
          success: (data) => emit(Success(data)),
          failure: (e) => const Error());
    });
  }

  void updateOrdersStatus(int orderId, OrderStatus newStatus) {
    emit(const Loading());
    _adminOrdersRepository.updateOrderStatus(orderId, newStatus).then(
       (value) => getAdminOrders(),
    );
  }
}
