import 'package:epicure_intern_task/Widgets/CustomCheckBox.dart';
import 'package:flutter/material.dart';
import './Models/FoodModel.dart';
import './Helpers/Utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class FoodDetailsPage extends StatefulWidget {
  const FoodDetailsPage({Key? key, required this.food, required this.supabase}) : super(key: key);

  final Food food;
  final SupabaseClient supabase;

  @override
  State<FoodDetailsPage> createState() => _FoodDetailsPageState(food: food, supabase: supabase);
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {
  final Food food;
  bool variation1Check = false;
  bool variation2Check = false;
  bool variation3Check = false;
  bool variation4Check = false;
  int quantity = 1;
  final SupabaseClient supabase;

  _FoodDetailsPageState({required this.food, required this.supabase});

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left:20.0, right: 20.0, top: 20.0, bottom: 0.0),
        child: ListView(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(
                food.foodPic,
                fit: BoxFit.fill,
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                  return const Icon(Icons.error);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            food.foodName,
                            style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            food.foodCuisine,
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Color.fromRGBO(253, 253, 253, 1.0),
                        ),
                        child: Text(
                          '\$ ${food.foodRate.toString()}',
                          style: TextStyle(
                            color: Color.fromRGBO(251, 127, 107, 1.0),
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    food.description,
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    "Choose your variation",
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomCheckBox(
                            isChecked: variation1Check,
                            onChecked: () {
                              setState(() {
                                variation1Check = !variation1Check;
                              });
                            },
                            variationString: food.variation1,
                            variationPrice: food.price1,
                          ),
                          CustomCheckBox(
                            isChecked: variation2Check,
                            onChecked: () {
                              setState(() {
                                variation2Check = !variation2Check;
                              });
                            },
                            variationString: food.variation2,
                            variationPrice: food.price2,
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomCheckBox(
                            isChecked: variation3Check,
                            onChecked: () {
                              setState(() {
                                variation3Check = !variation3Check;
                              });
                            },
                            variationString: food.variation3,
                            variationPrice: food.price3,
                          ),
                          CustomCheckBox(
                            isChecked: variation4Check,
                            onChecked: () {
                              setState(() {
                                variation4Check = !variation4Check;
                              });
                            },
                            variationString: food.variation4,
                            variationPrice: food.price4,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(

        surfaceTintColor: Colors.white,
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 10.0),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (quantity > 1) quantity--;
                      });
                    },
                  ),
                  Text(
                    quantity.toString(),
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        quantity++;
                      });
                    },
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  addToCart(food, variation1Check, variation2Check, variation3Check, variation4Check, quantity, supabase);
                },
                child: Text(
                  'Add to Cart',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  backgroundColor: Color.fromRGBO(251, 127, 107, 1.0)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
