import 'package:crypto_tracker_redux/app/app_strings.dart';
import 'package:crypto_tracker_redux/app/responsive_design_constants.dart';
import 'package:crypto_tracker_redux/common/models/symbol_model.dart';
import 'package:crypto_tracker_redux/provider_version/widgets/bottom_slide_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../variablesForTesting.dart';

void main() {

  mockAppStateModel.interestedInPrices.clear();
  mockAppStateModel.allCommoditiesHistory.clear();
  mockAppStateModel.denominationsApplicableToCurrentCommodity.clear();
  mockAppStateModel.allCommoditiesHistory.addAll(testAllCommoditiesHistory2);
  final SymbolModel symbol = testAllCommoditiesHistory2.keys.first;
  testWidgets('BottomSlideIn', (WidgetTester tester) async {
    await tester.pumpWidget(
      mockProvider(
        child: Center(
          child: BottomSlideIn(
            height: ResponsiveDesignConstants.smallScreenBottomSlideHeight,
            width: ResponsiveDesignConstants.smallScreenBottomSlideWidth,
          ),
        ),
      ),
    );
    // Render the widget with an empty list
    expect(find.text(AppStrings.following), findsOneWidget);
    expect(find.text(AppStrings.tapToRemove), findsOneWidget);
    expect(find.byKey(Key('BottomSlideInTopListView')), findsOneWidget);
    expect(find.byType(TextButton), findsNothing);
    // Ensure a new button is created
    mockAppStateModel.addToInterestedInPrices(symbol);
    await tester.pumpAndSettle();
    expect(find.byType(TextButton), findsOneWidget);
    expect(find.text('${symbol.commodityFull} in ${symbol.denominationFull}'), findsOneWidget);
    // Ensure the button is deleted
    await tester.tap(find.byType(TextButton));
    await tester.pump();
    expect(find.byType(TextButton), findsNothing);
  });
}