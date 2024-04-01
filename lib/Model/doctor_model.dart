class DoctorModel {
  String id;
  String name;
  String phone;
  String type;
  String category;
  String about;
  double goodReviews;
  String image;
  final int totalReviews;
  final double averageRating;

  DoctorModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.type,
    required this.category,
    required this.about,
    required this.goodReviews,
    required this.image,
    required this.totalReviews,
    required this.averageRating,
  });
}
