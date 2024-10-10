import 'package:get/get.dart';
import 'package:suryasilks/models/homepage_productmodels.dart';

import '../api/homepage_api.dart';
import '../models/banner_model.dart';

class HomepageController extends GetxController {
  var banners = <BannerModel>[].obs;
  var recentViews = <ProductModel>[].obs;
  var ourProducts = <ProductModel>[].obs;
  var isLoading = true.obs;
  final HomepageApiService bannerService;

  HomepageController(this.bannerService);
  var activeIndex = 0.obs;

  void fetchedData(String id, String token) async {
    try {
      isLoading(true);
      final fetchedData = await bannerService.fetchAllItems(id, token);
      banners.assignAll(fetchedData['banners']);
      recentViews.assignAll(fetchedData['recentViews']);
      ourProducts.assignAll(fetchedData['our_products']);
    } catch (e) {
      print("Error fetching banners: $e");
    } finally {
      isLoading(false);
    }
  }

  void updateCarouselIndex(int index) {
    activeIndex.value = index;
  }
}
