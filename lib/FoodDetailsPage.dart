import 'package:epicure_intern_task/Widgets/CustomCheckBox.dart';
import 'package:flutter/material.dart';
import './Models/FoodModel.dart';

class FoodDetailsPage extends StatefulWidget {
  const FoodDetailsPage({Key? key, required this.food}) : super(key: key);

  final Food food;

  @override
  State<FoodDetailsPage> createState() => _FoodDetailsPageState(food: food);
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {
  final Food food;
  bool variation1Check = false;
  bool variation2Check = false;
  bool variation3Check = false;
  bool variation4Check = false;

  _FoodDetailsPageState({required this.food});

  @override
  void initState() {
    super.initState();
    // You can perform any initialization tasks here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView( // Replace ListView with Column

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
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "Choose your variation ",
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true, // Added to ensure GridView takes up only the required space
                    crossAxisCount: 2, // Number of columns
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
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



}
