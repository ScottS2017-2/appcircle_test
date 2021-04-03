import 'package:crypto_tracker_redux/common/models/symbol_model.dart';
import 'package:crypto_tracker_redux/pages_common_to_all_versions/home.dart';
import 'package:crypto_tracker_redux/provider_version/models/app_state_model.dart' as providerVersion;
import 'package:crypto_tracker_redux/redux_version/models/view_model.dart';
import 'package:crypto_tracker_redux/common/models/price_check_model.dart';
import 'package:crypto_tracker_redux/redux_version/redux/store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Common
final testPriceCheckList = <PriceCheck>[
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

final testSymbolModelList = <SymbolModel>[
  SymbolModel(commodity: 'BTC', denomination: 'GBP'),
  SymbolModel(commodity: 'BTC', denomination: 'EUR'),
  SymbolModel(commodity: 'ETH', denomination: 'USD'),
  SymbolModel(commodity: 'ALGO', denomination: 'USD'),
];

final symbol0 = testSymbolModelList[0];
final symbol1 = testSymbolModelList[1];
final symbol2 = testSymbolModelList[2];
final priceCheck0 = testPriceCheckList[0];
final priceCheck1 = testPriceCheckList[1];
final priceCheck2 = testPriceCheckList[2];

// Redux Specific
final testStore = createStore();
final testViewModel = ViewModel.create(testStore);

Widget createHomeScreen() => ChangeNotifierProvider<providerVersion.AppStateModel>(
  create: (context) => providerVersion.AppStateModel(),
  child: MaterialApp(
    home: Home(),
  ),
);