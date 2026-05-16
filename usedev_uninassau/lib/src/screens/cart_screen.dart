

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/cart_service.dart';
import '../widgets/custom_app_bar_widget.dart';
import '../services/login_service.dart';
import 'login_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  
  Future<void> _handleCheckout(BuildContext context) async {
    final cartService = CartService();
    final loginService = LoginService();

    if (cartService.items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Seu carrinho está vazio!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

   
  final isLogged = await loginService.isLogged();

  if (!context.mounted) return;

  if (!isLogged) {
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Você precisa estar logado para finalizar a compra!'),
        backgroundColor: Colors.orange,
      ),
    );
    
    
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
    return;
  }

  
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Compra finalizada com sucesso!'),
      backgroundColor: Colors.green,
    ),
  );
  cartService.clearCart();

  }

  @override
  Widget build(BuildContext context) {
    
    final cartService = CartService();

    return Scaffold(
      appBar: const CustomAppBarWidget(showBackButton: true),
      
      body: ListenableBuilder(
        listenable: cartService,
        builder: (context, child) {
          if (cartService.items.isEmpty) {
            return Center(
              child: Text(
                'Seu carrinho está vazio',
                style: TextStyle(
                  fontFamily: GoogleFonts.orbitron().fontFamily,
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            );
          }

          return Column(
            children: [
              
              Expanded(
                child: ListView.builder(
                  itemCount: cartService.items.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartService.items[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            
                            Image.network(
                              cartItem.product.image,
                              width: 60,
                              height: 60,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(width: 16),
                            
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cartItem.product.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'R\$ ${cartItem.product.price.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline),
                                  onPressed: () => cartService.decrementQuantity(cartItem.product.id),
                                ),
                                Text('${cartItem.quantity}', style: const TextStyle(fontSize: 16)),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline),
                                  onPressed: () => cartService.incrementQuantity(cartItem.product.id),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => cartService.removeItem(cartItem.product.id),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              
              
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[900], 
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total:',
                          style: TextStyle(
                            fontFamily: GoogleFonts.orbitron().fontFamily,
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'R\$ ${cartService.totalPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontFamily: GoogleFonts.orbitron().fontFamily,
                            fontSize: 24,
                            color: const Color(0xFFb9f702),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => _handleCheckout(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFb9f702),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'FINALIZAR COMPRA',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}