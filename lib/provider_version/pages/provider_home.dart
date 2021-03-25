import 'package:crypto_tracker_redux/app/app_strings.dart';
import 'package:crypto_tracker_redux/app/app_textstyles.dart';
import 'package:crypto_tracker_redux/provider_version/models/app_state_model.dart';
import 'package:crypto_tracker_redux/provider_version/widgets/top_slide_in.dart';
import 'package:crypto_tracker_redux/provider_version/widgets/bottom_slide_in.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderHome extends StatefulWidget {
  ProviderHome({
    Key? key,
  }) : super(key: key);

  @override
  _ProviderHomeState createState() => _ProviderHomeState();
}

class _ProviderHomeState extends State<ProviderHome>{

  bool onStage = false;

  static const double _largeScreenTopSlideHeight = 300;
  static const double _largeScreenTopSlideWidth = 600;
  static const double _largeScreenBottomSlideHeight = 600;
  static const double _largeScreenBottomSlideWidth = 600;
  static const double _largeScreenTopSlideExtendedPosition = -1;
  static const double _largeScreenTopSlideRetractedPosition = -2;
  static const double _largeScreenBottomSlideExtendedPosition = 4.0;
  static const double _largeScreenBottomSlideRetractedPosition = .4;

  static const double _smallScreenTopSlideHeight = 400;
  static const double _smallScreenTopSlideWidth = 300;
  static const double _smallScreenBottomSlideHeight = 200;
  static const double _smallScreenBottomSlideWidth = 300;
  static const double _smallScreenTopSlideExtendedPosition = -1.1;
  static const double _smallScreenTopSlideRetractedPosition = -4.75;
  static const double _smallScreenBottomSlideExtendedPosition = .75;
  static const double _smallScreenBottomSlideRetractedPosition = 2;

  void toggleSideSlides() {
    setState(() {
      onStage = !onStage;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // Fetch the values we care about
    final interestedInPrices =
        context.select((AppStateModel appState) => appState.interestedInPrices);
    final allCommoditiesHistory = context
        .select((AppStateModel appState) => appState.allCommoditiesHistory);
    //
    return Stack(
      fit: StackFit.expand,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Consumer<AppStateModel>(
                builder: (context, appState, child) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: interestedInPrices.length,
                      itemBuilder: (BuildContext context, int index) {
                        ////////////////////////////////////////////////
                        // Separate the commodity and denomination strings
                        String key = interestedInPrices.keys.elementAt(index);
                        String value = interestedInPrices[key].toString();
                        final regex = RegExp(r'^([A-z]+)-([A-z]+)$');
                        final regexMatch = regex.firstMatch(key);
                        final currencyInterestedIn = regexMatch!.group(1);
                        final denomination = regexMatch.group(2);
                        ////////////////////////////////////////////////
                        return Card(
                          borderOnForeground: true,
                          color: Colors.grey,
                          child: Container(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  '${AppStrings.unabbreviatedTerms[currencyInterestedIn]}:\n${value.padRight(2)} ${AppStrings.unabbreviatedTerms[denomination]}',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.normal24,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () =>
                        Provider.of<AppStateModel>(context, listen: false)
                            .fetchAndProcessUpdates(
                      outdatedHistory: allCommoditiesHistory,
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed))
                            return Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.5);
                          return null; // Use the component's default.
                        },
                      ),
                    ),
                    child: Text('Update Prices'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Provider.of<AppStateModel>(context, listen: false)
                          .denominationsApplicableToCurrentCommodity = [];
                      toggleSideSlides();
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed))
                            return Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.5);
                          return null; // Use the component's default.
                        },
                      ),
                    ),
                    child: Text('Edit Watchlist'),
                  ),
                ],
              ),
            ],
          ),
        ),
        LayoutBuilder(
          builder: (context, BoxConstraints constraints) {
            late Widget _result;
            // If the screen width > 1440
            if (constraints.maxHeight > 1440) {
              _result = Stack(
                fit: StackFit.expand,
                children: [
                  AnimatedContainer(
                    alignment: Alignment(0, onStage == false ? _largeScreenTopSlideExtendedPosition : _largeScreenTopSlideRetractedPosition),
                    duration: Duration(milliseconds: 300),
                    child: TopSlideIn(
                      height: _largeScreenTopSlideHeight,
                      width: _largeScreenTopSlideWidth,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(0, onStage == true ? _largeScreenBottomSlideExtendedPosition : _largeScreenBottomSlideRetractedPosition),
                    duration: Duration(milliseconds: 300),
                    child: BottomSlideIn(
                      height: _largeScreenBottomSlideHeight,
                      width: _largeScreenBottomSlideWidth,
                    ),
                  ),
                ],
              );
            } else  if (constraints.maxHeight <= 1140) {
              _result = Stack(
                fit: StackFit.expand,
                children: [
                  Offstage(
                    offstage: false,
                    child: AnimatedContainer(
                      alignment: Alignment(0, onStage == true ? _smallScreenTopSlideExtendedPosition : _smallScreenTopSlideRetractedPosition),
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeOutBack,
                      child: TopSlideIn(
                        height: _smallScreenTopSlideHeight,
                        width: _smallScreenTopSlideWidth,
                      ),
                    ),
                  ),
                  Offstage(
                    offstage: false,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeOutBack,
                      alignment: Alignment(0, onStage == true ? _smallScreenBottomSlideExtendedPosition : _smallScreenBottomSlideRetractedPosition),
                      child: BottomSlideIn(
                        height: _smallScreenBottomSlideHeight,
                        width: _smallScreenBottomSlideWidth,
                      ),
                    ),
                  ),
                ],
              );
            }
            return _result;
          },
        ),
      ],
    );
  }
}