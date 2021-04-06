import 'package:crypto_tracker_redux/app/app_strings.dart';
import 'package:crypto_tracker_redux/common/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../variablesForTesting.dart';

void main() {
  testWidgets('Home Page', (WidgetTester tester) async {
    await tester.pumpWidget(
      mockProvider(child: Home()),
    );
    expect(find.text(AppStrings.appBarTitle), findsOneWidget);
    expect(find.byType(SafeArea), findsOneWidget);
    expect(find.byType(PageView), findsOneWidget);
  });
}