import 'package:crypto_tracker_redux/provider_version/models/my_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderHome extends StatelessWidget {
  const ProviderHome({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Consumer<MyModel>(
            builder: (context, counter, child) => Text(
              'You have pushed the button this many times: ${counter.value}',
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          ElevatedButton(
            onPressed: () =>
                Provider.of<MyModel>(context, listen: false).increment(),
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
