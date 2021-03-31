import 'package:crypto_tracker_redux/redux_version/models/app_state.dart';
import 'package:crypto_tracker_redux/redux_version/models/view_model.dart';
import 'package:crypto_tracker_redux/redux_version/widgets/content_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class ReduxHome extends StatelessWidget {
  ReduxHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      converter: (Store<AppState> store) => ViewModel.create(store),
      distinct: true,
      onWillChange: (_, viewModel) {
        print('${viewModel.toString()}');
      },
      builder: (BuildContext context, ViewModel viewModel) {
        return ContentArea(
          viewModel: viewModel,
        );
      },
    );
  }
}
