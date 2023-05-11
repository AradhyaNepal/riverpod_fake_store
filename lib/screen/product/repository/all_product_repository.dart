import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:riverpod_fake_store_api/screen/product/model/product.dart';

class ProductRepository {
  ///Null means no output
  Future<List<Product>?> fetchAllProduct(String token) async {
    final response =
        await http.get(Uri.parse("https://fakestoreapi.com/products"));
    if (response.statusCode > 299) return null;
    final responseData = jsonDecode(response.body) as List;
    return responseData.map((e) => Product.fromJson(e)).toList();
  }

  ///Null means no output
  Future<Product?> fetchSpecificProduct(
      {required String token, required String productId}) async {
    final response = await http
        .get(Uri.parse("https://fakestoreapi.com/products/$productId"));
    if(response.statusCode>299) return null;
    final responseData=jsonDecode(response.body);
    return Product.fromJson(responseData);
  }
}
