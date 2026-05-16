import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/product_model.dart';
import '../widgets/custom_app_bar_widget.dart'; 

class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: const CustomAppBarWidget(showBackButton: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Center(
              child: Container(
                constraints: const BoxConstraints(maxHeight: 300),
                child: Image.network(
                  product.image, 
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 30),
            
            
            Text(
              product.title,
              style: TextStyle(
                fontFamily: GoogleFonts.orbitron().fontFamily,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),

            
            Text(
              'R\$ ${product.price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 26,
                color: Color.fromARGB(255, 185, 247, 2) ,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            
            Text(
              'Descrição',
              style: TextStyle(
                fontFamily: GoogleFonts.orbitron().fontFamily,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            
            Text(
              product.description,
              style: GoogleFonts.poppins(
                fontSize: 16, 
                height: 1.5,
                color: Colors.grey[400], 
              ),
            ),
            const SizedBox(height: 40),

            
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {
                  
                },
                icon: const Icon(Icons.add_shopping_cart, color: Colors.black),
                label: const Text(
                  'ADICIONAR AO CARRINHO',
                  style: TextStyle(
                    color: Colors.black, 
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFb9f702), 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}