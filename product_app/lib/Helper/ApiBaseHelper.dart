import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:products_app/Model/product_model.dart';

class ApiBaseHelper {
  final String baseUrl = "https://api.escuelajs.co/api/v1";

  Future<List<SimpleProduct>> fetchSimpleProducts(String endpoint) async {
    final response = await http.get(Uri.parse(baseUrl + endpoint));

    if (response.statusCode == 200) {
      // Decode JSON response and return the list of products
      List<dynamic> data = jsonDecode(response.body);
      List<SimpleProduct> products = data.map((item) => SimpleProduct.fromJson(item)).toList();
      return products;
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load data');
    }
  }
}

