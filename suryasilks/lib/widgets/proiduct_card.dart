import 'package:flutter/material.dart';
import '../constants/colors.dart';

// Sample product data

class ProductCard extends StatelessWidget {
  final String imageUrl; // URL for the product image
  final String title; // Title of the product
  final String price; // Price of the product
  final String originalPrice; // Original price before discount
  final String discount; // Discount information

  const ProductCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.originalPrice,
    required this.discount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 260,
      child: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0), // Card border radius
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(12.0), // Image border radius
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: 150,
                    height: 130,
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                    icon: Icon(Icons.favorite_border, color: Colors.white),
                    onPressed: () {
                      // Handle favorite action
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12.0),
                bottomRight: Radius.circular(12.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  overflow: TextOverflow.ellipsis,
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      price,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      originalPrice,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      discount,
                      style: const TextStyle(color: kActiveColor, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductGrid extends StatelessWidget {
  final List<Map<String, String>> products = [
    {
      'imageUrl': 'assets/icons/image.png', // Replace with actual image paths
      'title': "Men's Graphic Oversized T-Shirt",
      'price': '₹400',
      'originalPrice': '₹900',
      'discount': '56% off',
    },
    {
      'imageUrl': 'assets/icons/image.png', // Replace with actual image paths
      'title': 'Birthday Dress',
      'price': '₹400',
      'originalPrice': '₹900',
      'discount': '56% off',
    },
    {
      'imageUrl': 'assets/icons/image.png', // Replace with actual image paths
      'title': "Men's Graphic Oversized T-Shirt",
      'price': '₹400',
      'originalPrice': '₹900',
      'discount': '56% off',
    },
    {
      'imageUrl': 'assets/icons/image.png', // Replace with actual image paths
      'title': 'Birthday Dress',
      'price': '₹400',
      'originalPrice': '₹900',
      'discount': '56% off',
    },
    // Add more products as needed
  ];
  @override
  Widget build(BuildContext context) {
    print(products.length);
    return Container(
      height: 200, // Set a height that accommodates the items comfortably
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount:
            products.length, // Use the actual length of the products list
        itemBuilder: (context, index) {
          final product = products[index];

          return ProductCard(
            imageUrl: product['imageUrl']!,
            title: product['title']!,
            price: product['price']!,
            originalPrice: product['originalPrice']!,
            discount: product['discount']!,
          );
        },
      ),
    );
  }
}

// Usage in your widget tree
// Place the ProductGrid widget inside a parent widget where you want to display it
