import 'package:crypto_tracker_redux/redux_version/models/app_state.dart';
import 'package:crypto_tracker_redux/redux_version/pages/redux_home.dart';
import 'package:crypto_tracker_redux/redux_version/redux/actions.dart';
import 'package:crypto_tracker_redux/redux_version/redux/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class MyAppRedux extends StatelessWidget {
  const MyAppRedux({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Store<AppState> store = createStore();
    return StoreProvider<AppState>(
      store: store,
      child: StoreBuilder<AppState>(
        onInit: (store) => store.dispatch(FetchUpdatesAction()),
        builder: (BuildContext context, Store<AppState> store) => ReduxHome(),
      ),
    );
  }
}
