import 'package:crypto_tracker_redux/redux_version/models/price_check_model.dart';
import 'package:crypto_tracker_redux/redux_version/models/symbol_model.dart';

class AppState {
  AppState({
    required this.allCommoditiesHistory,
    required this.interestedInPrices,

  });

  final Map<SymbolModel, List<PriceCheck>> allCommoditiesHistory;
  final Map<SymbolModel, double> interestedInPrices;
  List<SymbolModel> denominationsApplicableToCurrentCommodity = [];

  AppState copyWith({
    Map<SymbolModel, List<PriceCheck>>? allCommoditiesHistory,
    Map<SymbolModel, double>? interestedInPrices,
  }) {
    var _newAppState = AppState(
      allCommoditiesHistory: allCommoditiesHistory ?? this.allCommoditiesHistory,
      interestedInPrices: interestedInPrices ?? this.interestedInPrices,
    );
    return _newAppState;
  }

  AppState.initialState()
      : allCommoditiesHistory = {},
        interestedInPrices = <SymbolModel, double>{};
}


// For future use

  // AppState.fromJson(Map json)
  //     : allCommoditiesHistory = (json['allCommoditiesHistory'] as List)
  //           .map((i) => allCommoditiesHistory.fromJson(i))
  //           .toList(),
  //             commoditiesInterestedIn = (json['commoditiesInterestedIn'] as List)
  //                 .map((i) => allCommoditiesHistory.fromJson(i))
  //                 .toList()
  // ;

  // Map toJson() => {
  //       'allCommoditiesHistory': allCommoditiesHistory,
  //     };

