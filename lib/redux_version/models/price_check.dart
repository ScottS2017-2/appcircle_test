import 'package:flutter/foundation.dart';

class PriceCheck {
  PriceCheck({
    @required this.symbol,
    @required this.price24h,
    @required this.volume24h,
    @required this.lastTradePrice,
  });

  DateTime time = DateTime.now();
  final String symbol;
  final double price24h;
  final double volume24h;
  final double lastTradePrice;

  factory PriceCheck.fromJson(Map<String, dynamic> json) => PriceCheck(
        symbol: json['symbol'],
        price24h: json['price_24h'].toDouble(),
        volume24h: json['volume_24h'].toDouble(),
        lastTradePrice: json['last_trade_price'].toDouble(),
      );

  Map toJson() => {
        'symbol': symbol,
        'price_24h': price24h,
        'volume_24h': volume24h,
        'last_trade_price': lastTradePrice,
      };
}
