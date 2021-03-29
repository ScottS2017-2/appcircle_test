import 'package:crypto_tracker_redux/redux_version/models/app_state.dart';
import 'package:crypto_tracker_redux/redux_version/models/price_check_model.dart';
import 'package:crypto_tracker_redux/redux_version/redux/actions.dart';

AppState appStateReducer(AppState state, dynamic action) {

  if (action is UpdatePricesAction) {
    var _currentHistory = state.allCommoditiesHistory;
    var _updatesList = action.updatedListings;
    Map<String, List<PriceCheck>> _updatedHistory = Map.from(_currentHistory);
    for (final update in _updatesList) {
      _updatedHistory[update.symbol.toString()]!.add(update);
      }
    return state.copyWith(
      isLoading: false,
      allCommoditiesHistory: _updatedHistory,
    );
  }

  if (action is AddInterestedInAction) {
    Map<String, double> _oldPricesInterestedInList = state.interestedInPrices;
    var _symbolToAdd = action.itemMapKey;
    Map<String, double> _result = Map.from(_oldPricesInterestedInList);
    _result.putIfAbsent(_symbolToAdd, () => _oldPricesInterestedInList[_symbolToAdd]!);
    return state.copyWith(
      isLoading: false,
      interestedInPrices: _result,
    );
  }

  if (action is RemoveInterestedInAction) {
    Map<String, double> _oldPricesInterestedInList = state.interestedInPrices;
    var _symbolToRemove = action.itemMapKey;
    Map<String, double> _result = Map.from(_oldPricesInterestedInList);
    _result.remove(_symbolToRemove);
    return state.copyWith(
      isLoading: false,
      interestedInPrices: _result,
    );
  }
  // If the action is invalid, return the state unchanged
  return state;
}