import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_fake_store_api/common/model/state_data.dart';
import 'package:riverpod_fake_store_api/screen/auth/provider/user_auth_provider.dart';
import 'package:riverpod_fake_store_api/screen/product/model/product.dart';
import 'package:riverpod_fake_store_api/screen/product/provider/all_products_provider.dart';
import 'package:riverpod_fake_store_api/screen/product/specific_product_screen.dart';

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
              "All Products",
            ),
            actions: [
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
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SpecificProductScreen(
                                id: state.data[index].id,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 20,
                          ),
                          child: Text(
                            state.data[index].toString(),
                          ),
                        ),
                      );
                    },
                    itemCount: state.data.length,
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
