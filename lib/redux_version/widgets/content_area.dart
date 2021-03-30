import 'package:crypto_tracker_redux/app/app_colors.dart';
import 'package:crypto_tracker_redux/app/app_textstyles.dart';
import 'package:crypto_tracker_redux/redux_version/models/app_state.dart';
import 'package:crypto_tracker_redux/redux_version/models/symbol_model.dart';
import 'package:crypto_tracker_redux/redux_version/models/view_models.dart';
import 'package:crypto_tracker_redux/redux_version/redux/actions.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class ContentArea extends StatefulWidget {
  const ContentArea({
    Key? key,
    required this.viewModel,
    required this.store,
  }) : super(key: key);

  final ViewModel viewModel;
  final Store<AppState> store;

  @override
  _ContentAreaState createState() => _ContentAreaState();
}

class _ContentAreaState extends State<ContentArea> {
  final _scrollController = ScrollController();
  late Future _initialLoad;

  void fetchUpdates() {
    widget.store.dispatch(FetchUpdatesAction());
  }

  @override
  void initState() {
    super.initState();
    _initialLoad = widget.store.dispatch(FetchUpdatesAction());
  }

  @override
  void dispose() {
    super.dispose();
  }


  Widget oldListViewBuilder = ListView.builder(
    itemCount: widget.store.state.interestedInPrices.length,
    controller: _scrollController,
    itemBuilder: (BuildContext context, int index) {
      SymbolModel key = widget.store.state.interestedInPrices.keys.elementAt(index);
      return ListTile(
        title: Text(key.toString()),
        trailing: Text(widget.store.state.interestedInPrices[key].toString()),
      );
    },
  );



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
                padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Builder(
                        builder: (BuildContext context) {
                          final interestedInPrices = widget.store.state.interestedInPrices;
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
                        if(onStage == false)Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: CustomBorderButton(
                              onPressed: () => MyApp.appStateOf(context).manualUpdatePrices(),
                              child: Text('Update Prices'),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        if(onStage == false)Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: CustomBorderButton(
                              onPressed: () {
                                MyApp.appStateOf(context).clearDenominationsApplicableToCurrentCommodity();
                                toggleSideSlides();
                              },
                              child: Text(onStage == false ? AppStrings.editWatchlist : AppStrings.closeEditBoxes),
                            ),
                          ),
                        ),
                        if(onStage == true) Spacer(flex: 25,),
                        if(onStage == true)Expanded(
                          flex: 50,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: CustomBorderButton(
                              onPressed: () {
                                MyApp.appStateOf(context).clearDenominationsApplicableToCurrentCommodity();
                                toggleSideSlides();
                              },
                              child: Text(onStage == false ? AppStrings.editWatchlist : AppStrings.closeEditBoxes),
                            ),
                          ),
                        ),
                        if(onStage == true) Spacer(flex: 25,),
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
