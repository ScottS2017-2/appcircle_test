import 'package:crypto_tracker_redux/app/app_strings.dart';
import 'package:crypto_tracker_redux/app/responsive_design_constants.dart';
import 'package:crypto_tracker_redux/common/models/symbol_model.dart';
import 'package:crypto_tracker_redux/provider_version/widgets/top_slide_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../variablesForTesting.dart';

void main() {
  mockAppStateModel.allCommoditiesHistory.clear();
  mockAppStateModel.denominationsApplicableToCurrentCommodity.clear();
  mockAppStateModel.allCommoditiesHistory.addAll(testAllCommoditiesHistory2);
  final SymbolModel symbol = mockAppStateModel.allCommoditiesHistory.keys.first;
  testWidgets('TopSlideIn', (WidgetTester tester) async {
    await tester.pumpWidget(
      mockProvider(
        child: Center(
          child: TopSlideIn(
            height: ResponsiveDesignConstants.largeScreenTopSlideHeight,
            width: ResponsiveDesignConstants.largeScreenTopSlideWidth,
          ),
        ),
      ),
    );
    //
    expect(find.text(AppStrings.commodities), findsOneWidget);
    expect(find.text(AppStrings.denominations), findsOneWidget);
    expect(find.text(AppStrings.selectCommodity), findsOneWidget);
    expect(find.byKey(Key('TopSlideInTopListView')), findsOneWidget);
    expect(find.byType(TextButton), findsNWidgets(2));
    await tester.tap(find.byKey(Key(symbol.commodityFull)));
    await tester.pump();
    expect(find.byKey(Key(symbol.denominationFull)), findsOneWidget);
    await tester.tap(find.byKey(Key(symbol.denominationFull)));
    await tester.pump();
    expect(mockAppStateModel.interestedInPrices.keys.contains(symbol), true);
  });
}