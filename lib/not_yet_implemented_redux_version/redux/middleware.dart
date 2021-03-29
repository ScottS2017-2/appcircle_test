import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto_tracker_redux/not_yet_implemented_redux_version/models/app_state.dart';
import 'package:crypto_tracker_redux/not_yet_implemented_redux_version/models/price_check_model.dart';
import 'package:crypto_tracker_redux/not_yet_implemented_redux_version/models/symbol_model.dart';
import 'package:crypto_tracker_redux/not_yet_implemented_redux_version/redux/actions.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';



void appStateMiddleware(Store<AppState> store, action, NextDispatcher next) async {

  if (action is UpdateAction) {
    await loadFromPrefs()
        .then ((state) => store.dispatch(LoadedItemsAction(state.items)));
  } else if (action is AddInterestedInAction) {
    addToInterestedInPrices()
        .then ((state) => store.dispatch(AddInterestedInAction(state.items)));
  } else if (action is RemoveInterestedInAction) {
    await loadFromPrefs()
        .then ((state) => store.dispatch(LoadedItemsAction(state.items)));
  } else if (action is UpdateAction) {
    await loadFromPrefs()
        .then ((state) => store.dispatch(LoadedItemsAction(state.items)));
  }
}


// Returns a list of the latest PriceCheck objects
Future<List<PriceCheck>> _getTicker() async {
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

void _addUpdatesToHistory(List<PriceCheck> newestUpdates) {
  // Add each new listing to the result
  for (final update in newestUpdates) {
    final _prices = allCommoditiesHistory.putIfAbsent(update.symbol, () => <PriceCheck>[]);
    _prices.add(update);
    if (interestedInPrices.containsKey(update.symbol)) {
      interestedInPrices[update.symbol] = update;
    }
  }
  notifyListeners();
}

void _startUpdateTimer() {
  _timer = Timer(Duration(seconds: 5), _fetchAndProcessUpdates);
}

void clearDenominationsApplicableToCurrentCommodity() {
  denominationsApplicableToCurrentCommodity = [];
  notifyListeners();
}

void updateDenominationsApplicableToCurrentCommodity(SymbolModel symbol) {
  denominationsApplicableToCurrentCommodity = allCommoditiesHistory.keys //
      .where((key) => key.commodity == symbol.commodity)
      .toList();
  denominationsApplicableToCurrentCommodity.sort((SymbolModel left, SymbolModel right) {
    return left.denominationFull.toLowerCase().compareTo(right.denominationFull.toLowerCase());
  });
  notifyListeners();
}

<SymbolModel, List<PriceCheck>> addToInterestedInPrices({required Store<AppState> store, required SymbolModel symbol}) {
  final tempMap = <SymbolModel, List<PriceCheck>>{};
  tempMap.addAll(store.interestedInPrices)
  ..putIfAbsent(symbol, () => allCommoditiesHistory[symbol]!.last);
  interestedInPrices.putIfAbsent(symbol, () => allCommoditiesHistory[symbol]!.last);
  return tempMap;
}

void removeFromInterestedInPrices(SymbolModel symbol) {
  interestedInPrices.remove(symbol);
  if (interestedInPrices.isEmpty) {
    _timer?.cancel();
  } else {
    _timer?.cancel();
    _startUpdateTimer();
  }
  notifyListeners();
}
}
























// Returns a list of the latest PriceCheck objects
Future<List<dynamic>> getTicker() async {
  List<dynamic> _jsonData = [];
  List<dynamic> _data = [];

  http.Response response;
  String _body = '';

  final Uri url = Uri.parse('https://api.blockchain.com/v3/exchange/tickers');
  try {
    response = await http.get(url);
    if (response.statusCode != 200) {
      throw HttpException(
        '${response.statusCode}: ${response.reasonPhrase}',
        uri: url,
      );
    }
    _body = response.body;
  } catch (e) {
    print(e);
  }
  _jsonData = json.decode(_body) as List;
  _data = _jsonData.map((jsonObject) => PriceCheck.fromJson(jsonObject)).toList();

  return _data;
}

Future<List<dynamic>> appStateMiddleware(Store<AppState> store, action, NextDispatcher next) async {
  // _result is abstraction for debugging
  late List<dynamic> _result;
  if (action is AddPriceCheckAction) {
    // Get the latest PriceChecks
    await getTicker().then((value) {
      _result = value;
    });
  }
  return _result;
}
