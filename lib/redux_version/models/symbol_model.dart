import 'package:crypto_tracker_redux/app/app_strings.dart';

class SymbolModel {
  const SymbolModel(
    this.commodity,
    this.denomination,
  );

  final String commodity;
  final String denomination;

  static SymbolModel fromString(String symbol) {
    final splitStrings = symbol.split('-');
    final commodity = splitStrings[0];
    final denomination = splitStrings[1];
    return SymbolModel(commodity, denomination);
  }

  String get commodityFull => AppStrings.unabbreviatedTerms[commodity] ?? commodity;

  String get denominationFull => AppStrings.unabbreviatedTerms[denomination] ?? denomination;

  @override
  String toString() {
    return '$commodity-$denomination';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SymbolModel &&
          runtimeType == other.runtimeType &&
          commodity == other.commodity &&
          denomination == other.denomination;

  @override
  int get hashCode => commodity.hashCode ^ denomination.hashCode;
}
