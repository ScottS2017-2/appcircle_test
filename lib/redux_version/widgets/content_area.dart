import 'package:crypto_tracker_redux/app/app_colors.dart';
import 'package:crypto_tracker_redux/app/app_strings.dart';
import 'package:crypto_tracker_redux/app/app_textstyles.dart';
import 'package:crypto_tracker_redux/app/responsive_design_constants.dart';
import 'package:crypto_tracker_redux/redux_version/models/price_check_model.dart';
import 'package:crypto_tracker_redux/redux_version/models/symbol_model.dart';
import 'package:crypto_tracker_redux/redux_version/models/view_model.dart';
import 'package:crypto_tracker_redux/redux_version/widgets/bottom_slide_in.dart';

import 'package:crypto_tracker_redux/redux_version/widgets/top_slide_in.dart';
import 'package:crypto_tracker_redux/widgets_common_to_all_versions/custom_border_box.dart';
import 'package:crypto_tracker_redux/widgets_common_to_all_versions/custom_border_button.dart';
import 'package:flutter/material.dart';

class ContentArea extends StatefulWidget {
  const ContentArea({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final ViewModel viewModel;

  @override
  _ContentAreaState createState() => _ContentAreaState();
}

class _ContentAreaState extends State<ContentArea> {
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
    final Map<SymbolModel, PriceCheck> interestedInPrices = widget.viewModel.interestedInPrices;
    return LayoutBuilder(
      builder: (context, BoxConstraints constraints) {
        return Stack(
          fit: StackFit.expand,
          children: [
            //-------
            // The main page
            //-------
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
                    child: ListView.builder(
                      itemCount: interestedInPrices.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CustomBorderBox(
                          onPressed: () => {},
                          gradientColorOne: AppColors.oliveAccent,
                          gradientColorTwo: Theme.of(context).primaryColor,
                          insetColor: Theme.of(context).scaffoldBackgroundColor,
                          innerBorderThickness: 1,
                          outerCornerRadius: 20,
                          innerCornerRadius: 10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  children: [
                                    Text(
                                      '${interestedInPrices.keys.elementAt(index).commodityFull.toUpperCase()}',
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
                                    FittedBox(
                                      child: Text(
                                        '${interestedInPrices[interestedInPrices.keys.elementAt(index)]!.lastTradePrice.toString().padRight(2)} ${interestedInPrices.keys.elementAt(index).denominationFull.toUpperCase()}',
                                        textAlign: TextAlign.center,
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
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //-------
                      // If the sliders aren't on stage, show the update
                      // and edit watchlist buttons at the bottom of the page
                      //-------
                      if (widget.viewModel.slidersAreOnStage == false)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: CustomBorderButton(
                              onPressed: widget.viewModel.fetchUpdates,
                              height: 48,
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
                      if (widget.viewModel.slidersAreOnStage == false)
                        //
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: CustomBorderButton(
                              onPressed: () => widget.viewModel.toggleSideSlides(),
                              height: 48,
                              gradientColorOne: AppColors.oliveAccent,
                              gradientColorTwo: Theme.of(context).primaryColor,
                              insetColor: Theme.of(context).scaffoldBackgroundColor,
                              child: Text(
                                AppStrings.editWatchlist,
                              ),
                            ),
                          ),
                        ),
                      //-------
                      // If the sliders are on stage, show a return button that's
                      // centered horizontally
                      //-------
                      if (widget.viewModel.slidersAreOnStage == true)
                        Spacer(
                          flex: 25,
                        ),
                      if (widget.viewModel.slidersAreOnStage == true)
                        Expanded(
                          flex: 50,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: CustomBorderButton(
                              onPressed: () {
                                widget.viewModel.clearAllDenominationOptions();
                                widget.viewModel.toggleSideSlides();
                              },
                              height: 48,
                              gradientColorOne: AppColors.oliveAccent,
                              gradientColorTwo: Theme.of(context).primaryColor,
                              insetColor: Theme.of(context).scaffoldBackgroundColor,
                              child: Text(widget.viewModel.slidersAreOnStage == false
                                  ? AppStrings.editWatchlist
                                  : AppStrings.closeEditBoxes),
                            ),
                          ),
                        ),
                      if (widget.viewModel.slidersAreOnStage == true)
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
                //-------
                // Layout for screen width > 1440
                //-------
                if (constraints.maxWidth > 500) {
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      //-------
                      // Top Slide-In
                      //-------
                      AnimatedContainer(
                        alignment: Alignment(
                            0,
                            widget.viewModel.slidersAreOnStage == false
                                ? ResponsiveDesignConstants.largeScreenTopSlideRetractedPosition
                                : ResponsiveDesignConstants.largeScreenTopSlideExtendedPosition),
                        duration: Duration(milliseconds: 300),
                        child: TopSlideIn(
                          height: ResponsiveDesignConstants.largeScreenTopSlideHeight,
                          width: ResponsiveDesignConstants.largeScreenTopSlideWidth,
                          viewModel: widget.viewModel,
                        ),
                      ),
                      //-------
                      // Bottom Slide-In
                      //-------
                      AnimatedContainer(
                        alignment: Alignment(
                            0,
                            widget.viewModel.slidersAreOnStage == true
                                ? ResponsiveDesignConstants.largeScreenBottomSlideExtendedPosition
                                : ResponsiveDesignConstants.largeScreenBottomSlideRetractedPosition),
                        duration: Duration(milliseconds: 300),
                        child: BottomSlideIn(
                          height: ResponsiveDesignConstants.largeScreenBottomSlideHeight,
                          width: ResponsiveDesignConstants.largeScreenBottomSlideWidth,
                          viewModel: widget.viewModel,
                        ),
                      ),
                    ],
                  );
                  //-------
                  // Layout for screen width <= 1440
                  //-------
                } else {
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      //-------
                      // Top Slide-In
                      //-------
                      Offstage(
                        offstage: false,
                        child: AnimatedContainer(
                          alignment: Alignment(
                              0,
                              widget.viewModel.slidersAreOnStage == true
                                  ? ResponsiveDesignConstants.smallScreenTopSlideExtendedPosition
                                  : ResponsiveDesignConstants.smallScreenTopSlideRetractedPosition),
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeOutBack,
                          child: TopSlideIn(
                            height: ResponsiveDesignConstants.smallScreenTopSlideHeight,
                            width: ResponsiveDesignConstants.smallScreenTopSlideWidth,
                            viewModel: widget.viewModel,
                          ),
                        ),
                      ),
                      //-------
                      // Bottom Slide-In
                      //-------
                      Offstage(
                        offstage: false,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeOutBack,
                          alignment: Alignment(
                              0,
                              widget.viewModel.slidersAreOnStage == true
                                  ? ResponsiveDesignConstants.smallScreenBottomSlideExtendedPosition
                                  : ResponsiveDesignConstants.smallScreenBottomSlideRetractedPosition),
                          child: BottomSlideIn(
                            height: ResponsiveDesignConstants.smallScreenBottomSlideHeight,
                            width: ResponsiveDesignConstants.smallScreenBottomSlideWidth,
                            viewModel: widget.viewModel,
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
            //-------
            // Not Connected Banner
            //-------
            Positioned(
              left: 0.0,
              right: 0.0,
              top: 0.0,
              child: Builder(
                builder: (BuildContext context) {
                  // FIXME the banner is always showing
                  //  final connected = widget.viewModel.isConnected;
                  final connected = true;
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
  }
}
