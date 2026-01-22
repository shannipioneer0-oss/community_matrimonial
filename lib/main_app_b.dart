import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';

import 'main.dart';


void main() {
  FlavorConfig(
    name: "AppB",
    color: Colors.green,
    location: BannerLocation.topStart,
    variables: {
      "apiBaseUrl": "https://api.appb.com",
      "appName": "App B",
    },
  );

  runApp(MyApp());
}
