import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:crypto_tracker_redux/provider_version/models/price_check_model.dart';
import 'package:http/http.dart' as http;

class AppStateModel extends ChangeNotifier {
  AppStateModel({
    @required this.allCommoditiesHistory,
    @required this.interestedInPrices,
  });

  Map<String, List<PriceCheck>> allCommoditiesHistory;
  Map<String, double> interestedInPrices;

  AppStateModel copyWith({
    Map<String, List<PriceCheck>> allCommoditiesHistory,
    Map<String, double> interestedInPrices,
  }) {
    var _newAppState = AppStateModel(
      allCommoditiesHistory:
      allCommoditiesHistory ?? this.allCommoditiesHistory,
      interestedInPrices: interestedInPrices ?? this.interestedInPrices,
    );
    return _newAppState;
  }

  AppStateModel.initialState()
      : allCommoditiesHistory = {
    'AAVE-USD': [],
    'AAVE-USDT': [],
    'ALGO-BTC': [],
    'ALGO-USD': [],
    'ALGO-USDT': [],
    'BCH-BTC': [],
    'BCH-ETH': [],
    'BCH-EUR': [],
    'BCH-PAX': [],
    'BCH-USD': [],
    'BCH-USDT': [],
    'BTC-EUR': [],
    'BTC-GBP': [],
    'BTC-PAX': [],
    'BTC-TRY': [],
    'BTC-USD': [],
    'BTC-USDT': [],
    'DGLD-BTC': [],
    'DGLD-USD': [],
    'ENJ-USD': [],
    'ENJ-USDT': [],
    'ETH-BTC': [],
    'ETH-EUR': [],
    'ETH-GBP': [],
    'ETH-PAX': [],
    'ETH-TRY': [],
    'ETH-USD': [],
    'ETH-USDT': [],
    'LEND-USD': [],
    'LEND-USDT': [],
    'LTC-BTC': [],
    'LTC-EUR': [],
    'LTC-PAX': [],
    'LTC-TRY': [],
    'LTC-USD': [],
    'LTC-USDT': [],
    'OGN-USD': [],
    'OGN-USDT': [],
    'PAX-EUR': [],
    'PAX-USD': [],
    'USDT-EUR': [],
    'USDT-GBP': [],
    'USDT-TRY': [],
    'USDT-USD': [],
    'WDGLD-BTC': [],
    'WDGLD-DGLD': [],
    'WDGLD-USD': [],
    'XLM-BTC': [],
    'XLM-ETH': [],
    'XLM-EUR': [],
    'XLM-PAX': [],
    'XLM-USD': [],
    'XRP-EUR': [],
    'XRP-USD': [],
    'YFI-USD': [],
    'YFI-USDT': [],
  },
        interestedInPrices = <String, double>{
          'BTC-USD': 100,
          'ETH-USD': 50,
        };

  // AppState.fromJson(Map json)
  //     : allCommoditiesHistory = (json['allCommoditiesHistory'] as List)
  //           .map((i) => allCommoditiesHistory.fromJson(i))
  //           .toList(),
  //             commoditiesInterestedIn = (json['commoditiesInterestedIn'] as List)
  //                 .map((i) => allCommoditiesHistory.fromJson(i))
  //                 .toList()
  // ;

  Map<String, dynamic> toJson() => {
    'allCommoditiesHistory': allCommoditiesHistory,
  };

  // Returns a list of the latest PriceCheck objects
  Future<List<dynamic>>  getTicker() async {
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
    _data =
        _jsonData.map((jsonObject) => PriceCheck.fromJson(jsonObject)).toList();

    return _data;
  }

  void addUpdatesToHistory({
    @required List<PriceCheck> newestUpdates,
    @required Map<String, List<PriceCheck>> outdatedHistory,
  }) {
    var _replacementHistory = Map<String, List<PriceCheck>>.from(outdatedHistory);
    // Add each new listing to the result
    for (int i = 0; i < newestUpdates.length; i++) {
      var temp = PriceCheck(
        symbol: newestUpdates[i].symbol,
        lastTradePrice: newestUpdates[i].lastTradePrice,
        price24h: newestUpdates[i].price24h,
        volume24h: newestUpdates[i].volume24h,
      );
      _replacementHistory['${temp.symbol}'].add(temp);
    }
    allCommoditiesHistory = Map<String, List<PriceCheck>>.from(_replacementHistory);

    Map<String, double> _replacementWatchList = interestedInPrices;
    for (String key in interestedInPrices.keys) {
      _replacementWatchList[key] = _replacementHistory[key].last.lastTradePrice;
    }
    interestedInPrices = _replacementWatchList;
    notifyListeners();
  }

  Future<List<dynamic>> fetchAndProcessUpdates(
      {
        @required Map<String, List<PriceCheck>> outdatedHistory}) async {
    List<dynamic> _result;
    await getTicker().then((value) {
      addUpdatesToHistory(
        newestUpdates: value,
        outdatedHistory: outdatedHistory,
      );
    });
    return _result;
  }
}
