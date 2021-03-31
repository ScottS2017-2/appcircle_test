import 'package:crypto_tracker_redux/redux_version/models/app_state.dart';
import 'package:crypto_tracker_redux/redux_version/models/price_check_model.dart';
import 'package:crypto_tracker_redux/redux_version/models/symbol_model.dart';
import 'package:crypto_tracker_redux/redux_version/redux/actions.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

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

  final Map<SymbolModel, List<PriceCheck>> allCommoditiesHistory;
  final Map<SymbolModel, double> interestedInPrices;
  final List<SymbolModel> denominationsApplicableToCurrentCommodity;
  final SymbolModel itemToAdd;
  final SymbolModel itemToRemove;
  final bool slidersAreOnStage;
  final bool isConnected;
  final VoidCallback fetchUpdates;
  final VoidCallback toggleSideSlides;
  final VoidCallback clearAllDenominationOptions;
  final Function({required SymbolModel itemMapKey}) addInterestedInItem;
  final Function({required SymbolModel itemMapKey}) removeInterestedInItem;
  final Function({required SymbolModel commodity}) updateApplicableDenominations;

  factory ViewModel.create(Store<AppState> store) {
    return ViewModel(
      allCommoditiesHistory: store.state.allCommoditiesHistory,
      interestedInPrices: store.state.interestedInPrices,
      itemToAdd: store.state.itemToAdd,
      itemToRemove: store.state.itemToRemove,
      slidersAreOnStage: store.state.slidersAreOnStage,
      isConnected: store.state.isConnected,
      denominationsApplicableToCurrentCommodity: //
          store.state.denominationsApplicableToCurrentCommodity,
      fetchUpdates: () => store.dispatch(FetchUpdatesAction()),
      toggleSideSlides: () => store.dispatch(ToggleSideSlides()),
      clearAllDenominationOptions: () => store.dispatch(ClearAllDenominationOptions()),
      removeInterestedInItem: ({required SymbolModel itemMapKey}) => //
          store.dispatch(AddInterestedInAction(itemMapKey: itemMapKey)),
      addInterestedInItem: ({required SymbolModel itemMapKey}) => //
          store.dispatch(RemoveInterestedInAction(itemMapKey: itemMapKey)),
      updateApplicableDenominations: ({required SymbolModel commodity}) => //
          store.dispatch(UpdateAvailableDenominationsForThisCurrencyAction(commodity: commodity)),
    );
  }
}
