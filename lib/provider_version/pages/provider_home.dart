import 'package:crypto_tracker_redux/provider_version/models/app_state_model.dart';
import 'package:crypto_tracker_redux/provider_version/models/price_check_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderHome extends StatelessWidget {
  const ProviderHome({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, List<PriceCheck>> allCommoditiesHistory =
        Provider.of<AppStateModel>(context).allCommoditiesHistory;
    final Map<String, double> interestedInPrices =
        Provider.of<AppStateModel>(context).interestedInPrices;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Consumer<AppStateModel>(
            builder: (context, appState, child) {

              return Expanded(
                child: ListView.builder(
                  itemCount: interestedInPrices.length,
                  itemBuilder: (BuildContext context, int index){
                    String key = interestedInPrices.keys.elementAt(index);
                    String value = interestedInPrices[key].toString();
                    return new Row(
                      children: <Widget>[
                        Text('$key',style: Theme.of(context).textTheme.headline4,),
                        Text('$value',style: Theme.of(context).textTheme.headline4,)
                      ],
                    );
                  },
                ),
              );
            },
          ),
          ElevatedButton(
            onPressed: () => Provider.of<AppStateModel>(context, listen: false)
                .fetchAndProcessUpdates(
              outdatedHistory: allCommoditiesHistory,
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed))
                    return Theme.of(context).colorScheme.primary.withOpacity(0.5);
                  return null; // Use the component's default.
                },
              ),
            ),
            child: Text('Update Prices'),
          ),
        ],
      ),
    );
  }
}
