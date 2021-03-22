import 'package:crypto_tracker_redux/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider_version/models/app_state_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Redux ToDo Demo',
      theme: ThemeData.dark(),
      home: ChangeNotifierProvider(
        create: (BuildContext context) => AppStateModel.initialState(),
        child: Home(),
      ),
    );
  }
}
