import 'package:crypto_tracker_redux/app/app_colors.dart';
import 'package:crypto_tracker_redux/app/app_textstyles.dart';
import 'package:flutter/material.dart';

class SideSlideIn extends StatelessWidget {

  const SideSlideIn({
    Key? key,
}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: 175,
      color: AppColors.offWhitePageBackground,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.red,
            ),
            child: Container(
              alignment: Alignment.center,
              child: Text(
                'Left Header',
                style: AppTextStyles.appBarTextStyle
                    .copyWith(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
          ListTile(
            title: const Text('First Item'),
            onTap: () {
              // TODO implement me
            },
          ),
          ListTile(
            title: const Text('Second Item'),
            onTap: () {
              // TODO implement me
            },
          ),
          ListTile(
            title: const Text('Third Item'),
            onTap: () {
              // TODO implement me
            },
          ),
        ],
      ),
    );
  }
}