import 'package:crypto_tracker_redux/provider_version/my_app_provider.dart';
import 'package:crypto_tracker_redux/redux_version/my_app_redux.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController controller = PageController(
    initialPage: 0,
  );

  List<Widget> pages = [
    const MyAppProvider(),
    const MyAppRedux(),
  ];

  /// This code is completely optional, and is used to change the color &
  /// text of the AppBar each time you swipe
  String titleString = 'Crypto Alert System - Provider';

  void setTitle(int page) {
    if (page == 0) {
      setState(() {
        titleString = 'Crypto Alert System - Provider';
      });
    } else if (page == 1) {
      setState(() {
        titleString = 'Crypto Alert System - Redux';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titleString),
      ),
      body: PageView(
        onPageChanged: setTitle,
        children: pages,
      ),
    );
  }
}