import 'package:crypto_tracker_redux/redux_version/models/price_check_model.dart';

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
  final String itemMapKey;
}

class RemoveInterestedInAction {
  RemoveInterestedInAction({
    required this.itemMapKey,
  });
  final String itemMapKey;
}