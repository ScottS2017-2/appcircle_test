import 'package:crypto_tracker_redux/app/app_textstyles.dart';
import 'package:crypto_tracker_redux/provider_version/models/app_state_model.dart';
import 'package:crypto_tracker_redux/provider_version/my_app_provider.dart';
import 'package:crypto_tracker_redux/redux_version/my_app_redux.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController controller = PageController(
    initialPage: 0,
  );

  List<Widget> pages = [
    const MyAppProvider(),
    const MyAppRedux(),
  ];

  String titleString = 'Crypto Alert System - Provider';

  void setTitle(int page) {
    if (page == 0) {
      setState(() {
        titleString = 'Crypto Alert System - Provider';
      });
    } else if (page == 1) {
      setState(() {
        titleString = 'Crypto Alert System - Redux';
      });
    }
  }

  final _leftDrawer = Drawer(child: ListView(
    padding: EdgeInsets.zero,
    children: <Widget>[
      DrawerHeader(
        decoration: BoxDecoration(
          color: Colors.red,
        ),
        child: Container(
          alignment: Alignment.center,
          child: Text(
            'Left Header',
            style: appTextStyles['appBarTextStyle']!
                .copyWith(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
      ListTile(
        title: const Text('First Item'),
        onTap: () {
          // TODO implement me
        },
      ),
      ListTile(
        title: const Text('Second Item'),
        onTap: () {
          // TODO implement me
        },
      ),
      ListTile(
        title: const Text('Third Item'),
        onTap: () {
          // TODO implement me
        },
      ),
    ],
  ),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final providedAppState = Provider.of<AppStateModel>(context);
    final allCommoditiesHistory = context.select((AppStateModel appState) => appState.allCommoditiesHistory);
    return Scaffold(
      appBar: AppBar(
        title: Text(titleString),
      ),
      drawer: FractionallySizedBox(
        widthFactor: 0.5,
        child: _leftDrawer,
      ),
      endDrawer: FractionallySizedBox(
        widthFactor: 0.5,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    'Right Header',
                    style: appTextStyles['appBarTextStyle']!
                        .copyWith(color: Colors.white, fontSize: 36),
                  ),
                ),
              ),
              ListTile(
                title: const Text('First Item'),
                onTap: () {
                  // TODO implement me
                },
              ),
              ListTile(
                title: const Text('Second Item'),
                onTap: () {
                  // TODO implement me
                },
              ),
              ListTile(
                title: const Text('Third Item'),
                onTap: () {
                  // TODO implement me
                },
              ),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: PageView(
              onPageChanged: setTitle,
              children: pages,
            ),
          ),
          Container(
height: 50,
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: ()=>{},
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
                  child: Text('Open Drawer'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
