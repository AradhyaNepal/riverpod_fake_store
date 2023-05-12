import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_fake_store_api/screen/product/model/product.dart';
import 'package:riverpod_fake_store_api/screen/product/provider/specific_product_provider.dart';
import 'package:riverpod_fake_store_api/screen/product/widget/product_item_widget.dart';
import '../../common/enum/status.dart';

class SpecificOverrideProductScreen extends ConsumerStatefulWidget {

  const SpecificOverrideProductScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<SpecificOverrideProductScreen> createState() =>
      _SpecificProductScreenState();
}

class _SpecificProductScreenState
    extends ConsumerState<SpecificOverrideProductScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(specificOverrideProductController.notifier).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(specificOverrideProductController);
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: SizedBox(
        height: size.height,
        width: size.width,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Override"
            ),
          ),
          body: Center(
            child: Builder(builder: (context) {
              switch (state.status) {
                case Status.loading:
                  return const CircularProgressIndicator();
                case Status.error:
                  return Text(state.errorMessage);
                case Status.success:
                  final data = state.data;
                  if (data is! Product) return const SizedBox();
                  return SingleChildScrollView(
                    child: ProductItemWidget(
                      data: data,
                    ),
                  );
              }
            }),
          ),
        ),
      ),
    );
  }
}
