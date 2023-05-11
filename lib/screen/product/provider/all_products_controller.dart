import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_fake_store_api/common/model/state_data.dart';
import 'package:riverpod_fake_store_api/screen/auth/provider/user_auth_controller.dart';
import 'package:riverpod_fake_store_api/screen/product/repository/all_product_repository.dart';

import '../../../common/enum/status.dart';

final allProductsController =
    StateNotifierProvider((ref) => AllProductsList(GenericState<List<String>>.loading([])));

class AllProductsList extends StateNotifier<GenericState<List<String>>> {
  AllProductsList(super.state);

  void fetchAllProduct(WidgetRef ref) async {
    final token = ref.read(userAuthController.notifier).state.data.token;
    final data = await AllProductRepository().fetchAllProduct(token);
    if (data == null) {
      state.copyWith(
          status: Status.error, errorMessage: "Cannot Fetch Details");
    } else {
      state = state.copyWith(status: Status.success, data: data);
    }
  }
}
