import 'dart:convert';
import 'package:epicure_intern_task/FoodDetailsPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:epicure_intern_task/Widgets/FoodCard.dart';
import './Helpers/Utils.dart';
import './Widgets/CustomFilterTag.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './Models/FoodModel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import './Helpers/Fetchers.dart';
import 'CartPage.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://vfyywkisbusuechqcbwc.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZmeXl3a2lzYnVzdWVjaHFjYndjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTY2NDM1MzksImV4cCI6MjAzMjIxOTUzOX0.TJ43dxV8RYEErqQgv6AM1L3W7CQy-p4AVsdjGrEzaDI',
  );

  runApp(MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
    ),
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {


  Future<List<Food>>? futureFood;
  Future<List<String>>? cuisines;
  Future<List<String>>? foodTypes;

  List<String> foodTypeFilters = [];
  List<String> foodCuisineFilters = [];

  @override
  void initState() {
    super.initState();
    futureFood = getFutureFood(foodTypeFilters, foodCuisineFilters, supabase);
    cuisines = getCuisines(supabase);
    foodTypes = getFoodTypes(supabase);

  }

  void addCuisineFilter(String cuisineFilter){
    if( foodCuisineFilters.contains(cuisineFilter)){
      foodCuisineFilters.remove(cuisineFilter);
    }
    else{
      foodCuisineFilters.add(cuisineFilter);
    }
    updateFilteredFoods();
  }

  void addFoodTypeFilter(String foodTypeFilter){
    if( foodTypeFilters.contains(foodTypeFilter)){
      foodTypeFilters.remove(foodTypeFilter);
    }
    else{
      foodTypeFilters.add(foodTypeFilter);
    }
    updateFilteredFoods();
  }


  void updateFilteredFoods(){
    setState(() {
      futureFood = getFutureFood(foodTypeFilters, foodCuisineFilters, supabase);
    });

  }


  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Welcome to \n',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: 'Flavor Central! ',
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(251, 127, 107, 1.0),
                            ),
                          ),


                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5.0),

                      decoration: BoxDecoration(
                          color: Color.fromRGBO(251, 127, 107, 1.0),
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: IconButton(

                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CartPage(supabase: supabase,)),
                            );
                          }, icon: Icon(Icons.shopping_cart, color: Colors.white)),
                    )
                  ],
                ),

                SizedBox(height: 5.0),

                FutureBuilder<List<String>>(
                  future: cuisines,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      return SizedBox(
                        height: 50.0,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                          separatorBuilder: (context, index) => SizedBox(width: 20.0),
                          itemBuilder: (context, index) {
                            final cuisine = snapshot.data![index];

                            return CustomFilterTag(
                                onSelected: () => addCuisineFilter(cuisine)
                            , tagString: cuisine);
                          },
                        ),
                      );
                    } else {
                      return Center(child: Text('No cuisines available'));
                    }
                  },
                ),

                FutureBuilder<List<String>>(
                  future: foodTypes,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      return SizedBox(
                        height: 50.0,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                          separatorBuilder: (context, index) => SizedBox(width: 20.0),
                          itemBuilder: (context, index) {
                            final foodType = snapshot.data![index];

                            return CustomFilterTag(
                                onSelected: () => addFoodTypeFilter(foodType)
                                , tagString: foodType);
                          },
                        ),
                      );
                    } else {
                      return Center(child: Text('No cuisines available'));
                    }
                  },
                )


              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Food>>(
              future: futureFood,
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index){
                      final food = snapshot.data![index];
                      return FoodCard(
                        foodName: food.foodName,
                        foodRate: food.foodRate,
                        foodCuisine: food.foodCuisine,
                        foodPic: food.foodPic,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FoodDetailsPage(food: food, supabase: supabase,)),
                          );
                        },
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 20.0),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
