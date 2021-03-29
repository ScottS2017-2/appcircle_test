import 'package:crypto_tracker_redux/app/app_colors.dart';
import 'package:crypto_tracker_redux/app/app_strings.dart';
import 'package:crypto_tracker_redux/provider_version/pages/provider_home.dart';
import 'package:crypto_tracker_redux/redux_version/my_app_redux.dart';
import 'package:flutter/material.dart';

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
    ProviderHome(),
    // TODO finish Redux version
    // const MyAppRedux(),
  ];

  String titleString = AppStrings.appBarTitle;

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
                        style: Theme.of(context).textTheme.headline4!.copyWith(color: AppColors.offWhitePageBackground, shadows: [
                          BoxShadow(
                            color: AppColors.blackTextColor,
                            blurRadius: 2,
                            offset: Offset(1, 1),
                          ),
                        ]),
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
