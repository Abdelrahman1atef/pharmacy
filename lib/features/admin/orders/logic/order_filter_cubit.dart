import 'package:bloc/bloc.dart';
import 'package:pharmacy/features/admin/orders/logic/order_filter_state.dart';
import '../../../../core/enum/order_status.dart';


class OrderFilterCubit extends Cubit<OrderFilterState> {
  OrderFilterCubit() : super(const OrderFilterState.initial());

  void setFilter(OrderStatus? status) {
    emit(OrderFilterState.filtered(status));
  }

  void clearFilter() {
    emit(const OrderFilterState.initial());
  }
} 