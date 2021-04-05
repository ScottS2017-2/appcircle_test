import 'package:crypto_tracker_redux/app/app_colors.dart';
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
               style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: AppColors.blackTextColor, shadows: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 2,
                  offset: Offset(1, 1),
                ),
              ]),
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
