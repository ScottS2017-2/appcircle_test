import 'package:crypto_tracker_redux/app/app_colors.dart';
import 'package:crypto_tracker_redux/app/app_strings.dart';
import 'package:crypto_tracker_redux/app/app_textstyles.dart';
import 'package:crypto_tracker_redux/main.dart';
import 'package:crypto_tracker_redux/provider_version/models/app_state_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomSlideIn extends StatelessWidget {
  const BottomSlideIn({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
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
        gradient: LinearGradient(
          colors: [
            AppColors.oliveAccent,
            Theme.of(context).primaryColor,

          ],
          stops: [
            0,
            1,
          ],
          begin: Alignment(-1.0, -1.75),
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Text(
            AppStrings.following,
            style: Theme.of(context).textTheme.headline5!.copyWith(color: AppColors.offWhitePageBackground, shadows: [
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
              child: Column(
                children: [
                  Expanded(
                    child: Builder(
                      builder: (BuildContext context) {
                        final interestedInPricesSymbols =
                            context.select((AppStateModel appState) => appState.interestedInPrices.keys.toList());
                        return ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          itemCount: interestedInPricesSymbols.length,
                          itemBuilder: (BuildContext context, int index) {
                            final symbol = interestedInPricesSymbols[index];
                            return TextButton(
                              onPressed: () {
                                MyApp.appStateOf(context).removeFromInterestedInPrices(symbol);
                              },
                              style: ButtonStyle(
                                overlayColor: MaterialStateProperty.resolveWith((states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return Theme.of(context).primaryColor.withOpacity(.3);
                                  } else {
                                    Theme.of(context).primaryColor.withOpacity(.3);
                                  }
                                }),
                              ),
                              child: Text(
                                '${symbol.commodityFull} in ${symbol.denominationFull}',
                                textAlign: TextAlign.center,
                                style: AppTextStyles.normal16.copyWith(color: AppColors.blackTextColor),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Divider(
                                height: 2,
                                indent: 0,
                                endIndent: 0,
                                thickness: 2,
                                color: Theme.of(context).primaryColor.withOpacity(0.5),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
