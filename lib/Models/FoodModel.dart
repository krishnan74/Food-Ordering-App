class Food {
  final String foodName;
  final double foodRate;
  final String foodCuisine;
  final String foodPic;
  final String foodType;

  final String variation1;
  final double price1;

  final String variation2;
  final double price2;

  final String variation3;
  final double price3;

  final String variation4;
  final double price4;


  Food({
    required this.foodName,
    required this.foodRate,
    required this.foodCuisine,
    required this.foodPic,
    required this.foodType,
    required this.variation1,
    required this. price1,
    required this.variation2,
    required this.price2,
    required this.variation3,
    required this.price3,
    required this.variation4,
    required this.price4,

  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      foodName: json['foodName'],
      foodRate: json['foodRate'].toDouble(),
      foodCuisine: json['foodCuisine'],
      foodPic: json['foodPic'],
      foodType: json['foodType'],
      variation1: json['variation1'],
      price1: json['price1'].toDouble(),
      variation2: json['variation2'],
      price2: json['price2'].toDouble(),
      variation3: json['variation3'],
      price3: json['price3'].toDouble(),
      variation4: json['variation4'],
      price4: json['price4'].toDouble(),
    );
  }
}