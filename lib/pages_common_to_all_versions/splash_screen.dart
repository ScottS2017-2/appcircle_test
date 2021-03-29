import 'package:crypto_tracker_redux/app/app_colors.dart';
import 'package:crypto_tracker_redux/app/app_textstyles.dart';
import 'package:crypto_tracker_redux/main.dart';
import 'package:crypto_tracker_redux/pages_common_to_all_versions/home.dart';
import 'package:crypto_tracker_redux/provider_version/models/app_state_model.dart';
import 'package:crypto_tracker_redux/provider_version/pages/provider_home.dart';
import 'package:crypto_tracker_redux/provider_version/widgets/custom_border_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController _controller;
  double _topAlignment = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 5000), vsync: this);
    animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {
          _topAlignment = _controller.value;
        });
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                AppColors.oliveAccent.withOpacity(_controller.value),
                Theme.of(context).primaryColor,
              ],
              stops: [
                0,
                0.5,
                1,
              ],
              begin: Alignment(-1, ((2 * _topAlignment) - 1)),
              end: Alignment(1, 1 - (2 * _topAlignment)),
            ),
          ),
          child: Container(
            child: Column(
              children: [
                const Spacer(
                  flex: 6,
                ),
                Text(
                  'Crypto     \n     Tracker',
                  textAlign: TextAlign.left,
                  style: AppTextStyles.normal64.copyWith(
                    color: _controller.value == 1 ? Colors.white : Colors.transparent,
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
                if (_controller.value < 1) Text(
                  _controller.value.toString(),
                  textAlign: TextAlign.center,
                  style: AppTextStyles.normal64.copyWith(
                    color: Colors.white.withOpacity(_controller.value),
                  ),
                ),
                if(_controller.value == 1) Text(
                  'v0.1',
                  style: AppTextStyles.normal36.copyWith(
                    color: _controller.value == 1 ? Colors.white.withOpacity(_controller.value) : Colors.transparent,
                  ),
                ),
                const Spacer(
                  flex: 5,
                ),
                Text(
                  'A Demo Flutter App\nby Scott Stoll',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.normal24.copyWith(
                    color: _controller.value == 1 ? Colors.white.withOpacity(_controller.value) : Colors.transparent,
                  ),
                ),
                const Spacer(
                  flex: 5,
                ),
                if (_controller.value == 1)CustomBorderButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder:
                        (context) => ChangeNotifierProvider(
                          create: (BuildContext context) => AppStateModel(),
                          child:Home(),
                        ),
                    ),
                  ),
                  child: Text('Continue'),
                ),
                const Spacer(
                  flex: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


