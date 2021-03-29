import 'package:crypto_tracker_redux/not_yet_implemented_redux_version/models/price_check_model.dart';

class AddPriceCheckAction {
  AddPriceCheckAction({
    required this.updatedListings,
    required this.allCommoditiesHistory,
  });
  Map<String, PriceCheck> updatedListings;
  Map<String, List<PriceCheck>> allCommoditiesHistory;
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
