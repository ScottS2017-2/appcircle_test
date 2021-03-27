import 'package:crypto_tracker_redux/app/app_colors.dart';
import 'package:crypto_tracker_redux/app/app_textstyles.dart';
import 'package:crypto_tracker_redux/main.dart';
import 'package:crypto_tracker_redux/provider_version/models/app_state_model.dart';
import 'package:crypto_tracker_redux/provider_version/widgets/bottom_slide_in.dart';
import 'package:crypto_tracker_redux/provider_version/widgets/top_slide_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderHome extends StatefulWidget {
  ProviderHome({
    Key? key,
  }) : super(key: key);

  @override
  _ProviderHomeState createState() => _ProviderHomeState();
}

class _ProviderHomeState extends State<ProviderHome> {
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

  late Future _initialLoad;

  @override
  void initState() {
    super.initState();
    _initialLoad = MyApp.appStateOf(context).manualUpdatePrices();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void toggleSideSlides() {
    setState(() => onStage = !onStage);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialLoad,
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }
          return Stack(
            fit: StackFit.expand,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Builder(
                        builder: (BuildContext context) {
                          final interestedInPrices =
                              context.select((AppStateModel appState) => appState.interestedInPrices.values.toList());
                          return ListView.builder(
                            itemCount: interestedInPrices.length,
                            itemBuilder: (BuildContext context, int index) {
                              final value = interestedInPrices[index];
                              return Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Container(
                                  margin: const EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    gradient: LinearGradient(
                                      colors: [
                                        Theme.of(context).primaryColor,
                                        AppColors.oliveAccent,
                                        Theme.of(context).primaryColor,
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      stops: [0, 0.5, 1],
                                    ),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 8),
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Column(
                                          children: [
                                            Text(
                                              '${value.symbol.commodityFull.toUpperCase()}',
                                              textAlign: TextAlign.center,
                                              style: AppTextStyles.boldItalic26.copyWith(
                                                color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.95),
                                                shadows: [
                                                  Shadow(
                                                    color: AppColors.dropShadowColor,
                                                    offset: Offset(2, 2),
                                                    blurRadius: 1,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              '${value.lastTradePrice.toString().padRight(2)} ${value.symbol.denominationFull}',
                                              textAlign: TextAlign.center,
                                              style: AppTextStyles.normal24.copyWith(
                                                //
                                                color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.95),
                                                shadows: [
                                                  Shadow(
                                                    color: AppColors.dropShadowColor,
                                                    offset: Offset(2, 2),
                                                    blurRadius: 1,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () => MyApp.appStateOf(context).manualUpdatePrices(),
                          child: Container(
                            height: 48,
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Theme.of(context).primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              margin: const EdgeInsets.all(1),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: FittedBox(
                                child: Text(
                                  'Update Prices',
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
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            MyApp.appStateOf(context).clearDenominationsApplicableToCurrentCommodity();
                            toggleSideSlides();
                          },
                          child: Container(
                            height: 48,
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Theme.of(context).primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              margin: const EdgeInsets.all(1),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: FittedBox(
                                child: Text(
                                  'Edit Watchlist',
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
                                ),
                              ),
                            ),
                          ),
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
                          alignment: Alignment(
                              0,
                              onStage == false
                                  ? _largeScreenTopSlideExtendedPosition
                                  : _largeScreenTopSlideRetractedPosition),
                          duration: Duration(milliseconds: 300),
                          child: TopSlideIn(
                            height: _largeScreenTopSlideHeight,
                            width: _largeScreenTopSlideWidth,
                          ),
                        ),
                        AnimatedContainer(
                          alignment: Alignment(
                              0,
                              onStage == true
                                  ? _largeScreenBottomSlideExtendedPosition
                                  : _largeScreenBottomSlideRetractedPosition),
                          duration: Duration(milliseconds: 300),
                          child: BottomSlideIn(
                            height: _largeScreenBottomSlideHeight,
                            width: _largeScreenBottomSlideWidth,
                          ),
                        ),
                      ],
                    );
                  } else if (constraints.maxHeight <= 1140) {
                    _result = Stack(
                      fit: StackFit.expand,
                      children: [
                        Offstage(
                          offstage: false,
                          child: AnimatedContainer(
                            alignment: Alignment(
                                0,
                                onStage == true
                                    ? _smallScreenTopSlideExtendedPosition
                                    : _smallScreenTopSlideRetractedPosition),
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
                            alignment: Alignment(
                                0,
                                onStage == true
                                    ? _smallScreenBottomSlideExtendedPosition
                                    : _smallScreenBottomSlideRetractedPosition),
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
              Positioned(
                left: 0.0,
                right: 0.0,
                top: 0.0,
                child: Builder(builder: (BuildContext context) {
                  final connected = context.select((AppStateModel appState) => appState.isConnected);
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
                      return Stack(
                        fit: StackFit.passthrough,
                        children: <Widget>[
                          ...previousChildren,
                          if (currentChild != null) currentChild,
                        ],
                      );
                    },
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return SizeTransition(
                        sizeFactor: animation,
                        axisAlignment: 1.0,
                        child: SizedBox(
                          width: double.infinity,
                          child: child,
                        ),
                      );
                    },
                    child: Builder(
                      key: Key('banner-$connected'),
                      builder: (BuildContext context) {
                        if (!connected) {
                          return Container(
                            color: Theme.of(context).accentColor,
                            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                            child: Text(
                              'Sorry, not connected',
                              style: Theme.of(context).accentTextTheme.bodyText2,
                            ),
                          );
                        } else {
                          return SizedBox();
                        }
                      },
                    ),
                  );
                }),
              ),
            ],
          );
        });
  }
}
