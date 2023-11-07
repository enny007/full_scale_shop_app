import 'package:full_scale_shop_app/src/features/user/domain/inner_screen_models/viewed_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ViewedProductProvider
    extends StateNotifier<Map<String, ViewedProductModel>> {
  ViewedProductProvider() : super({});

  void addProductsToHistory({required String productId}) {
    final items = {...state};
    items.putIfAbsent(productId, () {
      return ViewedProductModel(
        id: DateTime.now().toString(),
        productId: productId,
      );
    });
    state = items;
  }

  void clearHistory() {
    final items = {...state};
    items.clear();
    state = items;
  }
}

final viewedProductProvider = StateNotifierProvider<ViewedProductProvider,
    Map<String, ViewedProductModel>>((ref) {
  return ViewedProductProvider();
});
