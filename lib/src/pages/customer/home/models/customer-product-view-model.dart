class CustomerProductViewModel {
  final String tittle;
  final String? image, description;
  final List<String> colors;
  final int price, count, id;
  final bool isActive;

  CustomerProductViewModel(
      this.image,
      this.description,
      this.colors, {
        required this.id,
        required this.tittle,
        required this.price,
        required this.count,
        required this.isActive,
      });

  factory CustomerProductViewModel.fromJson(Map<String, dynamic> json) {
    return CustomerProductViewModel(
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
