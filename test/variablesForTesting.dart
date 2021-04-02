import 'package:crypto_tracker_redux/provider_version/models/price_check_model.dart';
import 'package:crypto_tracker_redux/provider_version/models/symbol_model.dart';

final testPriceCheckList = <PriceCheck>[
  PriceCheck(
      symbol: SymbolModel(commodity: 'BTC', denomination: 'GBP'),
      price24h: 1111,
      volume24h: 1111,
      lastTradePrice: 1111),
  PriceCheck(
      symbol: SymbolModel(commodity: 'BTC', denomination: 'ETH'),
      price24h: 2222,
      volume24h: 2222,
      lastTradePrice: 2222),
  PriceCheck(
      symbol: SymbolModel(commodity: 'ETH', denomination: 'USD'),
      price24h: 3333,
      volume24h: 3333,
      lastTradePrice: 3333),
];

final testSymbolModelList = <SymbolModel>[
  SymbolModel(commodity: 'BTC', denomination: 'BP'),
  SymbolModel(commodity: 'BTC', denomination: 'ETH'),
  SymbolModel(commodity: 'ETH', denomination: 'USD'),
];

final symbol0 = testSymbolModelList[0];
final symbol1 = testSymbolModelList[1];
final symbol2 = testSymbolModelList[2];
final priceCheck0 = testPriceCheckList[0];
final priceCheck1 = testPriceCheckList[1];
final priceCheck2 = testPriceCheckList[2];