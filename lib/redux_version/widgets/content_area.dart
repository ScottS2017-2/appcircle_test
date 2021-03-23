import 'package:flutter/material.dart';

import 'package:crypto_tracker_redux/redux_version/models/app_state.dart';
import 'package:crypto_tracker_redux/redux_version/models/view_models.dart';
import 'package:crypto_tracker_redux/redux_version/redux/actions.dart';

import 'package:redux/redux.dart';

class ContentArea extends StatefulWidget {
  const ContentArea({
    Key? key,
    required this.viewModel,
    required this.store,
}) : super(key:key);

  final ViewModel viewModel;
  final Store<AppState> store;

  @override
  _ContentAreaState createState() => _ContentAreaState();
}

class _ContentAreaState extends State<ContentArea> {

  final _scrollController = ScrollController();

  void didTheButtonGetPressedOrNot(){
    widget.store.dispatch(AddPriceCheckAction());
 //   widget.viewModel.onGetPriceCheck();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.store.state.isLoading == true) {
      return Center(
        child: ElevatedButton(
          onPressed: didTheButtonGetPressedOrNot,
          child: Text('Fetch Latest Prices'),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: widget.store.state.interestedInPrices.length,
        controller: _scrollController,
        itemBuilder: (BuildContext context, int index){
          String key = widget.store.state.interestedInPrices.keys.elementAt(index);
          return  ListTile(
            title: Text(key),
            trailing: Text(widget.store.state.interestedInPrices[key].toString()),
          );
        },
      );
    }
  }
}