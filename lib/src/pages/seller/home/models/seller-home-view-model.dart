class SellerHomeViewModel {
  final String tittle;
  final String description;
  final String? image;
  final List<String> colors;
  final int price, count, id;
  final bool isActive;

  SellerHomeViewModel(
      this.image,
      this.description,
      this.colors, {
        required this.id,
        required this.tittle,
        required this.price,
        required this.count,
        required this.isActive,
      });

  factory SellerHomeViewModel.fromJson(Map<String, dynamic> json) {
    return SellerHomeViewModel(
      json['image'],
      json['description'],
      json['colors'].cast<String>(),
      id: json['id'],
      tittle: json['tittle'],
      price: json['price'],
      count: json['count'],
      isActive: json['isActive'],
    );
  }
}