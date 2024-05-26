import 'package:flutter/material.dart';
import '../Models/FoodCartModel.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({super.key, required this.cartItem, required this.onTap});
  final FoodCart cartItem;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Color.fromRGBO(250, 250, 250, 1.0),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 0.8,
          color: Color.fromRGBO(251,127,107, 0.5),
        )

        
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(cartItem.foodName, style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,

              ),),
              Row(
                children: [
                  Text(cartItem.foodCuisine,  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey

                  ),),
                  SizedBox(width: 10.0),
                  Text('\$ ${cartItem.foodPrice.toString()}', style: TextStyle(
                      color: Color.fromRGBO(251,127,107, 0.6),
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0
                  ),),
                  SizedBox(width: 5.0),
                  Text('x ${cartItem.quantity.toString()}', style: TextStyle(
                      color: Color.fromRGBO(251,127,107, 0.6),
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0
                  ),)
                ],
              ),
            ],
          ),
          Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: Color.fromRGBO(253, 253, 253, 1.0),
              ),
              child: Text('\$ ${cartItem.totalPrice.toString()}', style: TextStyle(
                  color: Color.fromRGBO(251,127,107, 1.0),
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0
              ),)
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.all(5.0),

              decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(10.0)
              ),
              child:Icon(Icons.remove, color: Colors.white)
            )

          )

        ],
      ),
    );
  }
}
