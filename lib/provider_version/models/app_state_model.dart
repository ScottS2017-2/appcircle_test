import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:crypto_tracker_redux/app/app_strings.dart';
import 'package:crypto_tracker_redux/app/app_strings.dart';
import 'package:crypto_tracker_redux/app/app_strings.dart';
import 'package:crypto_tracker_redux/app/app_strings.dart';
import 'package:crypto_tracker_redux/app/app_strings.dart';
import 'package:crypto_tracker_redux/app/app_strings.dart';
import 'package:flutter/foundation.dart';
import 'package:crypto_tracker_redux/provider_version/models/price_check_model.dart';
import 'package:http/http.dart' as http;

class AppStateModel extends ChangeNotifier {
  AppStateModel({
    required this.allCommoditiesHistory,
    required this.interestedInPrices,
    required this.denominationsApplicableToCurrentCommodity,
  });

  Map<String, List<PriceCheck>> allCommoditiesHistory;
  Map<String, double> interestedInPrices;
  List<String> denominationsApplicableToCurrentCommodity;
  // TODO change to minutes
  int refreshRateInSeconds = 10;

  AppStateModel copyWith({
    Map<String, List<PriceCheck>>? allCommoditiesHistory,
    Map<String, double>? interestedInPrices,
    List<String>? denominationsApplicableToCurrentCommodity,
  }) {
    var _newAppState = AppStateModel(
      allCommoditiesHistory:
          allCommoditiesHistory ?? this.allCommoditiesHistory,
      interestedInPrices: interestedInPrices ?? this.interestedInPrices,
      denominationsApplicableToCurrentCommodity:
          denominationsApplicableToCurrentCommodity ??
              this.denominationsApplicableToCurrentCommodity,
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
        interestedInPrices = <String, double>{ },
        denominationsApplicableToCurrentCommodity = [];

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
    _data =
        _jsonData.map((jsonObject) => PriceCheck.fromJson(jsonObject)).toList();
    return _data;
  }

  void addUpdatesToHistory({
    required List<dynamic> newestUpdates,
    required Map<String, List<PriceCheck>> outdatedHistory,
  }) {
    var _replacementHistory =
        Map<String, List<PriceCheck>>.from(outdatedHistory);
    // Add each new listing to the result
    for (int i = 0; i < newestUpdates.length; i++) {
      var temp = PriceCheck(
        symbol: newestUpdates[i].symbol,
        lastTradePrice: newestUpdates[i].lastTradePrice,
        price24h: newestUpdates[i].price24h,
        volume24h: newestUpdates[i].volume24h,
      );
      _replacementHistory['${temp.symbol}']!.add(temp);
    }
    allCommoditiesHistory =
        Map<String, List<PriceCheck>>.from(_replacementHistory);

    Map<String, double> _replacementWatchList = interestedInPrices;
    for (String key in interestedInPrices.keys) {
      _replacementWatchList[key] =
          _replacementHistory[key]!.last.lastTradePrice;
    }
    interestedInPrices = _replacementWatchList;
    notifyListeners();
  }

  Future<void> fetchAndProcessUpdates(
      {required Map<String, List<PriceCheck>> outdatedHistory}) async {
    await getTicker().then((value) {
      addUpdatesToHistory(
        newestUpdates: value,
        outdatedHistory: outdatedHistory,
      );
    });
  }

  void updateDenominationsApplicableToCurrentCommodity(String commodity) {
    denominationsApplicableToCurrentCommodity = [];

    for (int i = 0; i < AppStrings.commoditiesHistory[commodity]!.length; i++) {
      String temp =
          '${AppStrings.commoditiesHistory[commodity]!.keys.elementAt(i)}';

      denominationsApplicableToCurrentCommodity.add(temp);
    }
    notifyListeners();
  }

  void updateInterestedInPrices(String commodity, String denomination){
    interestedInPrices.putIfAbsent('$commodity-$denomination', () => 0);
    fetchAndProcessUpdates(outdatedHistory: allCommoditiesHistory);
  }
}
