import 'package:crypto_tracker_redux/redux_version/models/price_check_model.dart';
import 'package:crypto_tracker_redux/redux_version/models/symbol_model.dart';

class FetchUpdatesAction{}

class UpdatePricesAction {
  UpdatePricesAction({
    required this.updatedListings,
  });
  List<PriceCheck> updatedListings;
}

class AddInterestedInAction {
  AddInterestedInAction({
    required this.itemMapKey,
  });
  final SymbolModel itemMapKey;
}

class RemoveInterestedInAction {
  RemoveInterestedInAction({
    required this.itemMapKey,
  });
  final SymbolModel itemMapKey;
}

class UpdateAvailableDenominationsForThisCurrencyAction{
  UpdateAvailableDenominationsForThisCurrencyAction({
    required this.commodity,
  });
  final SymbolModel commodity;

}