import 'dart:async';
import 'dart:convert';
import 'dart:io';
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
        interestedInPrices = <String, double>{},
        denominationsApplicableToCurrentCommodity = [];

  Map<String, List<PriceCheck>> allCommoditiesHistory;
  Map<String, double> interestedInPrices;
  List<String> denominationsApplicableToCurrentCommodity;
  Timer? _timer;

  // Returns a list of the latest PriceCheck objects
  Future<List<PriceCheck>> _getTicker() async {
    try {
      final url = Uri.parse('https://api.blockchain.com/v3/exchange/tickers');
      final response = await http.get(url);
      if (response.statusCode != 200) {
        throw HttpException('${response.statusCode}: ${response.reasonPhrase}', uri: url);
      }
      final jsonData = json.decode(response.body) as List<dynamic>;
      return jsonData //
          .map((jsonObject) => PriceCheck.fromJson(jsonObject))
          .toList();
    } catch (e) {
      // TODO If any other error handling is desired, do it here
      print(e);
      rethrow;
    }
  }

  void _addUpdatesToHistory({
    required List<dynamic> newestUpdates,
    required Map<String, List<PriceCheck>> outdatedHistory,
  }) {
    var _replacementHistory = Map<String, List<PriceCheck>>.from(outdatedHistory);
    // Add each new listing to the result
    for (int i = 0; i < newestUpdates.length; i++) {
      var _temp = PriceCheck(
        symbol: newestUpdates[i].symbol,
        lastTradePrice: newestUpdates[i].lastTradePrice,
        price24h: newestUpdates[i].price24h,
        volume24h: newestUpdates[i].volume24h,
      );
      _replacementHistory['${_temp.symbol}']!.add(_temp);
    }
    allCommoditiesHistory = Map<String, List<PriceCheck>>.from(_replacementHistory);

    Map<String, double> _replacementWatchList = interestedInPrices;
    for (String key in interestedInPrices.keys) {
      _replacementWatchList[key] = _replacementHistory[key]!.last.lastTradePrice;
    }
    interestedInPrices = _replacementWatchList;
    notifyListeners();
  }

  Future<void> fetchAndProcessUpdates({required Map<String, List<PriceCheck>> outdatedHistory}) async {
    await _getTicker().then((value) {
      _addUpdatesToHistory(
        newestUpdates: value,
        outdatedHistory: outdatedHistory,
      );
      _timer?.cancel();
      _startUpdateTimer();
    });
  }

  void updateDenominationsApplicableToCurrentCommodity(String commodity) {
    denominationsApplicableToCurrentCommodity = [];

    for (int i = 0; i < AppStrings.commoditiesHistory[commodity]!.length; i++) {
      String _temp = '${AppStrings.commoditiesHistory[commodity]!.keys.elementAt(i)}';

      denominationsApplicableToCurrentCommodity.add(_temp);
    }
    notifyListeners();
  }

  void updateInterestedInPrices(String commodity, String denomination) {
    interestedInPrices.putIfAbsent('$commodity-$denomination', () => 0);
    fetchAndProcessUpdates(outdatedHistory: allCommoditiesHistory);
  }

  void removeFromInterestedInPrices(String commodity) {
    interestedInPrices.remove(commodity);
    if (interestedInPrices.isEmpty) {
      _timer?.cancel();
    } else {
      _timer?.cancel();
      _startUpdateTimer();
    }
    notifyListeners();
  }

  void _startUpdateTimer() {
    _timer = Timer(Duration(seconds: 5), () {
      fetchAndProcessUpdates(outdatedHistory: allCommoditiesHistory);
    });
  }
}
