import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/product_model.dart';
import '../screens/product_detail_screen.dart'; // Importa a tela que criamos

class ProductCardWidget extends StatelessWidget {
  // Agora recebemos o produto inteiro em vez de variáveis separadas
  final ProductModel produto;

  const ProductCardWidget({
    required this.produto,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // O InkWell deixa o card clicável e dá aquele efeito visual de "onda" ao tocar
    return InkWell(
      onTap: () {
        // Navega para a tela de detalhes enviando o produto clicado
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: produto),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(20), // Sintaxe corrigida
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Sintaxe corrigida
          children: [
            Image.network(
              produto.image, // Pega a imagem do objeto
              height: 200, 
              width: double.infinity, 
              fit: BoxFit.cover, // Sintaxe corrigida
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10), // Corrigido
              child: Text(
                produto.title, // Pega o nome do objeto
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold, // Corrigido
                  fontFamily: GoogleFonts.orbitron().fontFamily,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10), // Corrigido
              child: Text(
                'R\$ ${produto.price.toStringAsFixed(2)}', // Formata o preço lindamente
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