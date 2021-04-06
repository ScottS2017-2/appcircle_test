import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto_tracker_redux/common/models/price_check_model.dart';
import 'package:crypto_tracker_redux/common/models/symbol_model.dart';
import 'package:crypto_tracker_redux/redux_version/models/app_state_model.dart';
import 'package:crypto_tracker_redux/redux_version/redux/actions.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';


//-------
// TypedMiddleware<AppState, SubscribeToChangesAction> listenToChanges() =>
//     TypedMiddleware<AppState, SubscribeToChangesAction>((store, action, next) {
//       // Call the timer
//       Timer.periodic(duration: Duration(minutes: 15), (){
//         repository.getValue().then((value){
//           store.dispatch(ValueReceivedAction(value));
//         });
//       });
//       next(action);
//     });
//-------

Future<void> appStateMiddleware(Store<AppStateModel> store, action, NextDispatcher next) async {
  if (action is FetchUpdatesAction) {
    await getTicker().then((value) {
      next(UpdatePricesAction(updatedListings: value));
    }, onError: _onFetchError);
    for (final key in store.state.interestedInPrices.keys) {
      store.state.interestedInPrices[key] = store.state.allCommoditiesHistory[key]!.last;
    }
  } else if (action is AddInterestedInAction) {
    final Map<SymbolModel, PriceCheck> _currentPricesInterestedInList = store.state.interestedInPrices;
    _currentPricesInterestedInList.putIfAbsent(
        action.mapKey, () => store.state.allCommoditiesHistory[action.mapKey]!.last);
    store.state.copyWith(
      interestedInPrices: _currentPricesInterestedInList,
    );
    next(FetchUpdatesAction);
  }  else {
    next(action);
  }
}

bool _isConnected = true;
bool get isConnected => _isConnected;

void _onFetchError(dynamic error, StackTrace stackTrace) {
  _isConnected = (error is! SocketException);
  print('$error\n$stackTrace');
}

@visibleForTesting
Future<List<PriceCheck>> getTicker() async {
  final url = Uri.parse('https://api.blockchain.com/v3/exchange/tickers');
  final response = await http.get(url);
  if (response.statusCode != 200) {
    throw HttpException('${response.statusCode}: ${response.reasonPhrase}', uri: url);
  }
  final jsonData = json.decode(response.body) as List<dynamic>;
  return jsonData //
      .map((jsonObject) => PriceCheck.fromJson(jsonObject))
      .toList();
}