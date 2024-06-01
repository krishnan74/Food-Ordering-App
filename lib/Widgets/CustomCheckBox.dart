import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  final bool isChecked;
  final VoidCallback onChecked;
  final String variationString;
  final double variationPrice;

  const CustomCheckBox({
    Key? key,
    required this.isChecked,
    required this.onChecked,
    required this.variationString,
    required this.variationPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChecked,
      child: Container(
        width: 158.0,
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: isChecked ? Color.fromRGBO(251, 127, 107, 1.0) : Colors.grey),
          color: isChecked ? Color.fromRGBO(251, 127, 107, 1.0) : Colors.white
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [


            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    variationString,

                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                        color: isChecked ? Colors.white : Color.fromRGBO(0,0,0,1)

                    ),
                  ),

                Text(
                  '+\$$variationPrice',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: isChecked ? Color.fromRGBO(255, 255, 255, 0.8): Color.fromRGBO(251, 127, 107, 1.0)
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
