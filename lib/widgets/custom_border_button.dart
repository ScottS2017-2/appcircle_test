import 'package:crypto_tracker_redux/app/app_colors.dart';
import 'package:crypto_tracker_redux/app/app_textstyles.dart';
import 'package:crypto_tracker_redux/widgets/custom_border_box.dart';
import 'package:flutter/material.dart';

class CustomBorderButton extends StatelessWidget {
  const CustomBorderButton({
    Key? key,
    required this.onPressed,
    required this.child,
    required this.gradientColorOne,
    required this.gradientColorTwo,
    required this.insetColor,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Widget child;
  final Color gradientColorOne;
  final Color gradientColorTwo;
  final Color insetColor;

  @override
  Widget build(BuildContext context) {
    return CustomBorderBox(
      onPressed: onPressed,
      gradientColorOne: gradientColorOne,
      gradientColorTwo: gradientColorTwo,
      insetColor: insetColor,
      innerBorderThickness: 1,
      outerCornerRadius: 10,
      innerCornerRadius: 9,
      child: Container(
        padding: const EdgeInsets.all(12),
        height: 48,
        child: FittedBox(
          child: DefaultTextStyle.merge(
            style: AppTextStyles.normal24.copyWith(
              color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.95),
              shadows: [
                Shadow(
                  color: AppColors.dropShadowColor,
                  offset: Offset(2, 2),
                  blurRadius: 1,
                ),
              ],
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
