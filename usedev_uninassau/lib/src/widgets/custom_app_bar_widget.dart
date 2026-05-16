import 'package:flutter/material.dart';

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
      actions: const [
        Icon(Icons.person_outline, size: 40),
        SizedBox(width: 10),
        Icon(Icons.shopping_cart_outlined, size: 40),
        SizedBox(width: 25),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}