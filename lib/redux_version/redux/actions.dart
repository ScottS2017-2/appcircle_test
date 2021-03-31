import 'package:crypto_tracker_redux/redux_version/models/price_check_model.dart';
import 'package:crypto_tracker_redux/redux_version/models/symbol_model.dart';

class AddInterestedInAction {
  AddInterestedInAction({
    required this.itemMapKey,
  });
  final SymbolModel itemMapKey;
}
//-------
class ClearAllDenominationOptions {}
//-------
class FetchUpdatesAction {}
//-------
class RemoveInterestedInAction {
  RemoveInterestedInAction({
    required this.itemMapKey,
  });
  final SymbolModel itemMapKey;
}
//-------
class ToggleSideSlides {}
//-------
class UpdateAvailableDenominationsForThisCurrencyAction {
  UpdateAvailableDenominationsForThisCurrencyAction({
    required this.commodity,
  });
  final SymbolModel commodity;
}
//-------
class UpdatePricesAction {
  UpdatePricesAction({
    required this.updatedListings,
  });
  final List<PriceCheck> updatedListings;
}