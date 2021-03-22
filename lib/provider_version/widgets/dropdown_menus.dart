import 'package:crypto_tracker_redux/app/app_strings.dart';
import 'package:flutter/material.dart';

class CommodityDropDownMenu extends StatefulWidget {
  const CommodityDropDownMenu({
    Key key,
  }) : super(key: key);

  @override
  _CommodityDropDownMenuState createState() => _CommodityDropDownMenuState();
}

class _CommodityDropDownMenuState extends State<CommodityDropDownMenu> {
  String dropdownValue = 'Commodities';

  List<String> commodities = [];
  List<String> getCommoditiesList(){
    List<String> _result = [];
    for(final key in appStrings.keys)
      {
        _result.add(appStrings[key]);
      }
    _result.insert(0, 'Commodities');
    return _result;
  }

  @override
  void initState() {
    super.initState();
    commodities = getCommoditiesList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Theme.of(context).canvasColor,
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: Icon(
          Icons.arrow_downward,
          color: Colors.black45,
        ),
        iconSize: 24,
        elevation: 16,
        style: Theme.of(context).textTheme.headline6,
        underline: Container(
          height: 2,
          color: Colors.black45,
        ),
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;
            if (newValue == 'Commodities') {

            } else if (newValue == 'Raised Buttons') {
              print('Test good');
            } else if (newValue == 'Icon Buttons') {
              print('Test good');
            } else {
              dropdownValue = newValue;
            }
          });
        },
        items: commodities.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
