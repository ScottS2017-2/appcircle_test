import 'package:crypto_tracker_redux/app/app_textstyles.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, BoxConstraints constraints) {
        return Padding(
          padding: EdgeInsets.all(16),
          child: Align(
            alignment: Alignment.topLeft,
            child: RichText(
              text: TextSpan(
                text: 'Hello ',
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(text: 'bold', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: ' world!'),
                ],
              ),
            )
          ),
        );
      },
    );
  }
}
