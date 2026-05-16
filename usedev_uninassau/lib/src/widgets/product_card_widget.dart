import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/product_model.dart';
import '../screens/product_detail_screen.dart'; 

class ProductCardWidget extends StatelessWidget {
  
  final ProductModel produto;

  const ProductCardWidget({
    required this.produto,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    
    return InkWell(
      onTap: () {
        
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: produto),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(20), 
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, 
          children: [
            Image.network(
              produto.image, 
              height: 200, 
              width: double.infinity, 
              fit: BoxFit.cover, 
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10), 
              child: Text(
                produto.title, 
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold, 
                  fontFamily: GoogleFonts.orbitron().fontFamily,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10), 
              child: Text(
                'R\$ ${produto.price.toStringAsFixed(2)}', 
                style: TextStyle(
                  fontSize: 31,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}