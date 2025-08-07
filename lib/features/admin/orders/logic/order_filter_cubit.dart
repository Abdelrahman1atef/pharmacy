import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/enum/order_status.dart';

part 'order_filter_state.dart';
part 'order_filter_cubit.freezed.dart';

class OrderFilterCubit extends Cubit<OrderFilterState> {
  OrderFilterCubit() : super(const OrderFilterState.initial());

  void setFilter(OrderStatus? status) {
    emit(OrderFilterState.filtered(status));
  }

  void clearFilter() {
    emit(const OrderFilterState.initial());
  }
} 