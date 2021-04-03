import 'package:crypto_tracker_redux/app/app_strings.dart';
import 'package:crypto_tracker_redux/app/responsive_design_constants.dart';
import 'package:crypto_tracker_redux/provider_version/widgets/top_slide_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../variablesForTesting.dart';




void main() {
  //FIXME needs provider ancestor see if that solves the directionality issue
  testWidgets('TopSlideIn', (WidgetTester tester) async {
    await tester.pumpWidget(
      createHomeScreen(),
    );
    expect(find.text(AppStrings.appBarTitle), findsOneWidget);
  });
}
