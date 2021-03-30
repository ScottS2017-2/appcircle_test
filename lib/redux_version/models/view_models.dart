import 'package:crypto_tracker_redux/redux_version/models/app_state.dart';
import 'package:crypto_tracker_redux/redux_version/models/price_check_model.dart';
import 'package:crypto_tracker_redux/redux_version/models/symbol_model.dart';
import 'package:crypto_tracker_redux/redux_version/redux/actions.dart';
import 'package:redux/redux.dart';

class ViewModel {
  final Map<SymbolModel, List<PriceCheck>> allCommoditiesHistory;
  final Map<SymbolModel, double> interestedInPrices;
  final Function() onGetPriceCheck;

  ViewModel({
    required this.allCommoditiesHistory,
    required this.interestedInPrices,
    required this.onGetPriceCheck,
  });

  factory ViewModel.create(Store<AppState> store) {
    _onGetPriceCheck() => store.dispatch(FetchUpdatesAction());

    return ViewModel(
      allCommoditiesHistory: store.state.allCommoditiesHistory,
      interestedInPrices: store.state.interestedInPrices,
      onGetPriceCheck: _onGetPriceCheck,
    );
  }
}
