class BannerModel {
  final int id;
  final String image;
  final String title;
  final String subTitle;

  BannerModel({
    required this.id,
    required this.image,
    required this.title,
    required this.subTitle,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'],
      image:
          'https://swan.alisonsnewdemo.online/images/banner/${json['image']}',
      title: json['title'],
      subTitle: json['sub_title'],
    );
  }
}
