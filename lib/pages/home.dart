import 'package:crypto_tracker_redux/app/app_textstyles.dart';
import 'package:crypto_tracker_redux/provider_version/models/app_state_model.dart';
import 'package:crypto_tracker_redux/provider_version/pages/provider_home.dart';
import 'package:crypto_tracker_redux/redux_version/my_app_redux.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController controller = PageController(
    initialPage: 0,
  );

  List<Widget> pages = [
    ChangeNotifierProvider(
  create: (BuildContext context) => AppStateModel.initialState(),
  child: ProviderHome(),
  ),
    const MyAppRedux(),
  ];

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
  void initState() {
    super.initState();
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
