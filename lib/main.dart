import 'package:crypto_tracker_redux/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'provider_version/models/app_state_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    /// Lock orientation to portrait (up)
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Redux ToDo Demo',
      theme: ThemeData.light(),
      home: ChangeNotifierProvider(
        create: (BuildContext context) => AppStateModel.initialState(),
        child: Home(),
      ),
    );
  }
}
