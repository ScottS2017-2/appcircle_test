import 'package:crypto_tracker_redux/common/models/symbol_model.dart';
import 'package:crypto_tracker_redux/provider_version/models/app_state_model.dart' as providerVersion;
import 'package:crypto_tracker_redux/common/models/price_check_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Common
final mockPriceCheckList = <PriceCheck>[
  PriceCheck(
      symbol: SymbolModel(commodity: 'BTC', denomination: 'GBP'),
      price24h: 1111,
      volume24h: 1111,
      lastTradePrice: 1111),
  PriceCheck(
      symbol: SymbolModel(commodity: 'BTC', denomination: 'EUR'),
      price24h: 2222,
      volume24h: 2222,
      lastTradePrice: 2222),
  PriceCheck(
      symbol: SymbolModel(commodity: 'ETH', denomination: 'USD'),
      price24h: 3333,
      volume24h: 3333,
      lastTradePrice: 3333),
  PriceCheck(
      symbol: SymbolModel(commodity: 'ALGO', denomination: 'USD'),
      price24h: 4444,
      volume24h: 4444,
      lastTradePrice: 4444),
];

final mockSymbolModelList = <SymbolModel>[
  SymbolModel(commodity: 'BTC', denomination: 'GBP'),
  SymbolModel(commodity: 'BTC', denomination: 'EUR'),
  SymbolModel(commodity: 'ETH', denomination: 'USD'),
  SymbolModel(commodity: 'ALGO', denomination: 'USD'),
];

final mockSymbol0 = mockSymbolModelList[0];
final mockSymbol1 = mockSymbolModelList[1];
final mockSymbol2 = mockSymbolModelList[2];
final mockPriceCheck0 = mockPriceCheckList[0];
final mockPriceCheck1 = mockPriceCheckList[1];
final mockPriceCheck2 = mockPriceCheckList[2];

final testAllCommoditiesHistory2 = <SymbolModel, List<PriceCheck>>{
  mockSymbol0 : [mockPriceCheck0],
  mockSymbol2 : [mockPriceCheck2],
};

final testAllCommoditiesHistory3 = <SymbolModel, List<PriceCheck>>{
mockSymbol0 : [mockPriceCheck0],
mockSymbol1 : [mockPriceCheck1],
mockSymbol2 : [mockPriceCheck2],
};

final testInterestedInPrices = <SymbolModel, PriceCheck>{
  mockSymbol0 : mockPriceCheck0,
  mockSymbol1 : mockPriceCheck1,
  mockSymbol2 : mockPriceCheck2,
};

//Provider Specific
var mockAppStateModel = providerVersion.AppStateModel();

Widget mockMaterialApp({required Widget child}) {
  return MaterialApp(
    home: child,
  );
}

Widget mockProvider({required Widget child}) => ChangeNotifierProvider<providerVersion.AppStateModel>(
      create: (context) => mockAppStateModel,
      child: MaterialApp(
        home: child,
      ),
    );
