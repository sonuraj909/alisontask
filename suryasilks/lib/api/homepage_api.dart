import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/banner_model.dart';
import '../models/homepage_productmodels.dart';

class HomepageApiService {
  Future<Map<String, dynamic>> fetchAllItems(String id, String token) async {
    final response = await http.post(Uri.parse(
        'https://swan.alisonsnewdemo.online/api/home?id=$id&token=$token'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      List<BannerModel> banners = [];
      List<ProductModel> recentViews = [];
      List<ProductModel> ourProducts = [];

      for (var banner in data['banner1']) {
        banners.add(BannerModel.fromJson(banner));
      }
      for (var banner in data['banner3']) {
        banners.add(BannerModel.fromJson(banner));
      }
      for (var banner in data['banner4']) {
        banners.add(BannerModel.fromJson(banner));
      }

      for (var product in data['recentviews']) {
        recentViews.add(ProductModel.fromJson(product));
      }

      for (var product in data['our_products']) {
        ourProducts.add(ProductModel.fromJson(product));
      }

      return {
        'banners': banners,
        'recentViews': recentViews,
        'our_products': ourProducts,
      };
    } else {
      throw Exception('Failed to load banners');
    }
  }
}
