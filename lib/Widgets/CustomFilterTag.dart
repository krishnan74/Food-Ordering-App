import 'package:flutter/material.dart';

class CustomFilterTag extends StatefulWidget {
  final String tagString;
  final VoidCallback onSelected;

  const CustomFilterTag({
    Key? key,
    required this.tagString,
    required this.onSelected,
  }) : super(key: key);

  @override
  _CustomFilterTagState createState() => _CustomFilterTagState();
}

class _CustomFilterTagState extends State<CustomFilterTag> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

        setState(() {
          isChecked = !isChecked;
        });
        widget.onSelected();
      },
      child: Center(
        child: Container(
          width: 120.0,

          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: isChecked ? Color.fromRGBO(251, 127, 107, 1.0) : Colors.grey),
            color: isChecked ? Color.fromRGBO(251, 127, 107, 1.0) : Colors.white,
          ),
          child: Text(
            widget.tagString,
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
              color: isChecked ? Colors.white : Color.fromRGBO(0, 0, 0, 1),
            ),
          ),
        ),
      ),
    );
  }
}
