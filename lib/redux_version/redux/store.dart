import 'package:crypto_tracker_redux/redux_version/models/app_state.dart';
import 'package:crypto_tracker_redux/redux_version/redux/middleware.dart';
import 'package:crypto_tracker_redux/redux_version/redux/reducers.dart';
import 'package:redux/redux.dart';

Store<AppState> createStore() {
  return Store(
    appStateReducer,
    initialState: AppState.initialState(),
    middleware: [appStateMiddleware],
  );
}