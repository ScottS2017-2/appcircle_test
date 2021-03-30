import 'package:crypto_tracker_redux/redux_version/models/app_state.dart';
import 'package:crypto_tracker_redux/redux_version/models/price_check_model.dart';
import 'package:crypto_tracker_redux/redux_version/models/symbol_model.dart';
import 'package:crypto_tracker_redux/redux_version/redux/actions.dart';

AppState appStateReducer(AppState state, dynamic action) {
  if (action is UpdatePricesAction) {
    final Map<SymbolModel, List<PriceCheck>> _currentHistory = Map.from(state.allCommoditiesHistory);
    final List<PriceCheck> _updatesList = action.updatedListings;
    print('First check is ${_updatesList.first.symbol.toString()}');
    Map<SymbolModel, List<PriceCheck>> _updatedHistory = Map.from(_currentHistory);
    for (final update in _updatesList) {
      if(_updatedHistory.containsKey(update.symbol)) {
        _updatedHistory[update.symbol]!.add(update);
      } else {
        _updatedHistory.putIfAbsent(update.symbol, () => [update]);
      }
    }
    return state.copyWith(
      allCommoditiesHistory: _updatedHistory,
    );
  }

  if (action is AddInterestedInAction) {
    Map<SymbolModel, double> _oldPricesInterestedInList = state.interestedInPrices;
    var _symbolToAdd = action.itemMapKey;
    Map<SymbolModel, double> _result = Map.from(_oldPricesInterestedInList);
    _result.putIfAbsent(_symbolToAdd, () => _oldPricesInterestedInList[_symbolToAdd]!);
    return state.copyWith(
      interestedInPrices: _result,
    );
  }

  if (action is RemoveInterestedInAction) {
    Map<SymbolModel, double> _oldPricesInterestedInList = state.interestedInPrices;
    var _symbolToRemove = action.itemMapKey;
    Map<SymbolModel, double> _result = Map.from(_oldPricesInterestedInList);
    _result.remove(_symbolToRemove);
    return state.copyWith(
      interestedInPrices: _result,
    );
  }

  if (action is UpdateAvailableDenominationsForThisCurrencyAction) {
    print("UPDATING AVAILABLE CURRENCIES ISN'T IMPLEMENTED YET");
    // TODO implement me
  }
  // If the action is invalid, return the state unchanged
  return state;
}
