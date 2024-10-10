import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:suryasilks/constants/colors.dart';

import '../api/homepage_api.dart';
import '../controller/homepage_controller.dart';
import '../models/banner_model.dart';
import '../widgets/proiduct_card.dart';

class HomeScreen extends StatelessWidget {
  final String id;
  final String token;

  final HomepageController homepageController =
      Get.put(HomepageController(HomepageApiService()));

  HomeScreen({required this.id, required this.token});

  @override
  Widget build(BuildContext context) {
    homepageController.fetchedData(id, token);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kActiveColorlight,
        title: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/surya.png'),
              fit: BoxFit.cover,
            ),
          ),
          width: 80,
          height: 40,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Handle cart action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Obx(() {
                if (homepageController.banners.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                }
                return CarouselSlider(
                  options: CarouselOptions(
                    height: 200.0,
                    viewportFraction: 1,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      homepageController.updateCarouselIndex(index);
                    },
                  ),
                  items: homepageController.banners.map((BannerModel banner) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(banner.image),
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    );
                  }).toList(),
                );
              }),
              const SizedBox(height: 10),
              Obx(() {
                return SmoothPageIndicator(
                  controller: PageController(
                      initialPage: homepageController.activeIndex.value),
                  count: homepageController.banners.length,
                  effect: const ExpandingDotsEffect(
                    dotHeight: 8.0,
                    dotWidth: 8.0,
                    spacing: 4.0,
                    activeDotColor: Colors.red,
                  ),
                  onDotClicked: (index) =>
                      homepageController.updateCarouselIndex(index),
                );
              }),
              const SizedBox(height: 10),

              // Sections
              _buildCategoryGrid([
                {'name': 'Mens', 'imagePath': 'assets/images/men.png'},
                {'name': 'Womens', 'imagePath': 'assets/images/women.png'},
                {'name': 'Kids', 'imagePath': 'assets/images/kids.png'},
              ]),
              _buildSectionTitle('September Hot Picks'),
              ProductGrid(
                  products: homepageController.ourProducts
                      .map((product) => product.toMap())
                      .toList()),
              _buildSectionTitle('Festival Collections'),
              ProductGrid(
                  products: homepageController.recentViews
                      .map((product) => product.toMap())
                      .toList()),
              _buildSectionTitle('Trending Categories - Women'),
              _buildCategoryGrid([
                {'name': 'Mens', 'imagePath': 'assets/images/men.png'},
                {'name': 'Womens', 'imagePath': 'assets/images/women.png'},
                {'name': 'Kids', 'imagePath': 'assets/images/kids.png'},
              ]),
              _buildSectionTitle('Trending Categories - Men'),
              _buildCategoryGrid([
                {'name': 'Mens', 'imagePath': 'assets/images/men.png'},
                {'name': 'Womens', 'imagePath': 'assets/images/women.png'},
                {'name': 'Kids', 'imagePath': 'assets/images/kids.png'},
              ]),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        TextButton(
            onPressed: () {},
            child: Text(
              "View all",
              style: const TextStyle(fontSize: 16, color: kActiveColor),
            ))
      ],
    );
  }

  Widget _buildCategoryGrid(List<Map<String, String>> categories) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(
                  categories[index]['imagePath'] ?? 'assets/icons/default.png',
                  fit: BoxFit.cover,
                  height: 130,
                  width: double.infinity,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(135, 0, 0, 0),
                        Color(0x66666680),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12.0),
                      bottomRight: Radius.circular(12.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      categories[index]['name'] ?? 'Unknown',
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
