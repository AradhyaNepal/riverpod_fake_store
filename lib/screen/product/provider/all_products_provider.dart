import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_fake_store_api/common/model/state_data.dart';
import 'package:riverpod_fake_store_api/screen/auth/provider/user_auth_provider.dart';
import 'package:riverpod_fake_store_api/screen/product/model/product.dart';
import 'package:riverpod_fake_store_api/screen/product/repository/all_product_repository.dart';

import '../../../common/enum/status.dart';

final allProductsController =
    StateNotifierProvider((ref) => AllProductsList(GenericState.loading([])));

class AllProductsList extends StateNotifier<GenericState<List<Product>>> {
  AllProductsList(super.state);

  void fetchAllProduct(WidgetRef ref) async {
    final token = ref.read(userAuthController.notifier).state.data.token;
    final data = await ProductRepository().fetchAllProduct(token);
    if (data == null) {
      state = state.copyWith(
          status: Status.error, errorMessage: "Cannot Fetch Details");
    } else {
      state = state.copyWith(status: Status.success, data: data);
    }
  }
}
