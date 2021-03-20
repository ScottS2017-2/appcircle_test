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
  String titleString = 'Redux Example';
  Color appBarColor = const Color(0xFFA13565);

  void setTitle(int page) {
    if (page == 0) {
      setState(() {
        titleString = 'Redux Example';
        appBarColor = const Color(0xFFA13565);
      });
    } else if (page == 1) {
      setState(() {
        titleString = 'Provider Example';
        appBarColor = const Color(0xFFA00084);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text(titleString),
      ),
      body: PageView(
        onPageChanged: setTitle,
        children: pages,
      ),
    );
  }
}