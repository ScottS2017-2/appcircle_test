import 'package:crypto_tracker_redux/redux_version/models/app_state.dart';
import 'package:crypto_tracker_redux/redux_version/models/price_check.dart';
import 'package:crypto_tracker_redux/redux_version/redux/actions.dart';

AppState appStateReducer(AppState state, dynamic action) {
  if (action is AddPriceCheckAction) {
    // Fetch new prices for everything
    var _newestUpdates = action.updatedListings;
    // Abstraction to make this easier to read and debug
    var _oldPricesInterestedInList = state.interestedInPrices;
    var _outdatedHistory = state.allCommoditiesHistory;
    //
    Map<String, List<PriceCheck>> _updatedCommoditiesHistory =
        allCommoditiesHistoryUpdateReducer(newestUpdates: _newestUpdates, outdatedHistory: _outdatedHistory);
    //
    Map<String, double> _updatedPricesInterestedIn = interestedPricesUpdateReducer(
        oldPricesInterestedInList: _oldPricesInterestedInList, newestUpdates: _newestUpdates!);
    //
    return state.copyWith(
      isLoading: false,
      allCommoditiesHistory: _updatedCommoditiesHistory,
      interestedInPrices: _updatedPricesInterestedIn,
    );
  }
  // If the action is invalid, return the state unchanged
  return state;
}

Map<String, List<PriceCheck>> allCommoditiesHistoryUpdateReducer({
  required Map<String, PriceCheck>? newestUpdates,
  required Map<String, List<PriceCheck>> outdatedHistory,
}) {
  Map<String, List<PriceCheck>> _result = Map.from(outdatedHistory);

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
  return _result;
}

Map<String, double> interestedPricesUpdateReducer({
  required Map<String, double> oldPricesInterestedInList,
  required Map<String, PriceCheck> newestUpdates,
}) {
  var _result = oldPricesInterestedInList;
  for (String key in oldPricesInterestedInList.keys) {
    _result[key] = newestUpdates[key]!.lastTradePrice;
  }
  return _result;
}
