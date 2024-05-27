import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FoodCard extends StatelessWidget {
  const FoodCard({
    super.key,
    required this.foodName,
    required this.foodRate,
    required this.foodCuisine,
    required this.foodPic,
    required this.onTap,
  });

  final VoidCallback onTap;
  final String foodName;
  final double foodRate;
  final String foodCuisine;
  final String foodPic;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(250, 250, 250, 1.0),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
              child: Image.network(
                foodPic,

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
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(foodName, style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,

                      ),),
                      Text(foodCuisine,  style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey

                      ),),
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Color.fromRGBO(253, 253, 253, 1.0),
                      ),
                      child: Text('\$ ${foodRate.toString()}', style: TextStyle(
                        color: Color.fromRGBO(251,127,107, 1.0),
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0
                      ),)
                  )

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
