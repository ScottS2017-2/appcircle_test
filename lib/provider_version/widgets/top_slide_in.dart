import 'package:flutter/material.dart';
import 'package:crypto_tracker_redux/app/app_colors.dart';
import 'package:crypto_tracker_redux/app/app_textstyles.dart';
import 'package:crypto_tracker_redux/app/app_strings.dart';
import 'package:crypto_tracker_redux/provider_version/models/app_state_model.dart';

import 'package:provider/provider.dart';

class TopSlideIn extends StatelessWidget {
  const TopSlideIn({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    final interestedInPrices =
        context.select((AppStateModel appState) => appState.interestedInPrices);
    return Container(
      height: height,
      width: width,
      margin: const EdgeInsets.only(top: 30, bottom: 30),
      padding: const EdgeInsets.all(20),
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        border: Border.all(
          style: BorderStyle.solid,
          color: const Color(0xFFBBBBBB),
          width: 3,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          const BoxShadow(
            color: Colors.black87,
            blurRadius: 8,
            offset: Offset(4, 6),
          ),
        ],
        gradient: const LinearGradient(
          colors: [
            Color(0xFFB7459C),
            Color(0xFF0185D0),
          ],
          stops: [
            0,
            1,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Text(
            'Commodities',
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: AppColors.offWhitePageBackground, shadows: [
              BoxShadow(
                color: AppColors.blackTextColor,
                blurRadius: 2,
                offset: Offset(1, 1),
              ),
            ]),
          ),
          SizedBox(
            height: 16,
          ),
          //////////////////////////////////////////////////////////////
          // Top List Box
          //////////////////////////////////////////////////////////////
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.silver,
                border: Border.all(
                  style: BorderStyle.solid,
                  color: const Color(0xFFBBBBBB),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListView.builder(
                itemCount: AppStrings.commoditiesAndTheirDenominations.length,
                itemBuilder: (BuildContext context, int index) {
                  return TextButton(
                    onPressed: () => {},
                    style: ButtonStyle(
padding: ButtonStyleButton.allOrNull<EdgeInsetsGeometry>(EdgeInsets.all(0)),
                      backgroundColor:
                      MaterialStateProperty.resolveWith<Color?>(

                            (Set<MaterialState> states) {
                              Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.5);
                        },
                      ),
                    ),
                    child: Text(
                      '${AppStrings.unabbreviatedTerms[AppStrings.commoditiesAndTheirDenominations[index]]}',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.normal12,
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            'Denominations',
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: AppColors.offWhitePageBackground, shadows: [
              BoxShadow(
                color: AppColors.blackTextColor,
                blurRadius: 2,
                offset: Offset(1, 1),
              ),
            ]),
          ),
          SizedBox(
            height: 16,
          ),
          //////////////////////////////////////////////////////////////
          // Bottom List Box
          //////////////////////////////////////////////////////////////
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.silver,
                border: Border.all(
                  style: BorderStyle.solid,
                  color: const Color(0xFFBBBBBB),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListView.builder(
                itemCount: AppStrings.denominationsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return TextButton(
                    onPressed: () => {},
                    child: Text(
                      '${AppStrings.unabbreviatedTerms[AppStrings.denominationsList[index]]}',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.normal12,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );

    // return Container(
    //   height: 500,
    //   width: 175,
    //   decoration: BoxDecoration(
    //     color: AppColors.blackTextColor,
    //     border: Border.all(
    //       color: AppColors.blackTextColor,
    //       width: 2,
    //     ),
    //     borderRadius: const BorderRadius.all(
    //       Radius.circular(20),
    //     ),
    //   ),
    //   child: ListView(
    //     padding: EdgeInsets.zero,
    //     children: <Widget>[
    //       Container(
    //         decoration: BoxDecoration(
    //           color: color,
    //         ),
    //         child: Container(
    //           alignment: Alignment.center,
    //           child: Text(
    //             'Left Header',
    //             style: AppTextStyles.appBarTextStyle
    //                 .copyWith(color: Colors.white, fontSize: 18),
    //           ),
    //         ),
    //       ),
    //       ListTile(
    //         title: const Text('First Item'),
    //         onTap: () {
    //           // TODO implement me
    //         },
    //       ),
    //       ListTile(
    //         title: const Text('Second Item'),
    //         onTap: () {
    //           // TODO implement me
    //         },
    //       ),
    //       ListTile(
    //         title: const Text('Third Item'),
    //         onTap: () {
    //           // TODO implement me
    //         },
    //       ),
    //     ],
    //   ),
    // );
  }
}
