import 'package:flutter/material.dart';
import 'package:crypto_tracker_redux/app/app_colors.dart';
import 'package:crypto_tracker_redux/app/app_textstyles.dart';
import 'package:crypto_tracker_redux/app/app_strings.dart';
import 'package:crypto_tracker_redux/provider_version/models/app_state_model.dart';

import 'package:provider/provider.dart';

class SideSlideIn extends StatelessWidget {
  const SideSlideIn({
    Key? key,
    this.color = const Color(0xFFEEEEEE),
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    final interestedInPrices =
    context.select((AppStateModel appState) => appState.interestedInPrices);
    return Container(
      height: 400,
      width: 150,
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
            blurRadius: 12,
            offset: Offset(4, 6),
          ),
        ],
        gradient: const SweepGradient(
          colors: [
            Color(0xFF0185D0),
            Color(0xFFB7459C),
            Color(0xFFFF3780),
          ],
          stops: [
            0.5,
            0.75,
            1,
          ],
          center: Alignment(0.0, 1.0),
        ),
      ),
      child: Column(
        children: [
          Text(
            'Commodities',
            style: Theme.of(context)
                .textTheme
                .subtitle1!
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
                itemCount: interestedInPrices.length,
                itemBuilder: (BuildContext context, int index) {
                  String key = interestedInPrices.keys.elementAt(index);
                  final regex = RegExp(r'^([A-z]+)-([A-z]+)$');
                  final regexMatch = regex.firstMatch(key);
                  final currencyInterestedIn = regexMatch!.group(1);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
                        decoration: BoxDecoration(
                          color: AppColors.silver,
                          boxShadow: [
                            const BoxShadow(
                              color: AppColors.dropShadowColor,
                              blurRadius: 1,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                        child: Text(
                          '${AppStrings.unabbreviatedTerms[currencyInterestedIn]}',
                          textAlign: TextAlign.left,
                          style: AppTextStyles.normal12,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Center(
                          child: Text(
                            'in',
                            textAlign: TextAlign.left,
                            style: AppTextStyles.normal12,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
                        decoration: BoxDecoration(
                          color: AppColors.silver,
                          boxShadow: [
                            const BoxShadow(
                              color: AppColors.dropShadowColor,
                              blurRadius: 1,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                        child: Text(
                          'Denom',
                          textAlign: TextAlign.left,
                          style: AppTextStyles.normal12,
                        ),
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 12, left: 8, right: 8, bottom: 4),
                        color: AppColors.dropShadowColor,
                      ),
                    ],
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
