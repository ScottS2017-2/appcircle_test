// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
//
// import 'package:crypto_tracker_redux/provider_version/models/price_check_model.dart';
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
//
// // Returns a list of the latest PriceCheck objects
// Future<List<dynamic>>  getTicker() async {
//   List<dynamic> _jsonData = [];
//   List<dynamic> _data = [];
//
//   http.Response response;
//   String _body = '';
//
//   final Uri url = Uri.parse('https://api.blockchain.com/v3/exchange/tickers');
//   try {
//     response = await http.get(url);
//     if (response.statusCode != 200) {
//       throw HttpException(
//         '${response.statusCode}: ${response.reasonPhrase}',
//         uri: url,
//       );
//     }
//     _body = response.body;
//   } catch (e) {
//     print(e);
//   }
//   _jsonData = json.decode(_body) as List;
//   _data =
//       _jsonData.map((jsonObject) => PriceCheck.fromJson(jsonObject)).toList();
//
//   return _data;
// }
//
// Map<String, List<PriceCheck>> addUpdatesToHistory({
//   @required List<Map<String, PriceCheck>> newestUpdates,
//   @required Map<String, List<PriceCheck>> outdatedHistory,
// }) {
//   var _result = Map.from(outdatedHistory);
//   // Add each new listing to the result
//   for (int i = 0; i < newestUpdates.length; i++) {
//     var temp = PriceCheck(
//       symbol: newestUpdates[i].entries.first.key.toString(),
//       lastTradePrice: newestUpdates[i].entries.first.value.lastTradePrice,
//       price24h: newestUpdates[i].entries.first.value.price24h,
//       volume24h: newestUpdates[i].entries.first.value.volume24h,
//     );
//     _result['${temp.symbol}'].add(temp);
//   }
//   return _result;
// }
//
// Map<String, double> updateWatchlistPrices({
//   @required Map<String, double> oldPricesInterestedInList,
//   @required Map<String, PriceCheck> newestUpdates,
// }) {
//   var _result = oldPricesInterestedInList;
//   for (String key in oldPricesInterestedInList.keys) {
//     _result[key] = newestUpdates[key].lastTradePrice;
//   }
//   return _result;
// }
//
// Future<List<dynamic>> fetchAndProcessUpdates(
//     {@required Map<String, List<PriceCheck>> outdatedHistory}) async {
//   List<dynamic> _result;
//   await getTicker().then((value) {
//     addUpdatesToHistory(
//       newestUpdates: value,
//       outdatedHistory: outdatedHistory,
//     );
//   });
//   return _result;
// }
