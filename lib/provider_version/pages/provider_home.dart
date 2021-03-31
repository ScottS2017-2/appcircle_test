import 'package:crypto_tracker_redux/app/app_colors.dart';
import 'package:crypto_tracker_redux/app/app_strings.dart';
import 'package:crypto_tracker_redux/app/app_textstyles.dart';
import 'package:crypto_tracker_redux/app/responsive_design_constants.dart';
import 'package:crypto_tracker_redux/main.dart';
import 'package:crypto_tracker_redux/provider_version/models/app_state_model.dart';
import 'package:crypto_tracker_redux/provider_version/widgets/bottom_slide_in.dart';
import 'package:crypto_tracker_redux/widgets/custom_border_button.dart';
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
        return LayoutBuilder(
          builder: (context, BoxConstraints constraints) {
            return Stack(
              fit: StackFit.expand,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    top: 16,
                    right: 16,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      //-------
                      // List of tracked items
                      //-------
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
                                  margin: constraints.maxWidth > 500
                                      ? EdgeInsets.symmetric(
                                      horizontal: ResponsiveDesignConstants.largeListItemsSidePadding, vertical: ResponsiveDesignConstants.largeListItemsTopPadding)
                                      : EdgeInsets.symmetric(
                                      horizontal: ResponsiveDesignConstants.smallListItemsSidePadding, vertical: ResponsiveDesignConstants.smallListItemsTopPadding),
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
                                          AppColors.oliveAccent,
                                          Theme.of(context).primaryColor,
                                        ],
                                        begin: Alignment(-2, -1.75),
                                        end: Alignment(2, 1.75),
                                        stops: [0, 1],
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
                          if (onStage == false)
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: CustomBorderButton(
                                  onPressed: () => MyApp.appStateOf(context).manualUpdatePrices(),
                                  gradientColorOne: AppColors.oliveAccent,
                                  gradientColorTwo: Theme.of(context).primaryColor,
                                  insetColor: Theme.of(context).scaffoldBackgroundColor,
                                  child: Text('Update Prices'),
                                ),
                              ),
                            ),
                          SizedBox(
                            width: 16,
                          ),
                          if (onStage == false)
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: CustomBorderButton(
                                  onPressed: () {
                                    MyApp.appStateOf(context).clearDenominationsApplicableToCurrentCommodity();
                                    toggleSideSlides();
                                  },
                                  gradientColorOne: AppColors.oliveAccent,
                                  gradientColorTwo: Theme.of(context).primaryColor,
                                  insetColor: Theme.of(context).scaffoldBackgroundColor,
                                  child: Text(onStage == false ? AppStrings.editWatchlist : AppStrings.closeEditBoxes),
                                ),
                              ),
                            ),
                          if (onStage == true)
                            Spacer(
                              flex: 25,
                            ),
                          if (onStage == true)
                            Expanded(
                              flex: 50,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: CustomBorderButton(
                                  onPressed: () {
                                    MyApp.appStateOf(context).clearDenominationsApplicableToCurrentCommodity();
                                    toggleSideSlides();
                                  },
                                  gradientColorOne: AppColors.oliveAccent,
                                  gradientColorTwo: Theme.of(context).primaryColor,
                                  insetColor: Theme.of(context).scaffoldBackgroundColor,
                                  child: Text(onStage == false ? AppStrings.editWatchlist : AppStrings.closeEditBoxes),
                                ),
                              ),
                            ),
                          if (onStage == true)
                            Spacer(
                              flex: 25,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                LayoutBuilder(
                  builder: (context, BoxConstraints constraints) {
                    // If the screen width > 1440
                    if (constraints.maxWidth > 500) {
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          AnimatedContainer(
                            alignment: Alignment(
                                0,
                                onStage == false
                                    ? ResponsiveDesignConstants.largeScreenTopSlideRetractedPosition
                                    : ResponsiveDesignConstants.largeScreenTopSlideExtendedPosition),
                            duration: Duration(milliseconds: 300),
                            child: TopSlideIn(
                              height: ResponsiveDesignConstants.largeScreenTopSlideHeight,
                              width: ResponsiveDesignConstants.largeScreenTopSlideWidth,
                            ),
                          ),
                          AnimatedContainer(
                            alignment: Alignment(
                                0,
                                onStage == true
                                    ? ResponsiveDesignConstants.largeScreenBottomSlideExtendedPosition
                                    : ResponsiveDesignConstants.largeScreenBottomSlideRetractedPosition),
                            duration: Duration(milliseconds: 300),
                            child: BottomSlideIn(
                              height: ResponsiveDesignConstants.largeScreenBottomSlideHeight,
                              width: ResponsiveDesignConstants.largeScreenBottomSlideWidth,
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          Offstage(
                            offstage: false,
                            child: AnimatedContainer(
                              alignment: Alignment(
                                  0,
                                  onStage == true
                                      ? ResponsiveDesignConstants.smallScreenTopSlideExtendedPosition
                                      : ResponsiveDesignConstants.smallScreenTopSlideRetractedPosition),
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeOutBack,
                              child: TopSlideIn(
                                height: ResponsiveDesignConstants.smallScreenTopSlideHeight,
                                width: ResponsiveDesignConstants.smallScreenTopSlideWidth,
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
                                      ? ResponsiveDesignConstants.smallScreenBottomSlideExtendedPosition
                                      : ResponsiveDesignConstants.smallScreenBottomSlideRetractedPosition),
                              child: BottomSlideIn(
                                height: ResponsiveDesignConstants.smallScreenBottomSlideHeight,
                                width: ResponsiveDesignConstants.smallScreenBottomSlideWidth,
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
                Positioned(
                  left: 0.0,
                  right: 0.0,
                  top: 0.0,
                  child: Builder(
                    builder: (BuildContext context) {
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
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
