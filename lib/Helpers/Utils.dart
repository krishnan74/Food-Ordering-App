import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart'; // Import the Fluttertoast package
import 'package:supabase_flutter/supabase_flutter.dart';
import '../Models/FoodModel.dart';

Future<void> addToCart(Food food, bool variation1Check, bool variation2Check, bool variation3Check, bool variation4Check, int quantity, SupabaseClient supabase) async {
  double foodPrice = food.foodRate;

  // Calculate total price based on variations
  if (variation1Check) foodPrice += food.price1;
  if (variation2Check) foodPrice += food.price2;
  if (variation3Check) foodPrice += food.price3;
  if (variation4Check) foodPrice += food.price4;

  double totalPrice = foodPrice * quantity;

  try {
    await supabase
        .from('cartTable')
        .insert([
      {'foodName': food.foodName, 'foodCuisine': food.foodCuisine, 'foodPrice': foodPrice, 'quantity': quantity, 'totalPrice': totalPrice}
    ]);

    // Show toast for successful update
    Fluttertoast.showToast(
      msg: "Item added to cart successfully",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  } catch (error) {
    // Handle error
    print("Error: $error");

    // Show toast for error
    Fluttertoast.showToast(
      msg: "Error adding item to cart",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
