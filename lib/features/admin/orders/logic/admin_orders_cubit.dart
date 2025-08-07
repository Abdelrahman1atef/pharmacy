import 'package:bloc/bloc.dart';

import '../../../../core/enum/order_status.dart';
import '../repository/orders_repository.dart';
import 'admin_orders_state.dart';

class AdminOrdersCubit extends Cubit<AdminOrdersState> {
  final AdminOrdersRepository _adminOrdersRepository;
  OrderStatus? _currentFilter;

  AdminOrdersCubit(this._adminOrdersRepository) : super(const Initial());

  OrderStatus? get currentFilter => _currentFilter;

  void getAdminOrders() {
    emit(const Loading());
    _adminOrdersRepository.getAdminOrders().then((result) {
      result.when(
          success: (data) => emit(Success(data, _currentFilter)),
          failure: (e) => const Error());
    });
  }

  void filterByStatus(OrderStatus? status) {
    _currentFilter = status;
    emit(const Loading());
    _adminOrdersRepository.getAdminOrders().then((result) {
      result.when(
          success: (data) => emit(Success(data, _currentFilter)),
          failure: (e) => const Error());
    });
  }

  void clearFilter() {
    _currentFilter = null;
    emit(const Loading());
    _adminOrdersRepository.getAdminOrders().then((result) {
      result.when(
          success: (data) => emit(Success(data, _currentFilter)),
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
