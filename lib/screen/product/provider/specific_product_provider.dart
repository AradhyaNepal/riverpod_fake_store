import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_fake_store_api/common/model/state_data.dart';
import 'package:riverpod_fake_store_api/screen/auth/provider/user_auth_provider.dart';
import 'package:riverpod_fake_store_api/screen/product/model/product.dart';
import 'package:riverpod_fake_store_api/screen/product/repository/product_repository.dart';

import '../../../common/enum/status.dart';

final specificFamilyProductController =
    StateNotifierProvider.family<SpecificProductState, GenericState<ProductAbstract>, int>(
  (ref, int id) => SpecificProductState(
    GenericState.loading(NoProduct()),
    id: id,
    ref: ref,
  ),
);

final specificOverrideProductController=StateNotifierProvider<SpecificProductState,GenericState<ProductAbstract>>((ref) =>throw UnimplementedError());

class SpecificProductState
    extends StateNotifier<GenericState<ProductAbstract>> {
  final int id;
  final StateNotifierProviderRef ref;

  SpecificProductState(super.state, {required this.id,required this.ref});

  void fetchData() async{
    final token = ref.read(userAuthController.notifier).state.data.token;
    final product=await ProductRepository().fetchSpecificProduct(token: token, productId: id.toString());
    if(product==null){
      state=state.copyWith(
        status: Status.error,
        errorMessage: "Error Fetching Product",
      );
    }else{
      state=state.copyWith(
        status: Status.success,
        data: product,
      );
    }
  }
}
