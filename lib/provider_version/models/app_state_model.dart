import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto_tracker_redux/provider_version/models/price_check_model.dart';
import 'package:crypto_tracker_redux/provider_version/models/symbol_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AppStateModel extends ChangeNotifier {
  AppStateModel();

  final allCommoditiesHistory = <SymbolModel, List<PriceCheck>>{};
  final interestedInPrices = <SymbolModel, PriceCheck>{};
  List<SymbolModel> denominationsApplicableToCurrentCommodity = [];
  Timer? _timer;

  bool _isConnected = true;

  bool get isConnected => _isConnected;

  // TestWritten
  @visibleForTesting
  // The visibleForTesting annotation makes the method private, except for testing
  Future<void> fetchAndProcessUpdates() async {
    await getTicker().then((newestUpdates) {
      addUpdatesToHistory(newestUpdates);
      updateInterestedInList();
      _isConnected = true;
          _timer?.cancel();
      _startUpdateTimer();
    }, onError: _onFetchError);
  }

  void _onFetchError(dynamic error, StackTrace stackTrace) {
    _isConnected = (error is! SocketException);
    notifyListeners();
    print('$error\n$stackTrace');
  }

  // Returns a list of the latest PriceCheck objects
  // TestWritten
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

  // TestWritten
  @visibleForTesting
  void addUpdatesToHistory(List<PriceCheck> newestUpdates) {
    // Add each new listing to the result
    for (final update in newestUpdates) {
      final _prices = allCommoditiesHistory.putIfAbsent(update.symbol, () => <PriceCheck>[]);
      _prices.add(update);
    }
    notifyListeners();
  }

  // TestWritten
  @visibleForTesting
  void updateInterestedInList(){
    for (final key in interestedInPrices.keys) {
      interestedInPrices[key] = allCommoditiesHistory[key]!.last;
    }
  }

  // TestWritten
  void clearDenominationsApplicableToCurrentCommodity() {
    denominationsApplicableToCurrentCommodity.clear();
    notifyListeners();
  }

// TestWritten
  void updateDenominationsApplicableToCurrentCommodity(SymbolModel symbol) {
    denominationsApplicableToCurrentCommodity = allCommoditiesHistory.keys //
        .where((key) => key.commodity == symbol.commodity)
        .toList();
    denominationsApplicableToCurrentCommodity.sort((SymbolModel left, SymbolModel right) {
      return left.denominationFull.toLowerCase().compareTo(right.denominationFull.toLowerCase());
    });
    notifyListeners();
  }

//TestWritten
  void addToInterestedInPrices(SymbolModel symbol) {
    interestedInPrices.putIfAbsent(symbol, () => allCommoditiesHistory[symbol]!.last);
    notifyListeners();
  }

  // TestWritten
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

  void _startUpdateTimer() {
    _timer = Timer(Duration(minutes: 15), fetchAndProcessUpdates);
  }
}
