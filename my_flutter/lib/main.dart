import 'package:flutter/material.dart';
import 'package:my_flutter/content_page.dart';
import 'package:my_flutter/home_page.dart';
import 'package:my_flutter/me_page.dart';
import 'package:my_flutter/mynavigator_observer.dart';
import 'package:flutter_boost/flutter_boost.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var myObserver = MyNavigatorObserver();

  @override
  void initState() {
    FlutterBoost.singleton.registerPageBuilders(<String, PageBuilder>{
      'home': (String pageName, Map params, String uniqueId) {
        return HomePage();
      },
      "me": (String pageName, Map params, String uniqueId) {
        return MePage();
      },
      "content": (String pageName, Map params, String uniqueId) {
        return ContentPage();
      }
    });

    // 添加navigationObserver，用于控制返回操作
    FlutterBoost.singleton.addBoostNavigatorObserver(myObserver);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: FlutterBoost.init(),
      home: HomePage(),
    );
  }
}
