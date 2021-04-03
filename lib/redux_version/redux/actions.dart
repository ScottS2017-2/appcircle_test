import 'package:crypto_tracker_redux/common/models/price_check_model.dart';
import 'package:crypto_tracker_redux/common/models/symbol_model.dart';

class AddInterestedInAction {
  AddInterestedInAction({
    required this.mapKey,
  });
  final SymbolModel mapKey;
}
//-------
class ClearAllDenominationOptions {}
//-------
class FetchUpdatesAction {}
//-------
class RemoveInterestedInAction {
  RemoveInterestedInAction({
    required this.mapKey,
  });
  final SymbolModel mapKey;
}
//-------
class StartUpdateTimer{


}
//-------
class ToggleSideSlides {}
//-------
class UpdateDenominationsApplicableToThisCurrencyAction {
  UpdateDenominationsApplicableToThisCurrencyAction({
    required this.mapKey,
  });
  final SymbolModel mapKey;
}
//-------
class UpdatePricesAction {
  UpdatePricesAction({
    required this.updatedListings,
  });
  final List<PriceCheck> updatedListings;
}