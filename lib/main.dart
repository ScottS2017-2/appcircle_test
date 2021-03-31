import 'package:crypto_tracker_redux/app/app_themes.dart';
import 'package:crypto_tracker_redux/pages_common_to_all_versions/home.dart';
import 'package:crypto_tracker_redux/pages_common_to_all_versions/splash_screen.dart';
import 'package:crypto_tracker_redux/provider_version/models/app_state_model.dart';
import 'package:crypto_tracker_redux/redux_version/my_app_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  static AppStateModel appStateOf(BuildContext context) {
    return Provider.of<AppStateModel>(context, listen: false);
  }

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
      title: 'Crypto Tracker',
      theme: AppTheme.light(),
        home:ChangeNotifierProvider(
          create: (BuildContext context) => AppStateModel(),
          child:Home(),
        ),
       // home:SplashScreen(),
    );
  }
}
