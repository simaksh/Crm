class SoppingCartChoiceProductViewModel{
  final String tittle;
  final String? image, description;
  final List<dynamic> colors;
  final int price, count,selectedCount, id, userId, productId;

  SoppingCartChoiceProductViewModel(
      this.image,
      this.description,
      this.colors, {
        required this.id,
        required this.userId,
        required this.productId,
        required this.tittle,
        required this.price,
        required this.count,
        required this.selectedCount,
      });

  factory SoppingCartChoiceProductViewModel.fromJson(Map<String, dynamic> json) {
    return SoppingCartChoiceProductViewModel(
      json['image'],
      json['description'],
      json['colors'].cast<String>(),
      id: json['id'],
      userId: json['userId'],
      productId: json['productId'],
      tittle: json['tittle'],
      price: json['price'],
      count: json['count'],
      selectedCount: json['selectedCount'],
    );
  }

}