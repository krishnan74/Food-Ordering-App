import 'package:supabase_flutter/supabase_flutter.dart';

import '../Models/FoodModel.dart';
import '../Models/FoodCartModel.dart';


Future<List<Food>> getFutureFood(List<String> foodTypeConditions, List<String> foodCuisineConditions, SupabaseClient supabase) async {
  List<Food> filteredFoods = [];

  if (foodTypeConditions.isEmpty && foodCuisineConditions.isEmpty) {
    final response = await supabase.from('foodTable').select('*');
    return response.map((item) => Food.fromJson(item)).toList();
  }
  else if (foodTypeConditions.isNotEmpty && foodCuisineConditions.isNotEmpty){

    final filterResponse = await supabase.from('foodTable').select('*').inFilter('foodType', foodTypeConditions).inFilter('foodCuisine', foodCuisineConditions);


    return filterResponse.map((item) => Food.fromJson(item)).toList();


  }
  else{
    if (foodTypeConditions.isNotEmpty && foodCuisineConditions.isEmpty) {
      for (String foodType in foodTypeConditions) {
        final foodTypeResponse = await supabase.from('foodTable').select('*').eq('foodType', foodType);
        filteredFoods.addAll(foodTypeResponse.map((item) => Food.fromJson(item)).toList());
      }
    }

    if (foodCuisineConditions.isNotEmpty && foodTypeConditions.isEmpty) {
      for (String foodCuisine in foodCuisineConditions) {
        final foodCuisineResponse = await supabase.from('foodTable').select('*').eq('foodCuisine', foodCuisine);
        filteredFoods.addAll(foodCuisineResponse.map((item) => Food.fromJson(item)).toList());
      }
    }

    return filteredFoods;
  }
}

Future<List<FoodCart>> getCartItems(SupabaseClient supabase) async {
    final response = await supabase.from('cartTable').select('*');
    return response.map((item) => FoodCart.fromJson(item)).toList();
}


Future<List<String>> getCuisines(SupabaseClient supabase) async{
  final response = await supabase.from('foodTable').select('foodCuisine');
  final cuisines = response.map((cuisine) => cuisine['foodCuisine'].toString()).toList();
  return cuisines.toSet().toList();
}

Future<List<String>> getFoodTypes(SupabaseClient supabase) async{
  final response = await supabase.from('foodTable').select('foodType');
  final foodTypes = response.map((cuisine) => cuisine['foodType'].toString()).toList();
  return foodTypes.toSet().toList();
}