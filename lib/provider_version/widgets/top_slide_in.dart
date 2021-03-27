import 'package:crypto_tracker_redux/app/app_colors.dart';
import 'package:crypto_tracker_redux/app/app_strings.dart';
import 'package:crypto_tracker_redux/app/app_textstyles.dart';
import 'package:crypto_tracker_redux/main.dart';
import 'package:crypto_tracker_redux/provider_version/models/app_state_model.dart';
import 'package:crypto_tracker_redux/provider_version/models/symbol_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopSlideIn extends StatelessWidget {
  TopSlideIn({
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
            Theme.of(context).primaryColor,
          Theme.of(context).accentColor,
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
              child: Builder(
                builder: (BuildContext context) {
                  final commoditiesHistoryKeys =
                      context.select((AppStateModel appState) => appState.allCommoditiesHistory.keys.toList());
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
                  return ListView.builder(
                    itemCount: uniqueCommodities.length,
                    itemBuilder: (BuildContext context, int index) {
                      final symbol = uniqueCommodities[index];
                      return TextButton(
                        onPressed: () {
                          MyApp.appStateOf(context).updateDenominationsApplicableToCurrentCommodity(symbol);
                        },
                        style: ButtonStyle(
                          padding: ButtonStyleButton.allOrNull<EdgeInsetsGeometry>(EdgeInsets.all(0)),
                          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              Theme.of(context).colorScheme.primary.withOpacity(0.5);
                            },
                          ),
                        ),
                        child: Text(
                          symbol.commodityFull,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.normal12,
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
              child: Builder(
                builder: (BuildContext context) {
                  final denominations = context.select(
                    (AppStateModel appState) => appState.denominationsApplicableToCurrentCommodity,
                  );
                  if (denominations.isEmpty) {
                    return Center(
                      child: Text('Select a Commodity from Above'),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: denominations.length,
                      itemBuilder: (BuildContext context, int index) {
                        final symbol = denominations[index];
                        return TextButton(
                          onPressed: () => MyApp.appStateOf(context).updateInterestedInPrices(symbol),
                          child: Text(
                            symbol.denominationFull,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.normal12,
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
    );
  }
}
