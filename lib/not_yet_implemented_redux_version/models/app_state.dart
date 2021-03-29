import 'package:crypto_tracker_redux/not_yet_implemented_redux_version/models/price_check.dart';

class AppState {
  AppState({
    required this.allCommoditiesHistory,
    required this.interestedInPrices,
    required this.isLoading,
  });

  final Map<String, List<PriceCheck>> allCommoditiesHistory;
  final Map<String, double> interestedInPrices;
  final bool isLoading;

  AppState copyWith({
    Map<String, List<PriceCheck>>? allCommoditiesHistory,
    Map<String, double>? interestedInPrices,
    bool? isLoading,
  }) {
    var _newAppState = AppState(
      allCommoditiesHistory: allCommoditiesHistory ?? this.allCommoditiesHistory,
      interestedInPrices: interestedInPrices ?? this.interestedInPrices,
      isLoading: isLoading ?? this.isLoading,
    );
    return _newAppState;
  }

  AppState.initialState()
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
          'ETC-USD': 50,
        },
        // TODO change the below initialization to be empty
        isLoading = true;

  // AppState.fromJson(Map json)
  //     : allCommoditiesHistory = (json['allCommoditiesHistory'] as List)
  //           .map((i) => allCommoditiesHistory.fromJson(i))
  //           .toList(),
  //             commoditiesInterestedIn = (json['commoditiesInterestedIn'] as List)
  //                 .map((i) => allCommoditiesHistory.fromJson(i))
  //                 .toList()
  // ;

  Map toJson() => {
        'allCommoditiesHistory': allCommoditiesHistory,
      };
}
