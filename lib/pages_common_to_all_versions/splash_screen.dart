import 'package:crypto_tracker_redux/app/app_colors.dart';
import 'package:crypto_tracker_redux/app/app_strings.dart';
import 'package:crypto_tracker_redux/app/app_textstyles.dart';
import 'package:crypto_tracker_redux/pages_common_to_all_versions/home.dart';
import 'package:crypto_tracker_redux/provider_version/models/app_state_model.dart';
import 'package:crypto_tracker_redux/widgets_common_to_all_versions/custom_border_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
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
        child: Stack(
          alignment:Alignment.bottomCenter,
          children: [
            Container(
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
                    if (_controller.value < 1)
                      Text(
                        _controller.value.toString(),
                        textAlign: TextAlign.center,
                        style: AppTextStyles.normal64.copyWith(
                          color: Colors.white.withOpacity(_controller.value),
                        ),
                      ),
                    if (_controller.value == 1)
                      Text(
                        'v0.1',
                        style: AppTextStyles.normal36.copyWith(
                          color:
                              _controller.value == 1 ? Colors.white.withOpacity(_controller.value) : Colors.transparent,
                        ),
                      ),
                    const Spacer(
                      flex: 5,
                    ),
                    Text(
                      'A Demo Flutter App\nby Scott Stoll',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.normal24.copyWith(
                        color:
                            _controller.value == 1 ? Colors.white.withOpacity(_controller.value) : Colors.transparent,
                      ),
                    ),
                    const Spacer(
                      flex: 5,
                    ),
                    const Spacer(
                      flex: 5,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: CustomBorderButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider(
                        create: (BuildContext context) => AppStateModel(),
                        child: Home(),
                      ),
                    ),
                  ),
                  height: 48,
                  width: 150,
                  gradientColorOne: AppColors.oliveAccent,
                  gradientColorTwo: Theme.of(context).primaryColor,
                  insetColor: Theme.of(context).scaffoldBackgroundColor,
                  child: Text(_controller.value == 1 ? AppStrings.continueText : AppStrings.skip),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
