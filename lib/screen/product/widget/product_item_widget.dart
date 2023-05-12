import 'package:flutter/material.dart';
import 'package:riverpod_fake_store_api/screen/product/model/product.dart';

enum ProductStatus {
  current,
  next,
  previous,
}

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({
    super.key,
    required this.data,
    this.productStatus = ProductStatus.current,
  });

  final Product data;
  final ProductStatus productStatus;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.pink,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(
          20,
        ),
        child: Column(
          children: [
            Text(
              _getTitle(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              height: 2,
              color: Colors.white,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              data.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade300,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getTitle() {
    switch (productStatus) {
      case ProductStatus.current:
        return "Item Details";
      case ProductStatus.previous:
        return "Previous Details";
      case ProductStatus.next:
        return "Next Details";
    }
  }
}
