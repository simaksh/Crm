class DetailCustomerViewModel {
  final String tittle;
  final String? image, description;
  final List<dynamic> colors;
  final int price, count, id;
  final bool isActive;

  DetailCustomerViewModel(
      this.image,
      this.description,
      this.colors, {
        required this.id,
        required this.tittle,
        required this.price,
        required this.count,
        required this.isActive,
      });

  factory DetailCustomerViewModel.fromJson(Map<String, dynamic> json) {
    return DetailCustomerViewModel(
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
