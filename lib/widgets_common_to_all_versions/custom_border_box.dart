import 'package:crypto_tracker_redux/app/app_colors.dart';
import 'package:crypto_tracker_redux/app/app_textstyles.dart';
import 'package:flutter/material.dart';

class CustomBorderBox extends StatelessWidget {
  const CustomBorderBox({
    Key? key,
    required this.onPressed,
    required this.child,
    required this.gradientColorOne,
    required this.gradientColorTwo,
    required this.insetColor,
    required this.innerBorderThickness,
    required this.outerCornerRadius,
    required this.innerCornerRadius,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Widget child;
  final Color gradientColorOne;
  final Color gradientColorTwo;
  final Color insetColor;
  final double innerBorderThickness;
  final double outerCornerRadius;
  final double innerCornerRadius;

  @override
  Widget build(BuildContext context) {
    //-------
    // This is a custom setup to achieve the
    // unique, double-bordered look (the white edge)
    //-------
    return Material(
      borderRadius: BorderRadius.circular(outerCornerRadius),
      elevation: 2,
      child: InkWell(
        onTap: onPressed,
        //-------
        // The base layer
        //-------
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(innerCornerRadius),
            gradient: LinearGradient(
              colors: [
                gradientColorOne,
                gradientColorTwo,
              ],
              begin: Alignment(-2, -1.75),
              end: Alignment(2, 1.75),
              stops: [0, 1],
            ),
          ),
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.all(1),
                  child: Ink(
                    decoration: BoxDecoration(
                      //-------
                      // This border creates the inset look
                      //-------
                      border: Border.all(
                        width: innerBorderThickness,
                        color: insetColor,
                      ),
                      borderRadius: BorderRadius.circular(innerCornerRadius),
                    ),
                  ),
                ),
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}