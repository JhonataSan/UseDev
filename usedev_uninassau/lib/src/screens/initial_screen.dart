import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usedev_uninassau/src/widgets/hero_section_widget.dart';
import 'package:usedev_uninassau/src/widgets/product_card_widget.dart';
import 'package:usedev_uninassau/src/widgets/subscription_section_widget.dart';
import 'package:usedev_uninassau/src/models/product_model.dart';
import 'package:usedev_uninassau/src/services/product_service.dart';
import '../widgets/custom_app_bar_widget.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final ProductService _productService = ProductService();
  late Future<List<ProductModel>> _produtosFuture;

  @override
  void initState() {
    super.initState();
    _produtosFuture = _productService.getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: const CustomAppBarWidget(showBackButton: false,),

      body: SingleChildScrollView(
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.stretch, 
          children: [
            const HeroSectionWidget(),
            Text(
              'Promos Especiais',
              textAlign: TextAlign.center, 
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold, 
                fontFamily: GoogleFonts.orbitron().fontFamily,
              ),
            ),
            FutureBuilder<List<ProductModel>>(
              future: _produtosFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Erro ao carregar produtos.'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Nenhum produto encontrado.'));
                }

                final produtos = snapshot.data!;
                return Column(
                  spacing: 20,
                  children: produtos.map((produto) => ProductCardWidget(
                    produto: produto,
                  )).toList(),
                
                );
              },
            ),
            const SubscriptionSectionWidget(),
          ],
        ),
      ),
    );
  }
}