import 'package:crypto_tracker_redux/provider_version/models/app_state_model.dart';
import 'package:flutter/material.dart';

import 'package:crypto_tracker_redux/provider_version/pages/provider_home.dart';

import 'package:provider/provider.dart';

class MyAppProvider extends StatelessWidget {
  const MyAppProvider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => AppStateModel.initialState(),
      child: ProviderHome(),
    );
  }
}