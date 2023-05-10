import 'dart:convert';
import 'package:http/http.dart' as http;

class AllProductRepository {
  ///Null means no output
  Future<List<String>?> fetchAllProduct(String token) async {
    final response =
        await http.get(Uri.parse("https://fakestoreapi.com/products"));
    if (response.statusCode > 299) return null;
    final responseData = jsonDecode(response.body) as List;
    return responseData.map((e) => e.toString()).toList();
  }
}
