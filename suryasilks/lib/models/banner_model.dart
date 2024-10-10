class BannerModel {
  final int id;
  final int linkType;
  final String linkValue;
  final String image;
  final String title;
  final String subTitle;

  BannerModel({
    required this.id,
    required this.linkType,
    required this.linkValue,
    required this.image,
    required this.title,
    required this.subTitle,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'],
      linkType: json['link_type'],
      linkValue: json['link_value'],
      image: 'https://example.com/images/${json['image']}',
      title: json['title'],
      subTitle: json['sub_title'],
    );
  }
}
