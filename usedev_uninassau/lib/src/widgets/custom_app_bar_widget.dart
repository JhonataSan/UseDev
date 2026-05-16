import 'package:flutter/material.dart';
import '../services/cart_service.dart';
import '../screens/cart_screen.dart'; 
import '../screens/login_screen.dart';

class CustomAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton;

  const CustomAppBarWidget({super.key, this.showBackButton = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: showBackButton 
        ? IconButton(
            icon: const Icon(Icons.arrow_back, size: 30),
            onPressed: () => Navigator.pop(context),
          )
        : const Icon(Icons.menu, size: 40),
      title: Image.asset('assets/logo_usedev.png', height: 40),
      centerTitle: true,
      actions: [
        IconButton(
  icon: const Icon(Icons.person_outline, size: 40),
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  },
),
        const SizedBox(width: 10),
        
        
        ListenableBuilder(
          listenable: CartService(),
          builder: (context, child) {
            final cartCount = CartService().items.length;
            
            return IconButton(
              icon: Badge(
                isLabelVisible: cartCount > 0,
                label: Text(cartCount.toString()),
                child: const Icon(Icons.shopping_cart_outlined, size: 40),
              ),
              onPressed: () {
                
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartScreen()),
                );
              },
            );
          },
        ),
        const SizedBox(width: 25),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}