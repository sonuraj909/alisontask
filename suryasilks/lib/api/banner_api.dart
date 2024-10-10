import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/banner_model.dart';

class BannerService extends GetxService {
  Future<List<BannerModel>> fetchBanners() async {
    final response = await http.post(Uri.parse(
        'https://swan.alisonsnewdemo.online/api/home?id=bDy&token=rgJOILBv9qJYAKKfeNXaYmjqYS0m1ZELsTjFon7T'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      List<BannerModel> banners = [];
      print(banners);

      for (var banner in data['banner1']) {
        banners.add(BannerModel.fromJson(banner));
      }
      for (var banner in data['banner3']) {
        banners.add(BannerModel.fromJson(banner));
      }
      for (var banner in data['banner4']) {
        banners.add(BannerModel.fromJson(banner));
      }

      return banners;
    } else {
      throw Exception('Failed to load banners');
    }
  }
}
