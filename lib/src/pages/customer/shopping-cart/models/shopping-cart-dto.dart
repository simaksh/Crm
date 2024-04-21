

class ShoppingCartDto{
  final String tittle;
  final String? image, description;
  final List<String> colors;
  final int price, count, id;
  final bool isActive;

  ShoppingCartDto(
      this.image,
      this.description,
      this.colors, {
        required this.id,
        required this.tittle,
        required this.price,
        required this.count,
      }) : isActive = true ;

  Map<String , dynamic> toJson(){
    return{
      'id': id,
      'tittle': tittle,
      'description': description,
      'count': count,
      'price': price,
      'image': image,
      'colors': colors,
      'isActive': isActive,
    };
  }
}