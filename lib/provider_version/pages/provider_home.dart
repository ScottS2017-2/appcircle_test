import 'package:crypto_tracker_redux/app/app_strings.dart';
import 'package:crypto_tracker_redux/app/app_textstyles.dart';
import 'package:crypto_tracker_redux/provider_version/models/app_state_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderHome extends StatefulWidget {

  ProviderHome({
    Key? key,
  }) : super(key: key);

  @override
  _ProviderHomeState createState() => _ProviderHomeState();
}

class _ProviderHomeState extends State<ProviderHome> {

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    // Fetch the values we care about
    final interestedInPrices = context.select((AppStateModel appState) => appState.interestedInPrices);
    final allCommoditiesHistory = context.select((AppStateModel appState) => appState.allCommoditiesHistory);
    //
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Consumer<AppStateModel>(
            builder: (context, appState, child) {
              return Expanded(
                child: ListView.builder(
                  itemCount: interestedInPrices.length,
                  itemBuilder: (BuildContext context, int index) {
                    String key = interestedInPrices.keys.elementAt(index);
                    String value = interestedInPrices[key].toString();
                    final regex = RegExp(r'^([A-z]+)-([A-z]+)$');
                    final regexMatch = regex.firstMatch(key);
                    final currencyInterestedIn = regexMatch!.group(1);
                    final denomination = regexMatch.group(2);
                    return Card(
                      borderOnForeground: true,
                      color: Colors.grey,
                      child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '${unabbreviatedTerms[currencyInterestedIn]} is currently \n${value.padRight(2)} ${unabbreviatedTerms[denomination]}',
                              textAlign: TextAlign.center,
                              style: appTextStyles['normal24'],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () => Provider.of<AppStateModel>(context, listen: false)
                    .fetchAndProcessUpdates(
                  outdatedHistory: allCommoditiesHistory,
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed))
                        return Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.5);
                      return null; // Use the component's default.
                    },
                  ),
                ),
                child: Text('Update Prices'),
              ),

            ],
          ),
        ],
      ),
    );
  }
}


