class ProductModel {
  final int productId;
  final String slug;
  final String code;
  final String name;
  final String? image;
  final String price;
  final String store;
  final String manufacturer;
  final bool isInCart;
  final bool isInWishlist;

  ProductModel({
    required this.productId,
    required this.slug,
    required this.code,
    required this.name,
    this.image,
    required this.price,
    required this.store,
    required this.manufacturer,
    this.isInCart = false,
    this.isInWishlist = false,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: json['productId'] ?? 0,
      slug: json['slug'] ?? '',
      code: json['code'] ?? '',
      name: json['name'] ?? '',
      image: (json['image'] != null && json['image'] != "")
          ? 'https://swan.alisonsnewdemo.online/images/product/${json['image']}'
          : null,
      price: json['price'] ?? '0.00',
      store: json['store'] ?? '',
      manufacturer: json['manufacturer'] ?? '',
      isInCart: json['cart'] == 1,
      isInWishlist: json['wishlist'] == 1,
    );
  }

  Map<String, String> toMap() {
    return {
      'imageUrl': image ?? '',
      'title': name,
      'price': price,
      'originalPrice': price,
      'discount': '',
    };
  }
}
