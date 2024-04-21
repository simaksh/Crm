class SellerEditViewModel {
  final String tittle;
  final String? description, image;
  final int count, price, id;
  final List<String> colors;
  final bool isActive;

  SellerEditViewModel(
      this.image,
      this.description,
      this.colors, {
        required this.id,
        required this.tittle,
        required this.price,
        required this.count,
        required this.isActive,
      });

  factory SellerEditViewModel.fromJson(Map<String, dynamic> json) {
    return SellerEditViewModel(
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
