import 'package:crypto_tracker_redux/not_yet_implemented_redux_version/models/app_state.dart';
import 'package:crypto_tracker_redux/not_yet_implemented_redux_version/models/price_check_model.dart';
import 'package:crypto_tracker_redux/not_yet_implemented_redux_version/redux/actions.dart';

AppState appStateReducer(AppState state, dynamic action) {
  if (action is AddPriceCheckAction) {
    // Fetch new prices for everything
    var _currentHistory = state.allCommoditiesHistory;
    var _newestUpdates = action.updatedListings;
    //
    Map<String, List<PriceCheck>> _updatedHistory =
    commoditiesHistoryReducer(action: action, newestUpdates: _newestUpdates, currentHistory: _currentHistory);


    Map<String, List<PriceCheck>> _result = Map.from(_currentHistory);

// Add each new listing to the result

    for (String key in _newestUpdates.keys) {
      var temp = PriceCheck(
        symbol: _newestUpdates[key]!.symbol,
        lastTradePrice: _newestUpdates[key]!.lastTradePrice,
        price24h: _newestUpdates[key]!.price24h,
        volume24h: _newestUpdates[key]!.volume24h,
      );
      _result['${temp.symbol}']!.add(temp);
    }
    //
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

Map<String, List<PriceCheck>> commoditiesHistoryReducer({
  required dynamic action,
  required Map<String, PriceCheck>? newestUpdates,
  required Map<String, List<PriceCheck>> currentHistory,
}) {
  Map<String, List<PriceCheck>> _result = {};
  if (action is AddPriceCheckAction) {
    Map<String, List<PriceCheck>> _result = Map.from(currentHistory);

// Add each new listing to the result
    for (String key in newestUpdates!.keys) {
      var temp = PriceCheck(
        symbol: newestUpdates[key]!.symbol,
        lastTradePrice: newestUpdates[key]!.lastTradePrice,
        price24h: newestUpdates[key]!.price24h,
        volume24h: newestUpdates[key]!.volume24h,
      );
      _result['${temp.symbol}']!.add(temp);
    }
  }
  return _result;
}