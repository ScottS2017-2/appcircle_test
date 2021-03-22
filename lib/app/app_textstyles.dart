import 'package:flutter/material.dart';
import 'package:crypto_tracker_redux/app/app_colors.dart';

Map<String, TextStyle> appTextStyles = {
  'appBarTextStyle': TextStyle(
    color: appColors['whiteTextColor'],
    shadows: [
      Shadow(
        color: appColors['dropShadowColor']!,
        offset: Offset(2, 2),
        blurRadius: 1,
      ),
    ],
  ),
  //
  // *****************
  // Use copyWith to change colors, font families, etc.
  // *****************
  'normal36': TextStyle(fontSize: 36, fontWeight: FontWeight.normal),
  'bold36': TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
  'italic36': TextStyle(fontSize: 36, fontStyle: FontStyle.italic),
  'boldItalic36': TextStyle(
      fontSize: 36, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
  //
  'normal30': TextStyle(fontSize: 30, fontWeight: FontWeight.normal),
  'bold30': TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
  'italic30': TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
  'boldItalic30': TextStyle(
      fontSize: 30, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
  //
  'normal24': TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
  'bold24': TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  'italic24': TextStyle(fontSize: 24, fontStyle: FontStyle.italic),
  'boldItalic24': TextStyle(
      fontSize: 24, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
  //
  'normal18': TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
  'bold18': TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  'italic18': TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
  'boldItalic18': TextStyle(
      fontSize: 18, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
  //
  'normal16': TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
  'bold16': TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  'italic16': TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
  'boldItalic16': TextStyle(
      fontSize: 16, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
  //
  'normal14': TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
  'bold14': TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
  'italic14': TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
  'boldItalic14': TextStyle(
      fontSize: 14, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
  //
  'normal12': TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
  'bold12': TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
  'italic12': TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
  'boldItalic12': TextStyle(
      fontSize: 12, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
  //
  'normal10': TextStyle(fontSize: 10, fontWeight: FontWeight.normal),
  'bold10': TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
  'italic10': TextStyle(fontSize: 10, fontStyle: FontStyle.italic),
  'boldItalic10': TextStyle(
      fontSize: 10, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
  //
  'normal8': TextStyle(fontSize: 8, fontWeight: FontWeight.normal),
  'bold8': TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
  'italic8': TextStyle(fontSize: 8, fontStyle: FontStyle.italic),
  'boldItalic8': TextStyle(
      fontSize: 8, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
  //
  'normal6': TextStyle(fontSize: 6, fontWeight: FontWeight.normal),
  'bold6': TextStyle(fontSize: 6, fontWeight: FontWeight.bold),
  'italic6': TextStyle(fontSize: 6, fontStyle: FontStyle.italic),
  'boldItalic6': TextStyle(
      fontSize: 6, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
};
