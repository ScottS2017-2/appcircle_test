import 'package:crypto_tracker_redux/app/app_colors.dart';
import 'package:crypto_tracker_redux/app/app_textstyles.dart';
import 'package:crypto_tracker_redux/widgets_common_to_all_versions/custom_border_box.dart';
import 'package:flutter/material.dart';

class CustomBorderButton extends StatelessWidget {
  const CustomBorderButton({
    Key? key,
    required this.onPressed,
    required this.height,
    this.width,
    required this.gradientColorOne,
    required this.gradientColorTwo,
    required this.insetColor,
    required this.child,
  }) : super(key: key);

  final VoidCallback onPressed;
  final double? height;
  final double? width;
  final Color gradientColorOne;
  final Color gradientColorTwo;
  final Color insetColor;
  final Widget child;

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
        height: height,
        width: width,
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
