import 'package:crypto_tracker_redux/app/app_colors.dart';
import 'package:crypto_tracker_redux/app/app_strings.dart';
import 'package:crypto_tracker_redux/common/pages/welcome_page.dart';
import 'package:crypto_tracker_redux/provider_version/pages/provider_home.dart';
import 'package:crypto_tracker_redux/redux_version/redux/store.dart';

import 'package:flutter/material.dart';

import 'package:crypto_tracker_redux/redux_version/models/app_state_model.dart';
import 'package:crypto_tracker_redux/redux_version/pages/redux_home.dart';
import 'package:crypto_tracker_redux/redux_version/redux/actions.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late PageController _controller;

  List<Widget> pages = [
    ProviderHome(),
    Welcome(),
    StoreProvider<AppStateModel>(
      store: createStore(),
      child: StoreBuilder<AppStateModel>(
        onInit: (store) => store.dispatch(FetchUpdatesAction()),
        builder: (BuildContext context, Store<AppStateModel> store) => ReduxHome(),
      ),
    ),
  ];

  // String titleString = AppStrings.appBarTitle;
  String titleString = 'Appcircle Testing';

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 1);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: SizedBox.expand(
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
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: AppColors.offWhitePageBackground, shadows: [
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
                    controller: _controller,
                    children: pages,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
