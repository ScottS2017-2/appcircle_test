import 'package:crypto_tracker_redux/common/models/price_check_model.dart';
import 'package:crypto_tracker_redux/common/models/symbol_model.dart';
import 'package:crypto_tracker_redux/redux_version/models/app_state_model.dart';
import 'package:crypto_tracker_redux/redux_version/redux/actions.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

@immutable
class ViewModel {
  ViewModel({
    required this.allCommoditiesHistory,
    required this.interestedInPrices,
    required this.denominationsApplicableToCurrentCommodity,
    required this.itemToAdd,
    required this.itemToRemove,
    required this.slidersAreOnStage,
    required this.isConnected,
    required this.fetchUpdates,
    required this.addInterestedInItem,
    required this.removeInterestedInItem,
    required this.updateApplicableDenominations,
    required this.toggleSideSlides,
    required this.clearAllDenominationOptions,
  });

  // members
  final Map<SymbolModel, List<PriceCheck>> allCommoditiesHistory;
  final Map<SymbolModel, PriceCheck> interestedInPrices;
  final List<SymbolModel> denominationsApplicableToCurrentCommodity;
  final SymbolModel itemToAdd;
  final SymbolModel itemToRemove;
  final bool slidersAreOnStage;
  final bool isConnected;
  // methods
  final VoidCallback fetchUpdates;
  final VoidCallback toggleSideSlides;
  final VoidCallback clearAllDenominationOptions;
  final Function({required SymbolModel mapKey}) addInterestedInItem;
  final Function({required SymbolModel mapKey}) removeInterestedInItem;
  final Function({required SymbolModel mapKey}) updateApplicableDenominations;

  factory ViewModel.create(Store<AppStateModel> store) {
    return ViewModel(
      // members
      allCommoditiesHistory: store.state.allCommoditiesHistory,
      interestedInPrices: store.state.interestedInPrices,
      itemToAdd: store.state.itemToAdd,
      itemToRemove: store.state.itemToRemove,
      slidersAreOnStage: store.state.slidersAreOnStage,
      isConnected: store.state.isConnected,
      denominationsApplicableToCurrentCommodity: //
          store.state.denominationsApplicableToCurrentCommodity,
      // methods
      fetchUpdates: () => store.dispatch(FetchUpdatesAction()),
      toggleSideSlides: () => store.dispatch(ToggleSideSlides()),
      clearAllDenominationOptions: () => store.dispatch(ClearAllDenominationOptions()),
      addInterestedInItem: ({required SymbolModel mapKey}) => //
          store.dispatch(AddInterestedInAction(mapKey: mapKey)),
      removeInterestedInItem: ({required SymbolModel mapKey}) => //
          store.dispatch(RemoveInterestedInAction(mapKey: mapKey)),
      updateApplicableDenominations: ({required SymbolModel mapKey}) => //
          store.dispatch(UpdateDenominationsApplicableToThisCurrencyAction(mapKey: mapKey)),
    );
  }
}