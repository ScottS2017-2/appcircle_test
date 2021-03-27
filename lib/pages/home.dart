import 'package:crypto_tracker_redux/app/app_colors.dart';
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
      create: (BuildContext context) => AppStateModel(),
      child: ProviderHome(),
    ),
    const MyAppRedux(),
  ];

  String titleString = 'Crypto Alerts';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          children: [
            Material(
              elevation: 4,
              child: Ink(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.oliveAccent,
                      Theme.of(context).primaryColor,
                    ],
                    begin: Alignment(-2, -1.75),
                    end: Alignment(2, 1.75),
                    stops: [0, 1],
                  ),
                ),
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        titleString,
                        style: AppTextStyles.appBarTextStyle,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: PageView(
                  children: pages,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
