class FoodCart {
  final String foodName;
  final String foodCuisine;
  final double foodPrice;
  final int quantity;
  final double totalPrice;
  final int id;
  final List<String> variations;


  FoodCart({
    required this.foodName,
    required this.foodCuisine,
    required this.foodPrice,
    required this.quantity,
    required this.totalPrice,
    required this.id,
    required this.variations,


  });

  factory FoodCart.fromJson(Map<String, dynamic> json) {

    List<String> variations = (json['variations'] as List<dynamic>).map((e) => e.toString()).toList();

    return FoodCart(
      foodName: json['foodName'],
      foodCuisine: json['foodCuisine'],
      foodPrice: json['foodPrice'].toDouble(),
      quantity: json['quantity'],
      totalPrice: json['totalPrice'].toDouble(),
      id: json['id'],
      variations: variations,
    );
  }

}