import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_fake_store_api/common/model/state_data.dart';
import 'package:riverpod_fake_store_api/screen/auth/provider/user_auth_provider.dart';
import 'package:riverpod_fake_store_api/screen/product/model/product.dart';
import 'package:riverpod_fake_store_api/screen/product/provider/all_products_provider.dart';
import 'package:riverpod_fake_store_api/screen/product/provider/is_family_provider.dart';
import 'package:riverpod_fake_store_api/screen/product/specific_family_product_screen.dart';
import 'package:riverpod_fake_store_api/screen/product/widget/product_item_widget.dart';

import '../../common/enum/status.dart';

class AllProductScreen extends ConsumerStatefulWidget {
  const AllProductScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends ConsumerState<AllProductScreen> {
  bool loading = true;

  @override
  void initState() {
    super.initState();
    ref.read(allProductsController.notifier).fetchAllProduct(ref);
  }

  @override
  Widget build(BuildContext context) {
    final state =
        (ref.watch(allProductsController) as GenericState<List<Product>>);
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: SizedBox(
        height: size.height,
        width: size.width,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Products",
            ),
            actions: [
              const _IsFamilySwitchWidget(),
              IconButton(
                onPressed: () {
                  ref.read(userAuthController.notifier).logout();
                },
                icon: const Icon(Icons.logout),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          body: Builder(
            builder: (context) {
              final status = state.status;
              switch (status) {
                case Status.loading:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case Status.error:
                  return Center(
                    child: Text(
                      state.errorMessage,
                    ),
                  );
                case Status.success:
                  final data = state.data;
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SpecificFamilyProductScreen(
                                id: data[index].id,
                              ),
                            ),
                          );
                        },
                        child: ProductItemWidget(data: data[index]),
                      );
                    },
                    itemCount: data.length,
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}

class _IsFamilySwitchWidget extends ConsumerWidget {
  const _IsFamilySwitchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Row(
      children: [
        const Text(
          "Use Family:",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 17,
          ),
        ),
        Switch(
            activeColor:Colors.white,
          value: ref.watch(isFamilyProvider),
          onChanged: (value){
            ref.watch(isFamilyProvider.notifier).update((state) => value);
          },
        ),
      ],
    );
  }
}

