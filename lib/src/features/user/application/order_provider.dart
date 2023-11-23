import 'package:fluttertoast/fluttertoast.dart';
import 'package:full_scale_shop_app/src/features/user/domain/inner_screen_models/order_model.dart';
import 'package:full_scale_shop_app/src/features/user/repository/order_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OrderController {
  final OrderRepository _orderRepository;
  OrderController({required OrderRepository orderRepository})
      : _orderRepository = orderRepository;

  Future<void> setOrder({
    required WidgetRef ref,
    required double total,
  }) async {
    final result = await _orderRepository.setOrderCollection(
      ref: ref,
      total: total,
    );
    return result.fold(
      (l) => null,
      (r) => Fluttertoast.showToast(
        msg: "Your order has been placed",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
      ),
    );
  }

  //Fetch orders
  Future<void> fetchOrders({
    required WidgetRef ref,
    required List<OrderModel> orderList,
  }) async {
    final result = await _orderRepository.fetchOrders(
      orderList: orderList,
      ref: ref,
    );
    return result.fold(
      (l) => null,
      (r) => null,
    );
  }
}

final orderControllerProvider = Provider<OrderController>((ref) {
  return OrderController(
    orderRepository: ref.watch(orderRepoProvider),
  );
});

final ordersListProvider = Provider<List<OrderModel>>((ref) {
  return [];
});
