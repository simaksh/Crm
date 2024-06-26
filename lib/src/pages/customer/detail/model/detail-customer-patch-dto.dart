class DetailCustomerPathDto{
  final String tittle;
  final String? image, description;
  final List<String> colors;
  final int price, count, selectedCount, id, userId, productId;

  DetailCustomerPathDto(
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'productId': productId,
      'tittle': tittle,
      'description': description,
      'count': count,
      'price': price,
      'image': image,
      'colors': colors,
      'selectedCount': selectedCount,
    };
  }
}