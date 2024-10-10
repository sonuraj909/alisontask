import 'package:flutter/material.dart';
import '../constants/colors.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String originalPrice;
  final String discount;

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
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: imageUrl.isNotEmpty
                      ? Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          width: 150,
                          height: 130,
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            return Container(
                              width: 150,
                              height: 130,
                              color: Colors.grey,
                              child: Center(child: Text('No Image')),
                            );
                          },
                        )
                      : Container(
                          width: 150,
                          height: 130,
                          color: Colors.grey,
                          child: Center(child: Text('No Image')),
                        ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                    icon: Icon(Icons.favorite_border, color: Colors.white),
                    onPressed: () {},
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
  final List<Map<String, String>> products;
  ProductGrid({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];

          return ProductCard(
            imageUrl: product['imageUrl']!,
            title: product['title']!,
            price: product['price']!,
            originalPrice: product['originalPrice']!,
            discount: "10% off",
          );
        },
      ),
    );
  }
}
