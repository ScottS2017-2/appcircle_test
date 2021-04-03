import 'package:crypto_tracker_redux/common/models/symbol_model.dart';
import 'file:///E:/Flutter/myprojects/crypto_tracker_redux/lib/common/models/price_check_model.dart';

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