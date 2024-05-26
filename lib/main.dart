import 'dart:convert';
import 'package:epicure_intern_task/FoodDetailsPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:epicure_intern_task/Widgets/FoodCard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './Models/FoodModel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food App',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(), // Set Poppins as the default font
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

Future<List<Food>> getFutureFood() async {
  final response = await supabase.from('foodTable').select('*');

  final data = response;
  return data.map((item) => Food.fromJson(item)).toList();
}

class _MyHomePageState extends State<MyHomePage> {


  Future<List<Food>>? futureFood;

  @override
  void initState() {
    super.initState();
    futureFood = getFutureFood();

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Color.fromRGBO(251,127,107, 1.0),

        title: Text(widget.title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 2.0),),
      )
      ,

      body: FutureBuilder<List<Food>>(
        future: futureFood,
        builder: (context, snapshot){
          if(snapshot.hasData){
            return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),

              itemCount: snapshot.data!.length,
              itemBuilder: (context, index){
                final food = snapshot.data![index];
                return FoodCard(foodName: food.foodName, foodRate: food.foodRate, foodCuisine: food.foodCuisine, foodPic: food.foodPic,
                  onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FoodDetailsPage(food: food)));
                  },);
              }, separatorBuilder: (context, index) => SizedBox(
                  height: 20.0,
                )
            );
          }

          else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
          } else {
          return const Center(child: CircularProgressIndicator());
          }
        }
      )


    );
  }
}
