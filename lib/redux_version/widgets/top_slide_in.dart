import 'package:crypto_tracker_redux/app/app_colors.dart';
import 'package:crypto_tracker_redux/app/app_textstyles.dart';
import 'package:crypto_tracker_redux/redux_version/models/symbol_model.dart';
import 'package:crypto_tracker_redux/redux_version/models/view_model.dart';
import 'package:crypto_tracker_redux/widgets_common_to_all_versions/custom_border_box.dart';
import 'package:flutter/material.dart';

class TopSlideIn extends StatelessWidget {
  TopSlideIn({
    Key? key,
    required this.height,
    required this.width,
    required this.viewModel,
  }) : super(key: key);

  final double height;
  final double width;
  final ViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      alignment: Alignment.topCenter,
      child: CustomBorderBox(
        onPressed: () => {},
        gradientColorOne: AppColors.oliveAccent,
        gradientColorTwo: Theme.of(context).primaryColor,
        insetColor: Theme.of(context).scaffoldBackgroundColor,
        innerBorderThickness: 1,
        outerCornerRadius: 20,
        innerCornerRadius: 20,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Commodities',
                style:
                    Theme.of(context).textTheme.headline5!.copyWith(color: AppColors.offWhitePageBackground, shadows: [
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
              //-------
              // Commodities List Box
              //-------
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
                  child: Builder(
                    builder: (BuildContext context) {
                      final commoditiesHistoryKeys = viewModel.allCommoditiesHistory.keys.toList();
                      final uniqueCommodities = commoditiesHistoryKeys.fold<List<SymbolModel>>(
                        <SymbolModel>[],
                        (List<SymbolModel> prev, SymbolModel symbol) {
                          if (prev.any((element) => element.commodity == symbol.commodity)) {
                            return prev;
                          }
                          prev.add(symbol);
                          return prev;
                        },
                      );
                      uniqueCommodities.sort((SymbolModel left, SymbolModel right) {
                        return left.commodityFull.toLowerCase().compareTo(right.commodityFull.toLowerCase());
                      });
                      return ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        itemCount: uniqueCommodities.length,
                        itemBuilder: (BuildContext context, int index) {
                          final symbol = uniqueCommodities[index];
                          return TextButton(
                            onPressed: () {
                              viewModel.updateApplicableDenominations(mapKey: symbol);
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
                              symbol.commodityFull,
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
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'Denominations',
                style:
                    Theme.of(context).textTheme.headline5!.copyWith(color: AppColors.offWhitePageBackground, shadows: [
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
              //-------
              // Denominations List Box
              //-------
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
                  child: Builder(
                    builder: (BuildContext context) {
                      final denominations = viewModel.denominationsApplicableToCurrentCommodity;
                      if (denominations.isEmpty) {
                        return Center(
                          child: FittedBox(
                            child: Text(
                              'Select a Commodity from Above',
                              style: AppTextStyles.normal16,
                            ),
                          ),
                        );
                      } else {
                        final uniqueDenominations = denominations.fold<List<SymbolModel>>(
                          <SymbolModel>[],
                          (List<SymbolModel> prev, SymbolModel symbol) {
                            if (prev.any((element) => element.commodity == symbol.commodity)) {
                              return prev;
                            }
                            prev.add(symbol);
                            return prev;
                          },
                        );
                        uniqueDenominations.sort((SymbolModel left, SymbolModel right) {
                          return left.commodityFull.toLowerCase().compareTo(right.commodityFull.toLowerCase());
                        });
                        return ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          itemCount: denominations.length,
                          itemBuilder: (BuildContext context, int index) {
                            final symbol = denominations[index];
                            return TextButton(
                              onPressed: () => viewModel.addInterestedInItem(mapKey: symbol),
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
                                symbol.denominationFull,
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
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
