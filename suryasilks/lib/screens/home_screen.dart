import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:suryasilks/constants/colors.dart';
import '../api/banner_api.dart';
import '../controller/carousel_controller.dart';
import '../models/banner_model.dart';
import '../widgets/proiduct_card.dart'; // Fix typo in import statement

class HomeScreen extends StatelessWidget {
  final CustomCarouselController carouselController =
      Get.put(CustomCarouselController());
  final BannerController bannerController =
      Get.put(BannerController(BannerService()));

  final List<String> imgList = [
    'assets/icons/image.png',
    'assets/icons/image.png',
    'assets/icons/image.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Commerce App'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Obx(() {
                if (bannerController.banners.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                }
                return CarouselSlider(
                  options: CarouselOptions(
                    height: 200.0,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      bannerController.updateCarouselIndex(index);
                    },
                  ),
                  items: bannerController.banners.map((BannerModel banner) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        // image: DecorationImage(
                        //   image: NetworkImage(banner
                        //       .image), // Use NetworkImage for remote images
                        //   fit: BoxFit.cover,
                        // ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            banner.title,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (banner.subTitle.isNotEmpty)
                            Text(
                              banner.subTitle,
                              style: const TextStyle(color: Colors.black),
                            ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              }),
              const SizedBox(height: 10),
              Obx(() {
                return SmoothPageIndicator(
                  controller: PageController(
                      initialPage: carouselController.activeIndex.value),
                  count: imgList.length,
                  effect: const ExpandingDotsEffect(
                    dotHeight: 8.0,
                    dotWidth: 8.0,
                    spacing: 4.0,
                    activeDotColor:
                        Colors.red, // Change to your active dot color
                  ),
                  onDotClicked: (index) =>
                      bannerController.updateCarouselIndex(index),
                );
              }),
              const SizedBox(height: 10),

              // Sections
              _buildCategoryGrid(['Mens', 'Womens', 'Kids']),
              _buildSectionTitle('September Hot Picks'),
              ProductGrid(), // Add first product grid
              _buildSectionTitle('Festival Collections'),
              ProductGrid(), // Add second product grid
              _buildSectionTitle('Trending Categories - Women'),
              _buildCategoryGrid(['Saree', 'Kurti', 'Shirt']),
              _buildSectionTitle('Trending Categories - Men'),
              _buildCategoryGrid(['Shirt', 'T-Shirt', 'Jeans']),
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

  Widget _buildCategoryGrid(List<String> categories) {
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
            borderRadius:
                BorderRadius.circular(12.0), // Adjust the border radius
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(12.0), // Same as card's border radius
                child: Image.asset(
                  "assets/icons/image.png", // Use your category images
                  fit: BoxFit.fitWidth,
                  height: 100,
                  width: double.infinity,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: kActiveColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12.0),
                      bottomRight: Radius.circular(12.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      categories[index],
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
