import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart'; 

class ProductService {
  Future<List<ProductModel>> getAllProducts() async {
    final url = Uri.parse('https://fakestoreapi.com/products?limit=5');
    
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        
        List<dynamic> jsonList = json.decode(response.body);
        
       
        return jsonList.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw Exception('Erro ao carregar produtos. Status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro de conexão: $e');
    }
  }
}