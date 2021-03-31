import 'package:crypto_tracker_redux/redux_version/models/price_check_model.dart';
import 'package:crypto_tracker_redux/redux_version/models/symbol_model.dart';

class AppState {
  AppState({
    required this.allCommoditiesHistory,
    required this.interestedInPrices,
    required this.denominationsApplicableToCurrentCommodity,
    required this.itemToAdd,
    required this.itemToRemove,
    required this.slidersAreOnStage,
    required this.isConnected,
  });

  final Map<SymbolModel, List<PriceCheck>> allCommoditiesHistory;
  final Map<SymbolModel, double> interestedInPrices;
  final List<SymbolModel> denominationsApplicableToCurrentCommodity;
  final SymbolModel itemToAdd;
  final SymbolModel itemToRemove;
  final bool slidersAreOnStage;
  final bool isConnected;

  AppState copyWith({
    Map<SymbolModel, List<PriceCheck>>? allCommoditiesHistory,
    Map<SymbolModel, double>? interestedInPrices,
    List<SymbolModel>? denominationsApplicableToCurrentCommodity,
    SymbolModel? itemToAdd,
    SymbolModel? itemToRemove,
    bool? slidersAreOnStage,
    bool? isConnected,
  }) {
    final _newAppState = AppState(
      allCommoditiesHistory: allCommoditiesHistory ?? this.allCommoditiesHistory,
      interestedInPrices: interestedInPrices ?? this.interestedInPrices,
      denominationsApplicableToCurrentCommodity:
          denominationsApplicableToCurrentCommodity ?? this.denominationsApplicableToCurrentCommodity,
      itemToAdd: itemToAdd ?? this.itemToAdd,
      itemToRemove: itemToRemove ?? this.itemToRemove,
      slidersAreOnStage: slidersAreOnStage ?? this.slidersAreOnStage,
      isConnected: isConnected ?? this.isConnected,
    );
    return _newAppState;
  }

  AppState.initialState()
      : allCommoditiesHistory = {},
        interestedInPrices = <SymbolModel, double>{},
        denominationsApplicableToCurrentCommodity = [],
        itemToAdd = SymbolModel.fromString('Default-String'),
        itemToRemove = SymbolModel.fromString('Default-String'),
        slidersAreOnStage = false,
        isConnected = false;
}
