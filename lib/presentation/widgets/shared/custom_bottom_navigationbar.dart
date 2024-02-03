import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex; 
  const CustomBottomNavigationBar({super.key, required this.currentIndex});

  void onItemTapped(BuildContext context,int index){
    context.go('/home/$index');
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (value) {
        onItemTapped(context, value);
      },
      currentIndex: currentIndex,
      items: [
      BottomNavigationBarItem(icon: Icon(Icons.home_max), label: 'Home'),
      BottomNavigationBarItem(
          icon: Icon(Icons.label_important_outline), label: 'Categorias'),
      BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border_outlined), label: 'Favoritos')
    ]);
  }
}
