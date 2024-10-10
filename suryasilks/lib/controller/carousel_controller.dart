import 'package:get/get.dart';
import '../api/banner_api.dart';
import '../models/banner_model.dart';

class CustomCarouselController extends GetxController {
  var activeIndex = 0.obs;

  void updateIndex(int index) {
    activeIndex.value = index;
  }
}

class BannerController extends GetxController {
  var banners = <BannerModel>[].obs;
  final BannerService bannerService;
  final CustomCarouselController carouselController =
      Get.put(CustomCarouselController());

  BannerController(this.bannerService);

  @override
  void onInit() {
    super.onInit();
    fetchBanners();
  }

  void fetchBanners() async {
    try {
      final fetchedBanners = await bannerService.fetchBanners();
      banners.assignAll(fetchedBanners);
    } catch (e) {
      print("Error fetching banners: $e");
    }
  }

  void updateCarouselIndex(int index) {
    carouselController.updateIndex(index);
  }
}
