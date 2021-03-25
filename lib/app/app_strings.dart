import 'package:crypto_tracker_redux/provider_version/models/price_check_model.dart';

class AppStrings {
  // Common Strings
  static const String following = 'Following';

  // Abbreviations
  static const String AAVE = 'AAVE';
  static const String ALGO = 'ALGO';
  static const String BCH = 'BCH';
  static const String BTC = 'BTC';
  static const String DGLD = 'DGLD';
  static const String ENJ = 'ENJ';
  static const String ETH = 'ETH';
  static const String EUR = 'EUR';
  static const String GBP = 'GBP';
  static const String LEND = 'LEND';
  static const String LTC = 'LTC';
  static const String OGN = 'OGN';
  static const String PAX = 'PAX';
  static const String TRY = 'TRY';
  static const String USD = 'USD';
  static const String USDT = 'USDT';
  static const String WDGLD = 'WDGLD';
  static const String XLM = 'XLM';
  static const String XRP = 'XRP';
  static const String YFI = 'YFI';

  // Full names
  static const Map<String, String> unabbreviatedTerms = {
    AAVE: 'Aave',
    LEND: 'LEND',
    ALGO: 'ALGO',
    BCH: 'Bitcoin Cash',
    BTC: 'Bitcoin',
    GBP: 'British Pounds',
    DGLD: 'DGLD',
    ENJ: 'Enjin Coin',
    ETH: 'Ethereum',
    EUR: 'Euros',
    LTC: 'Litecoin',
    OGN: 'Origin Protocol',
    PAX: 'Paxos Standard',
    XLM: 'Stellar',
    USDT: 'Tether',
    TRY: 'Trias',
    USD: 'US Dollars',
    WDGLD: 'wrapped-DGLD',
    XRP: 'XRP',
    YFI: 'yearn.finance',
  };

  static const Map<String, Map<String, List<PriceCheck>>> commoditiesHistory = {
    AAVE: {
      USDT: <PriceCheck>[],
      USD: <PriceCheck>[],
    },
    LEND: {
      USDT: <PriceCheck>[],
      USD: <PriceCheck>[],
    },
    ALGO: {
      BTC: <PriceCheck>[],
      USD: <PriceCheck>[],
      USDT: <PriceCheck>[],
    },
    BCH: {
      BTC: <PriceCheck>[],
      ETH: <PriceCheck>[],
      EUR: <PriceCheck>[],
      PAX: <PriceCheck>[],
      USD: <PriceCheck>[],
      USDT: <PriceCheck>[]
    },
    BTC: {
      EUR: <PriceCheck>[],
      GBP: <PriceCheck>[],
      PAX: <PriceCheck>[],
      TRY: <PriceCheck>[],
      USD: <PriceCheck>[],
      USDT: <PriceCheck>[]
    },
    DGLD: {
      BTC: <PriceCheck>[],
      USD: <PriceCheck>[],
    },
    ENJ: {
      USD: <PriceCheck>[],
      USDT: <PriceCheck>[],
    },
    ETH: {
      BTC: <PriceCheck>[],
      EUR: <PriceCheck>[],
      GBP: <PriceCheck>[],
      PAX: <PriceCheck>[],
      TRY: <PriceCheck>[],
      USD: <PriceCheck>[],
      USDT: <PriceCheck>[]
    },
    LTC: {
      BTC: <PriceCheck>[],
      EUR: <PriceCheck>[],
      PAX: <PriceCheck>[],
      TRY: <PriceCheck>[],
      USD: <PriceCheck>[],
      USDT: <PriceCheck>[]
    },
    OGN: {
      USD: <PriceCheck>[],
      USDT: <PriceCheck>[],
    },
    PAX: {
      EUR: <PriceCheck>[],
      USD: <PriceCheck>[],
    },
    XLM: {
      BTC: <PriceCheck>[],
      ETH: <PriceCheck>[],
      EUR: <PriceCheck>[],
      PAX: <PriceCheck>[],
      USD: <PriceCheck>[]
    },
    USDT: {
      EUR: <PriceCheck>[],
      GBP: <PriceCheck>[],
      TRY: <PriceCheck>[],
      USD: <PriceCheck>[]
    },
    WDGLD: {
      BTC: <PriceCheck>[],
      DGLD: <PriceCheck>[],
      USD: <PriceCheck>[],
    },
    XRP: {
      EUR: <PriceCheck>[],
      USD: <PriceCheck>[],
    },
    YFI: {
      USD: <PriceCheck>[],
      USDT: <PriceCheck>[],
    },
  };
}
