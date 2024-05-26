class FoodCart {
  final String foodName;
  final String foodCuisine;
  final double foodPrice;
  final int quantity;
  final double totalPrice;
  final int id;


  FoodCart({
    required this.foodName,
    required this.foodCuisine,
    required this.foodPrice,
    required this.quantity,
    required this.totalPrice,
    required this.id,


  });

  factory FoodCart.fromJson(Map<String, dynamic> json) {
    return FoodCart(
      foodName: json['foodName'],
      foodCuisine: json['foodCuisine'],
      foodPrice: json['foodPrice'].toDouble(),
      quantity: json['quantity'],
      totalPrice: json['totalPrice'].toDouble(),
      id: json['id'],

    );
  }
}