import 'package:crypto_tracker_redux/app/app_colors.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, BoxConstraints constraints) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Text(
                      "Crypto Tracker, a Flutter demo app.\nCopyright 2021 Scott Stoll,\nsource code licensed \"CC BY 3.0\"",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: AppColors.blackTextColor.withOpacity(0.7),
                        shadows: [
                          BoxShadow(
                            color: AppColors.blackTextColor.withOpacity(0.5),
                            blurRadius: 2,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      strutStyle: StrutStyle(
                        height: 2.2,
                      ),
                      text: TextSpan(
                        text: '\nGreetings,',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: AppColors.blackTextColor.withOpacity(0.7),
                          shadows: [
                            BoxShadow(
                              color: AppColors.blackTextColor.withOpacity(0.5),
                              blurRadius: 2,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text:
                                  "\n     This is currently only an MVP, with limited functionality. It demonstrates two ways of creating the same app, one utilizing Provider and the other Redux. Future versions will include BLoC and Riverpod. The backend currently uses an http call to fetch JSON on demand. I plan to add another part to the backend,using the Binance web socket API, as well."),
                          TextSpan(text: '''\n     Other things demonstrated in the source code include:
          - Building Google Fonts into the apps ThemeData
          - Custom button and divider themes
          - Custom, double-bordered containers with gradients  
          - Unit Testing
          - Widget Testing
          - Heady use of resource files with static constants '''),
                        ],
                      ),
                    ),
                    SizedBox(height: 40,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                      RotatedBox(quarterTurns: 2, child:  Icon(Icons.double_arrow_outlined),),
                        Text(
                          'This way for Provider',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: AppColors.blackTextColor,
                            shadows: [
                              BoxShadow(
                                color: AppColors.blackTextColor.withOpacity(0.5),
                                blurRadius: 2,
                                offset: Offset(1, 1),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        Text(
                          'That way for Redux',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: AppColors.blackTextColor,
                            shadows: [
                              BoxShadow(
                                color: AppColors.blackTextColor.withOpacity(0.5),
                                blurRadius: 2,
                                offset: Offset(1, 1),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.double_arrow_outlined),
                      ],
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }
}
