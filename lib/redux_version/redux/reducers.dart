import 'package:crypto_tracker_redux/common/models/price_check_model.dart';
import 'package:crypto_tracker_redux/common/models/symbol_model.dart';
import 'package:crypto_tracker_redux/redux_version/models/app_state_model.dart';
import 'package:crypto_tracker_redux/redux_version/redux/actions.dart';

AppStateModel appStateReducer(AppStateModel state, dynamic action) {
  if (action is UpdatePricesAction) {
    final Map<SymbolModel, List<PriceCheck>> _currentHistory = Map.from(state.allCommoditiesHistory);
    final List<PriceCheck> _updatesList = action.updatedListings;
    final Map<SymbolModel, List<PriceCheck>> _updatedHistory = Map.from(_currentHistory);
    for (final update in _updatesList) {
      if (_updatedHistory.containsKey(update.symbol)) {
        _updatedHistory[update.symbol]!.add(update);
      } else {
        _updatedHistory.putIfAbsent(update.symbol, () => [update]);
      }
    }
    return state.copyWith(
      allCommoditiesHistory: _updatedHistory,
    );
  }
  //-------
  if (action is ToggleSideSlides) {
    return state.copyWith(slidersAreOnStage: !state.slidersAreOnStage);
  }
  //-------
  if (action is UpdateDenominationsApplicableToThisCurrencyAction) {
    final _symbolToAdd = action.mapKey;
    List<SymbolModel> newApplicableDenominations = state.allCommoditiesHistory.keys //
        .where((key) => key.commodity == _symbolToAdd.commodity)
        .toList();
    newApplicableDenominations.sort((SymbolModel left, SymbolModel right) {
      return left.denominationFull.toLowerCase().compareTo(right.denominationFull.toLowerCase());
    });
    return state.copyWith(denominationsApplicableToCurrentCommodity: newApplicableDenominations);
  }
  //-------
  if (action is AddInterestedInAction) {
    final Map<SymbolModel, PriceCheck> _currentPricesInterestedInList = state.interestedInPrices;
    _currentPricesInterestedInList.putIfAbsent(action.mapKey, () => state.allCommoditiesHistory[action.mapKey]!.last);
    return state.copyWith(
      interestedInPrices: _currentPricesInterestedInList,
    );
  }
  //-------
  if (action is RemoveInterestedInAction) {
    final Map<SymbolModel, PriceCheck> _currentPricesInterestedInList = state.interestedInPrices;
    _currentPricesInterestedInList.remove(action.mapKey);
    return state.copyWith(
      interestedInPrices: _currentPricesInterestedInList,
    );
  }
  //-------
  if (action is AddInterestedInAction) {
    final Map<SymbolModel, PriceCheck> _currentPricesInterestedInList = state.interestedInPrices;
    _currentPricesInterestedInList.putIfAbsent(
        action.mapKey, () => state.allCommoditiesHistory[action.mapKey]!.last);
    state.copyWith(
      interestedInPrices: _currentPricesInterestedInList,
    );
  }
  // If the action is invalid, return the state unchanged
  return state;
}
