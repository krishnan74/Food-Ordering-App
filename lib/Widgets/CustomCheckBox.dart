import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox({
    Key? key,
    required this.isChecked,
    required this.onChecked,
    required this.variationString,
    required this.variationPrice,
  }) : super(key: key);

  final bool isChecked;
  final VoidCallback onChecked;
  final String variationString;
  final double variationPrice;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChecked,
      child: Container(
        color: isChecked ? Colors.blue.withOpacity(0.3) : Colors.transparent, // Change color based on selection state
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: isChecked ? Colors.blue : Colors.grey),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: isChecked ? Icon(Icons.check, size: 16, color: Colors.blue) : null,
              ),
            ),
            SizedBox(width: 8), // Add some space between checkbox and text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    variationString,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$ ${variationPrice.toString()}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
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
