import 'package:crypto_tracker_redux/not_yet_implemented_redux_version/models/app_state.dart';
import 'package:crypto_tracker_redux/not_yet_implemented_redux_version/models/view_models.dart';
import 'package:crypto_tracker_redux/not_yet_implemented_redux_version/widgets/content_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class ReduxHome extends StatelessWidget {
  ReduxHome({
    Key? key,
    required this.store,
  }) : super(key: key);

  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      converter: (Store<AppState> store) => ViewModel.create(store),
      builder: (BuildContext context, ViewModel viewModel) {
        return ContentArea(
          store: store,
          viewModel: viewModel,
        );
      },
    );
  }
}
