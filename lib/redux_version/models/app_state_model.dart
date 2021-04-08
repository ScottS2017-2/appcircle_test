import 'package:crypto_tracker_redux/common/models/price_check_model.dart';
import 'package:crypto_tracker_redux/common/models/symbol_model.dart';
import 'package:flutter/cupertino.dart';

@immutable
class AppStateModel {
  AppStateModel({
    required this.allCommoditiesHistory,
    required this.interestedInPrices,
    required this.denominationsApplicableToCurrentCommodity,
    required this.itemToAdd,
    required this.itemToRemove,
    required this.slidersAreOnStage,
    required this.isConnected,
  });

  final Map<SymbolModel, List<PriceCheck>> allCommoditiesHistory;
  final Map<SymbolModel, PriceCheck> interestedInPrices;
  final List<SymbolModel> denominationsApplicableToCurrentCommodity;
  final SymbolModel itemToAdd;
  final SymbolModel itemToRemove;
  final bool slidersAreOnStage;
  final bool isConnected;

  AppStateModel copyWith({
    Map<SymbolModel, List<PriceCheck>>? allCommoditiesHistory,
    Map<SymbolModel, PriceCheck>? interestedInPrices,
    List<SymbolModel>? denominationsApplicableToCurrentCommodity,
    SymbolModel? itemToAdd,
    SymbolModel? itemToRemove,
    bool? slidersAreOnStage,
    bool? isConnected,
  }) => AppStateModel(
      allCommoditiesHistory: allCommoditiesHistory ?? this.allCommoditiesHistory,
      interestedInPrices: interestedInPrices ?? this.interestedInPrices,
      denominationsApplicableToCurrentCommodity:
          denominationsApplicableToCurrentCommodity ?? this.denominationsApplicableToCurrentCommodity,
      itemToAdd: itemToAdd ?? this.itemToAdd,
      itemToRemove: itemToRemove ?? this.itemToRemove,
      slidersAreOnStage: slidersAreOnStage ?? this.slidersAreOnStage,
      isConnected: isConnected ?? this.isConnected,
    );


  AppStateModel.initialState()
      : allCommoditiesHistory = {},
        interestedInPrices = <SymbolModel, PriceCheck>{},
        denominationsApplicableToCurrentCommodity = [],
        itemToAdd = SymbolModel.fromString('Default-String'),
        itemToRemove = SymbolModel.fromString('Default-String'),
        slidersAreOnStage = false,
        isConnected = false;
}
