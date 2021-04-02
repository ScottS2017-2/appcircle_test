import 'package:crypto_tracker_redux/provider_version/models/app_state_model.dart';
import 'package:crypto_tracker_redux/provider_version/models/price_check_model.dart';
import 'package:crypto_tracker_redux/provider_version/models/symbol_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../variablesForTesting.dart';

void main() {
  group('Fetching and processing updates', () {
    var appStateModel = AppStateModel();
    //-------
    test('getTicker: Make an http call and parse the json into a list of PriceChecks', () async {
      List<PriceCheck> _result = [];
      _result = await appStateModel.getTicker();
      expect(_result.isNotEmpty, true);
    });
    //-------
    test('addUpdatesToHistory', () {
      appStateModel.allCommoditiesHistory.clear();
      appStateModel.addUpdatesToHistory(testPriceCheckList);
      expect(appStateModel.allCommoditiesHistory.entries.first.value.first.symbol.commodityFull, 'Bitcoin');
      expect(appStateModel.allCommoditiesHistory.entries.first.value.first.lastTradePrice, 1111);
      expect(appStateModel.allCommoditiesHistory.entries.last.value.last.symbol.denominationFull, 'US Dollars');
      expect(appStateModel.allCommoditiesHistory.entries.last.value.last.price24h, 3333);
    });
    //-------
    test('updateInterestedInList', () {
      appStateModel.allCommoditiesHistory.clear();
      appStateModel.addUpdatesToHistory(testPriceCheckList);
      appStateModel.updateInterestedInList();
      expect(appStateModel.allCommoditiesHistory.entries.first.value.first.symbol.commodityFull, 'Bitcoin');
      expect(appStateModel.allCommoditiesHistory.entries.first.value.first.symbol.denominationFull, 'British Pounds');
      expect(appStateModel.allCommoditiesHistory.entries.first.value.first.lastTradePrice, 1111);
    });
    //-------
    test(
        'fetchAndProcessUpdates test, combines the above tests to ensure the sequence functions correctly from end to end',
        () async {
      appStateModel.allCommoditiesHistory.clear();
      expect(appStateModel.allCommoditiesHistory.isEmpty, true);
      await appStateModel.manualUpdatePrices();
      expect(appStateModel.allCommoditiesHistory.isEmpty, false);
    });
  });
}
