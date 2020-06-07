import 'package:flutter/material.dart';
import 'package:my_flutter/method_channel.dart';

class MyNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    method_channel.invokeMethod("flutter_page_changed", {
      'type': 'push',
      'canPop': route.navigator.canPop()
    });
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    method_channel.invokeMethod("flutter_page_changed", {
      'type': 'pop',
      'canPop': route.navigator.canPop()
    });
  }
}
