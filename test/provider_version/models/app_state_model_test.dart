import 'package:crypto_tracker_redux/common/models/price_check_model.dart';

import 'package:flutter_test/flutter_test.dart';

import '../../variablesForTesting.dart';

void main() {
  group('Fetching and processing updates', () {
    test(
        'fetchAndProcessUpdates test, combines the above tests to ensure the sequence functions correctly from end to end',
        () async {
      mockAppStateModel.allCommoditiesHistory.clear();
      expect(mockAppStateModel.allCommoditiesHistory.isEmpty, true);
      await mockAppStateModel.fetchAndProcessUpdates();
      expect(mockAppStateModel.allCommoditiesHistory.isEmpty, false);
    });
    //-------
    test('getTicker: Make an http call and parse the json into a list of PriceChecks', () async {
      List<PriceCheck> _result = [];
      _result = await mockAppStateModel.getTicker();
      expect(_result.isNotEmpty, true);
    });
    //-------
    test('addUpdatesToHistory', () {
      mockAppStateModel.allCommoditiesHistory.clear();
      mockAppStateModel.addUpdatesToHistory(mockPriceCheckList);
      expect(mockAppStateModel.allCommoditiesHistory.entries.first.value.first.symbol.commodityFull, 'Bitcoin');
      expect(mockAppStateModel.allCommoditiesHistory.entries.first.value.first.lastTradePrice, 1111);
      expect(mockAppStateModel.allCommoditiesHistory.entries.last.value.last.symbol.denominationFull, 'US Dollars');
      expect(mockAppStateModel.allCommoditiesHistory.entries.elementAt(2).value.last.price24h, 3333);
    });
    //-------
    test('updateInterestedInList', () async {
      await mockAppStateModel.fetchAndProcessUpdates();
      mockAppStateModel.interestedInPrices.clear();
      mockAppStateModel.addToInterestedInPrices(mockSymbolModelList[0]);
      mockAppStateModel.addToInterestedInPrices(mockSymbolModelList[1]);
      expect(mockAppStateModel.interestedInPrices[mockSymbolModelList[0]]!.symbol.commodityFull, 'Bitcoin');
      expect(mockAppStateModel.interestedInPrices[mockSymbolModelList[1]]!.symbol.denominationFull, 'Euros');
    });
    //-------
    test('clearDenominationsApplicableToCurrentCommodity', () {
      mockAppStateModel.denominationsApplicableToCurrentCommodity.addAll(mockSymbolModelList);
      mockAppStateModel.clearDenominationsApplicableToCurrentCommodity();
      expect(mockAppStateModel.denominationsApplicableToCurrentCommodity.isEmpty, true);
    });
    //-------
    test('clearDenominationsApplicableToCurrentCommodity', () async {
      mockAppStateModel.denominationsApplicableToCurrentCommodity.clear();
      await mockAppStateModel.fetchAndProcessUpdates();
      mockAppStateModel.updateDenominationsApplicableToCurrentCommodity(mockSymbolModelList[3]);
      expect(mockAppStateModel.denominationsApplicableToCurrentCommodity.length == 3, true);
      expect(mockAppStateModel.denominationsApplicableToCurrentCommodity[0].denominationFull == 'Bitcoin', true);
      expect(mockAppStateModel.denominationsApplicableToCurrentCommodity[1].denominationFull == 'Tether', true);
      expect(mockAppStateModel.denominationsApplicableToCurrentCommodity[2].denominationFull == 'US Dollars', true);
    });
    //-------
    test('addToInterestedInPrices', () async {
      await mockAppStateModel.fetchAndProcessUpdates();
      mockAppStateModel.interestedInPrices.clear();
      mockAppStateModel.addToInterestedInPrices(mockSymbolModelList[0]);
      mockAppStateModel.addToInterestedInPrices(mockSymbolModelList[1]);
      mockAppStateModel.addToInterestedInPrices(mockSymbolModelList[2]);
      mockAppStateModel.addToInterestedInPrices(mockSymbolModelList[3]);
      expect(mockAppStateModel.interestedInPrices.length == 4, true);
      expect(mockAppStateModel.interestedInPrices[mockSymbolModelList[0]]!.lastTradePrice > 0, true);
      expect(mockAppStateModel.interestedInPrices[mockSymbolModelList[1]]!.price24h > 0, true);
      expect(mockAppStateModel.interestedInPrices[mockSymbolModelList[2]]!.volume24h > 0, true);
      expect(mockAppStateModel.interestedInPrices[mockSymbolModelList[3]]!.volume24h > 0, true);
    });

    //-------
    test('removeFromInterestedInPrices', () {
      mockAppStateModel.interestedInPrices.clear();
      mockAppStateModel.interestedInPrices.putIfAbsent(mockSymbolModelList[0], () => mockPriceCheckList[0]);
      mockAppStateModel.interestedInPrices.putIfAbsent(mockSymbolModelList[1], () => mockPriceCheckList[1]);
      mockAppStateModel.interestedInPrices.putIfAbsent(mockSymbolModelList[2], () => mockPriceCheckList[2]);
      mockAppStateModel.interestedInPrices.putIfAbsent(mockSymbolModelList[3], () => mockPriceCheckList[3]);
      expect(mockAppStateModel.interestedInPrices.length == 4, true);
      mockAppStateModel.removeFromInterestedInPrices(mockSymbolModelList[2]);
      expect(mockAppStateModel.interestedInPrices.length == 3, true);
      mockAppStateModel.removeFromInterestedInPrices(mockSymbolModelList[0]);
      expect(mockAppStateModel.interestedInPrices.length == 2, true);
      mockAppStateModel.removeFromInterestedInPrices(mockSymbolModelList[1]);
      expect(mockAppStateModel.interestedInPrices.containsKey(mockSymbolModelList[3]), true);
    });
  });
}
