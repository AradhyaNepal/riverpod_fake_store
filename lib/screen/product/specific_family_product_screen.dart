import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_fake_store_api/screen/product/model/product.dart';
import 'package:riverpod_fake_store_api/screen/product/provider/specific_product_provider.dart';
import 'package:riverpod_fake_store_api/screen/product/widget/product_item_widget.dart';

import '../../common/enum/status.dart';
import '../../common/model/state_data.dart';

class SpecificFamilyProductScreen extends ConsumerStatefulWidget {
  final int id;

  const SpecificFamilyProductScreen({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<SpecificFamilyProductScreen> createState() =>
      _SpecificProductScreenState();
}

class _SpecificProductScreenState extends ConsumerState<SpecificFamilyProductScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(specificProductProvider(widget.id).notifier).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final previousProduct = getProductFromProvider(widget.id - 1);
    final nextProduct = getProductFromProvider(widget.id + 1);
    final state = ref.watch(specificProductProvider(widget.id))
        as GenericState<ProductAbstract>;
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: SizedBox(
        height: size.height,
        width: size.width,
        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                child: _SuccessDataWidget(
                  state: state,
                ),
              ),
              Expanded(
                child: _NextPreviousDataWidget(
                  previousProduct: previousProduct,
                  nextProduct: nextProduct,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ProductAbstract getProductFromProvider(int localId) {
    return (ref.watch(specificProductProvider(localId))
            as GenericState<ProductAbstract>)
        .data;
  }
}

class _NextPreviousDataWidget extends StatelessWidget {
  const _NextPreviousDataWidget({
    super.key,
    required this.previousProduct,
    required this.nextProduct,
  });

  final ProductAbstract previousProduct;
  final ProductAbstract nextProduct;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: previousProduct is Product
              ? SingleChildScrollView(
                  child: ProductItemWidget(
                    data: previousProduct as Product,
                    productStatus: ProductStatus.previous,
                  ),
                )
              : const SizedBox(),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: nextProduct is Product
              ? SingleChildScrollView(
                  child: ProductItemWidget(
                    data: nextProduct as Product,
                    productStatus: ProductStatus.next,
                  ),
                )
              : const SizedBox(),
        ),
      ],
    );
  }
}

class _SuccessDataWidget extends StatelessWidget {
  const _SuccessDataWidget({
    super.key,
    required this.state,
  });

  final GenericState<ProductAbstract> state;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
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
    });
  }
}
