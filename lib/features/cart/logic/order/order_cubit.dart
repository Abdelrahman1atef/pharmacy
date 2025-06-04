import 'package:bloc/bloc.dart';

import '../../../../core/models/order/create/order_request.dart';
import '../../../../core/models/order/create/order_response.dart';
import '../../repository/order_repository.dart';
import 'order_state.dart';


class OrderCubit extends Cubit<OrderState> {
  final OrderRepository _orderRepository;

  OrderCubit(this._orderRepository) : super(const Initial());


  void createOrder(OrderRequest orderBody) async {
    emit(const Loading());
    return await _orderRepository.createOrder(orderBody).then((result) {
      result.when(
        success: (OrderResponse data) => emit(Success(data)),
        failure: (error) => emit(Error(error)),
      );
    });
  }
}
