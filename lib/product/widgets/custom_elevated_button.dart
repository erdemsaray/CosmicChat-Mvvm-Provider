import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    required this.buttonTitle,
    this.buttonColor = Colors.blue,
    this.buttonTextStyle = textStyle,
    required this.buttonMetod,
    Key? key,
  }) : super(key: key);

  final String buttonTitle;
  final Color buttonColor;
  final TextStyle buttonTextStyle;
  final VoidCallback buttonMetod;
  static const TextStyle textStyle = TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
              ),
              onPressed: buttonMetod,
              child: SizedBox(
                  height: 50,
                  child: Center(
                      child: Text(
                    buttonTitle,
                    style: buttonTextStyle,
                  )))))
    ]);
  }
}
