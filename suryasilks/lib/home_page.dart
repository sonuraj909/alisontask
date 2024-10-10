import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suryasilks/screens/home_screen.dart';
import 'constants/colors.dart';
import 'controller/bottom_nav_controller.dart';
import 'screens/categories_screen.dart';
import 'screens/combo_screen.dart';
import 'screens/profile_screen.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final BottomNavController bottomNavController =
      Get.put(BottomNavController());

  final List<Widget> _pages = [
    HomeScreen(),
    CategoriesScreen(),
    ComboScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return _pages[bottomNavController.selectedIndex.value];
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          currentIndex: bottomNavController.selectedIndex.value,
          onTap: bottomNavController.changeTabIndex,
          selectedItemColor: kActiveColor, // Set the active icon color
          unselectedItemColor: kIconColor, // Set the unselected icon color
          showUnselectedLabels:
              true, // Ensure labels are shown for unselected items
          type: BottomNavigationBarType
              .fixed, // Ensures labels and icons are under each other
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category_rounded),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_offer_rounded),
              label: 'Combo',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        );
      }),
    );
  }
}

class Appbar extends StatelessWidget {
  const Appbar({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      title: Text(title),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            // Handle search action
          },
        ),
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {
            // Handle cart action
          },
        ),
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {
            // Handle cart action
          },
        ),
      ],
    );
  }
}
