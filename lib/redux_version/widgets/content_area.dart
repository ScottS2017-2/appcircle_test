import 'package:crypto_tracker_redux/app/app_colors.dart';
import 'package:crypto_tracker_redux/app/app_strings.dart';
import 'package:crypto_tracker_redux/app/app_textstyles.dart';
import 'package:crypto_tracker_redux/redux_version/models/price_check_model.dart';
import 'package:crypto_tracker_redux/redux_version/models/symbol_model.dart';
import 'package:crypto_tracker_redux/redux_version/models/view_model.dart';
import 'package:crypto_tracker_redux/redux_version/widgets/bottom_slide_in.dart';
import 'package:crypto_tracker_redux/redux_version/widgets/custom_border_button.dart';
import 'package:crypto_tracker_redux/redux_version/widgets/top_slide_in.dart';
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
  static const double _largeScreenTopSlideHeight = 600;
  static const double _largeScreenTopSlideWidth = 600;
  static const double _largeScreenBottomSlideHeight = 400;
  static const double _largeScreenBottomSlideWidth = 600;
  static const double _largeScreenTopSlideExtendedPosition = -1;
  static const double _largeScreenTopSlideRetractedPosition = -4;
  static const double _largeScreenBottomSlideExtendedPosition = 0.82;
  static const double _largeScreenBottomSlideRetractedPosition = 3.75;
  static const double _largeListItemsSidePadding = 136.0;
  static const double _largeListItemsTopPadding = 3.75;

  static const double _smallScreenTopSlideHeight = 400;
  static const double _smallScreenTopSlideWidth = 300;
  static const double _smallScreenBottomSlideHeight = 200;
  static const double _smallScreenBottomSlideWidth = 300;
  static const double _smallScreenTopSlideExtendedPosition = -1.1;
  static const double _smallScreenTopSlideRetractedPosition = -4.75;
  static const double _smallScreenBottomSlideExtendedPosition = .75;
  static const double _smallScreenBottomSlideRetractedPosition = 2;
  static const double _smallListItemsSidePadding = 48.0;
  static const double _smallListItemsTopPadding = 3.75;

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
                        return Container(
                          margin: constraints.maxWidth > 500
                              ? EdgeInsets.symmetric(
                                  horizontal: _largeListItemsSidePadding, vertical: _largeListItemsTopPadding)
                              : EdgeInsets.symmetric(
                                  horizontal: _smallListItemsSidePadding, vertical: _smallListItemsTopPadding),
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
                                      Text(
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
                                    ],
                                  ),
                                ],
                              ),
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
                // Top and Bottom Slides
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
                                ? _largeScreenTopSlideRetractedPosition
                                : _largeScreenTopSlideExtendedPosition),
                        duration: Duration(milliseconds: 300),
                        child: TopSlideIn(
                          height: _largeScreenTopSlideHeight,
                          width: _largeScreenTopSlideWidth,
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
                                ? _largeScreenBottomSlideExtendedPosition
                                : _largeScreenBottomSlideRetractedPosition),
                        duration: Duration(milliseconds: 300),
                        child: BottomSlideIn(
                          height: _largeScreenBottomSlideHeight,
                          width: _largeScreenBottomSlideWidth,
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
                                  ? _smallScreenTopSlideExtendedPosition
                                  : _smallScreenTopSlideRetractedPosition),
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeOutBack,
                          child: TopSlideIn(
                            height: _smallScreenTopSlideHeight,
                            width: _smallScreenTopSlideWidth,
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
                                  ? _smallScreenBottomSlideExtendedPosition
                                  : _smallScreenBottomSlideRetractedPosition),
                          child: BottomSlideIn(
                            height: _smallScreenBottomSlideHeight,
                            width: _smallScreenBottomSlideWidth,
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
