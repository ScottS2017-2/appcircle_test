import 'package:crypto_tracker_redux/redux_version/models/app_state.dart';
import 'package:crypto_tracker_redux/redux_version/models/price_check.dart';
import 'package:crypto_tracker_redux/redux_version/redux/actions.dart';
import 'package:redux/redux.dart';

class ViewModel {
  final Map<String, List<PriceCheck>> allCommoditiesHistory;
  final Map<String, double> interestedInPrices;
  final Function() onGetPriceCheck;
  final bool isLoading;

  ViewModel({
    required this.allCommoditiesHistory,
    required this.interestedInPrices,
    required this.onGetPriceCheck,
    required this.isLoading,
  });

  factory ViewModel.create(Store<AppState> store) {
    _onGetPriceCheck() => store.dispatch(AddPriceCheckAction());

    return ViewModel(
      allCommoditiesHistory: store.state.allCommoditiesHistory,
      interestedInPrices: store.state.interestedInPrices,
      onGetPriceCheck: _onGetPriceCheck,
      isLoading: store.state.isLoading,
    );
  }
}
