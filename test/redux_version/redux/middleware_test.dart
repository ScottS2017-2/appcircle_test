// import 'package:crypto_tracker_redux/common/models/price_check_model.dart';
// import 'package:crypto_tracker_redux/redux_version/models/app_state_model.dart';
// import 'package:crypto_tracker_redux/redux_version/redux/actions.dart';
// import 'package:crypto_tracker_redux/redux_version/redux/middleware.dart';
//
// import 'package:flutter_test/flutter_test.dart';
//
// import '../../variablesForTesting.dart';
//
// void main() {
//   group('middleware', () {
//     //-------
//     // FIXME is the test store being used or is the regular one?
//     test('action is UpdatePricesAction', () {
//       testViewModel.allCommoditiesHistory.clear();
//       expect(testViewModel.allCommoditiesHistory.isEmpty, true);
//       testStore.dispatch(UpdatePricesAction(updatedListings: testPriceCheckList));
//       final test = testViewModel.allCommoditiesHistory;
//       print(testViewModel.allCommoditiesHistory.length.toString());
//
//    //   expect(testViewModel.allCommoditiesHistory.isEmpty, false);
//     });
//     //-------
//     test('getTicker: Make an http call and parse the json into a list of PriceChecks', () async {
//       List<PriceCheck> _result = [];
//       _result = await getTicker();
//       expect(_result.isNotEmpty, true);
//     });
//
//
//









    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    // //-------
    // test('addUpdatesToHistory', () {
    //   appStateModel.allCommoditiesHistory.clear();
    //   appStateModel.addUpdatesToHistory(testPriceCheckList);
    //   expect(appStateModel.allCommoditiesHistory.entries.first.value.first.symbol.commodityFull, 'Bitcoin');
    //   expect(appStateModel.allCommoditiesHistory.entries.first.value.first.lastTradePrice, 1111);
    //   expect(appStateModel.allCommoditiesHistory.entries.last.value.last.symbol.denominationFull, 'US Dollars');
    //   expect(appStateModel.allCommoditiesHistory.entries.elementAt(2).value.last.price24h, 3333);
    // });
    // //-------
    // test('updateInterestedInList', () {
    //   appStateModel.allCommoditiesHistory.clear();
    //   appStateModel.addUpdatesToHistory(testPriceCheckList);
    //   appStateModel.updateInterestedInList();
    //   expect(appStateModel.allCommoditiesHistory.entries.first.value.first.symbol.commodityFull, 'Bitcoin');
    //   expect(appStateModel.allCommoditiesHistory.entries.first.value.first.symbol.denominationFull, 'British Pounds');
    //   expect(appStateModel.allCommoditiesHistory.entries.first.value.first.lastTradePrice, 1111);
    // });
    // //-------
    // test('clearDenominationsApplicableToCurrentCommodity', () {
    //   appStateModel.denominationsApplicableToCurrentCommodity.addAll(testSymbolModelList);
    //   appStateModel.clearDenominationsApplicableToCurrentCommodity();
    //   expect(appStateModel.denominationsApplicableToCurrentCommodity.isEmpty, true);
    // });
    // //-------
    // test('clearDenominationsApplicableToCurrentCommodity', () async {
    //   appStateModel.denominationsApplicableToCurrentCommodity.clear();
    //   await appStateModel.fetchAndProcessUpdates();
    //   appStateModel.updateDenominationsApplicableToCurrentCommodity(testSymbolModelList[3]);
    //   expect(appStateModel.denominationsApplicableToCurrentCommodity.length == 3, true);
    //   expect(appStateModel.denominationsApplicableToCurrentCommodity[0].denominationFull == 'Bitcoin', true);
    //   expect(appStateModel.denominationsApplicableToCurrentCommodity[1].denominationFull == 'Tether', true);
    //   expect(appStateModel.denominationsApplicableToCurrentCommodity[2].denominationFull == 'US Dollars', true);
    // });
    // //-------
    // test('addToInterestedInPrices', () async {
    //   await appStateModel.fetchAndProcessUpdates();
    //   appStateModel.interestedInPrices.clear();
    //   appStateModel.addToInterestedInPrices(testSymbolModelList[0]);
    //   appStateModel.addToInterestedInPrices(testSymbolModelList[1]);
    //   appStateModel.addToInterestedInPrices(testSymbolModelList[2]);
    //   appStateModel.addToInterestedInPrices(testSymbolModelList[3]);
    //   expect(appStateModel.interestedInPrices.length == 4, true);
    //   expect(appStateModel.interestedInPrices[testSymbolModelList[0]]!.lastTradePrice > 0, true);
    //   expect(appStateModel.interestedInPrices[testSymbolModelList[1]]!.price24h > 0, true);
    //   expect(appStateModel.interestedInPrices[testSymbolModelList[2]]!.volume24h > 0, true);
    //   expect(appStateModel.interestedInPrices[testSymbolModelList[3]]!.volume24h > 0, true);
    // });
    //
    // //-------
    // test('removeFromInterestedInPrices', () {
    //   appStateModel.interestedInPrices.clear();
    //   appStateModel.interestedInPrices.putIfAbsent(testSymbolModelList[0], () => testPriceCheckList[0]);
    //   appStateModel.interestedInPrices.putIfAbsent(testSymbolModelList[1], () => testPriceCheckList[1]);
    //   appStateModel.interestedInPrices.putIfAbsent(testSymbolModelList[2], () => testPriceCheckList[2]);
    //   appStateModel.interestedInPrices.putIfAbsent(testSymbolModelList[3], () => testPriceCheckList[3]);
    //   expect(appStateModel.interestedInPrices.length == 4, true);
    //   appStateModel.removeFromInterestedInPrices(testSymbolModelList[2]);
    //   expect(appStateModel.interestedInPrices.length == 3, true);
    //   appStateModel.removeFromInterestedInPrices(testSymbolModelList[0]);
    //   expect(appStateModel.interestedInPrices.length == 2, true);
    //   appStateModel.removeFromInterestedInPrices(testSymbolModelList[1]);
    //   expect(appStateModel.interestedInPrices.containsKey(testSymbolModelList[3]), true);
    // });
  // });
// }
