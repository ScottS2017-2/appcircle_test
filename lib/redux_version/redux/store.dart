import 'package:crypto_tracker_redux/redux_version/models/app_state_model.dart';
import 'package:crypto_tracker_redux/redux_version/redux/middleware.dart';
import 'package:crypto_tracker_redux/redux_version/redux/reducers.dart';
import 'package:redux/redux.dart';

Store<AppStateModel> createStore() {
  return Store(
    appStateReducer,
    initialState: AppStateModel.initialState(),
    middleware: [appStateMiddleware],
  );
}