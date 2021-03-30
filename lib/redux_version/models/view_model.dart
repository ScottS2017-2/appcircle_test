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
  final VoidCallback fetchUpdates;
  final VoidCallback addInterestedInItem;
  final VoidCallback removeInterestedInItem;
  final VoidCallback updateApplicableDenominations;
  final VoidCallback toggleSideSlides;
  final VoidCallback clearAllDenominationOptions;

  factory ViewModel.create(Store<AppState> store) {
    return ViewModel(
      allCommoditiesHistory: store.state.allCommoditiesHistory,
      interestedInPrices: store.state.interestedInPrices,
      denominationsApplicableToCurrentCommodity: store.state.denominationsApplicableToCurrentCommodity,
      itemToAdd: store.state.itemToAdd,
      itemToRemove: store.state.itemToRemove,
      slidersAreOnStage: store.state.slidersAreOnStage,
      fetchUpdates: () => store.dispatch(FetchUpdatesAction()),
      addInterestedInItem: () => store.dispatch(AddInterestedInAction(itemMapKey: itemMapKey)),
      removeInterestedInItem: () => store.dispatch(RemoveInterestedInAction(itemMapKey: itemMapKey)),
      updateApplicableDenominations: () =>
          store.dispatch(UpdateAvailableDenominationsForThisCurrencyAction(commodity: commodity)),
      toggleSideSlides: () => {},
      clearAllDenominationOptions: () => {},
    );
  }
}
