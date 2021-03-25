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
    LEND: 'Aave Coin',
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

  // Commodities to Denominations Map
  static const Map<String, List<String>> commoditiesAndTheirDenominations = {
    AAVE: [USDT, USD],
    LEND: [USDT, USD],
    ALGO: [BTC, USD, USDT],
    BCH: [BTC, ETH, EUR, PAX, USD, USDT],
    BTC: [EUR, GBP, PAX, TRY, USD, USDT],
    DGLD: [BTC, USD],
    ENJ: [USD, USDT],
    ETH: [BTC, EUR, GBP, PAX, TRY, USD, USDT],
    LTC: [BTC, EUR, PAX, TRY, USD, USDT],
    OGN: [USD, USDT],
    PAX: [EUR, USD],
    XLM: [BTC, ETH, EUR, PAX, USD],
    USDT: [EUR, GBP, TRY, USD],
    WDGLD: [BTC, DGLD, USD],
    XRP: [EUR, USD],
    YFI: [USD, USDT],
  };
}
