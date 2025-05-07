import 'package:flutter/material.dart';

class LabelledText extends StatelessWidget {
  final String boldedWord;
  final String regularWord;
  final double wordSize;

  const LabelledText({
    super.key,
    required this.boldedWord,
    required this.regularWord,
    required this.wordSize

    }
  );

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: boldedWord,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: wordSize),
          ),
          TextSpan(
            text: regularWord,
            style: TextStyle(fontSize: wordSize),
          ),
        ],
      )
    );
  }
}