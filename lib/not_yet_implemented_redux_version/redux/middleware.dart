import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto_tracker_redux/not_yet_implemented_redux_version/models/app_state.dart';
import 'package:crypto_tracker_redux/not_yet_implemented_redux_version/models/price_check.dart';
import 'package:crypto_tracker_redux/not_yet_implemented_redux_version/redux/actions.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';

// Returns a list of the latest PriceCheck objects
Future<List<dynamic>> getTicker() async {
  List<dynamic> _jsonData = [];
  List<dynamic> _data = [];

  http.Response response;
  String _body = '';

  final Uri url = Uri.parse('https://api.blockchain.com/v3/exchange/tickers');
  try {
    response = await http.get(url);
    if (response.statusCode != 200) {
      throw HttpException(
        '${response.statusCode}: ${response.reasonPhrase}',
        uri: url,
      );
    }
    _body = response.body;
  } catch (e) {
    print(e);
  }
  _jsonData = json.decode(_body) as List;
  _data = _jsonData.map((jsonObject) => PriceCheck.fromJson(jsonObject)).toList();

  return _data;
}

Future<List<dynamic>> appStateMiddleware(Store<AppState> store, action, NextDispatcher next) async {
  // _result is abstraction for debugging
  late List<dynamic> _result;
  if (action is AddPriceCheckAction) {
    // Get the latest PriceChecks
    await getTicker().then((value) {
      _result = value;
    });
  }
  return _result;
}
