import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:my_flutter/method_channel.dart';
import 'package:sqflite/sqflite.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _count = Random().nextInt(100);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            _count++;
          });
        },
      ),
      body: Container(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Center(
                child: Text("$_count", style: TextStyle(fontSize: 20),),
              ),
            ),            
            FlatButton(
              child: Text("native返回页面"),
              onPressed: () async {
                try {
                  var result = await FlutterBoost.singleton.close("");
                  print(result);
                } on Exception catch (e) {
                  print(e);
                }
              },
            ),
            FlatButton(
              child: Text("跳转到native页面"),
              onPressed: () async {
                try {
                  await FlutterBoost.singleton.open("nativePage", urlParams: {"a": 1});
                } on Exception catch (e) {
                  print(e);
                }
              },
            ),

            FlatButton(
              child: Text("跳转到新的native flutter页面"),
              onPressed: () async {
                // try {
                //   final int result = await platform.invokeMethod('home_vc');
                //   print(result);
                // } on PlatformException catch (e) {
                //   print(e);
                // }
                
                try {
                  await FlutterBoost.singleton.open("nativeFlutterPage", urlParams: {"a": 1});
                } on Exception catch (e) {
                  print(e);
                }
              },
            ),
            FlatButton(
              child: Text("native alert"),
              onPressed: () async {
                try {
                  method_channel.invokeMethod("method", <String, dynamic>{ "a": 1 });
                  final int result = await method_channel.invokeMethod('alert');
                  print(result);
                } on Exception catch (e) {
                  print(e);
                }
              },
            ),
            FlatButton(
              child: Text("action sheet"),
              onPressed: () async {
                try {
                  final int result = await method_channel.invokeMethod('action_sheet');
                  print(result);
                } on Exception catch (e) {
                  print(e);
                }
              },
            ),
            FlatButton(
              child: Text("跳转flutter页面"),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return HomePage();
                    }
                  )
                );
              },
            ),
            FlatButton(
              child: Text("选择本地图片"),
              onPressed: () async {
                try {
                  final String result = await method_channel.invokeMethod('pink_image');
                  if (result != null) {
                    print(result);
                  }
                } on Exception catch (e) {
                  print(e);
                }
              },
            ),
            // TODO: 显示图片
            FlatButton(
              child: Text("sqlite"),
              onPressed: () async {
                var db = await openDatabase('my_db.db', version: 1, onCreate: (db, version) async {
                  await db.execute(
                    'CREATE TABLE IF NOT EXISTS Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)');
                });
                await db.transaction((txn) async {
                  int id1 = await txn.rawInsert(
                      'INSERT INTO Test(name, value, num) VALUES("some name", 1234, 456.789)');
                  print('inserted1: $id1');
                  int id2 = await txn.rawInsert(
                      'INSERT INTO Test(name, value, num) VALUES(?, ?, ?)',
                      ['another name', 12345678, 3.1416]);
                  print('inserted2: $id2');
                });
                await db.close();
              },
            ),
            FlatButton(
              child: Text("test"),
              onPressed: () {
                var canPop = Navigator.of(context).canPop();
                print("canpop $canPop");

                print("navigator ${Navigator.of(context).toString()}");

                method_channel.invokeMethod('flutter_page_changed', {'canPop': canPop}).then((value) {
                  print(value);
                }).catchError((e) {
                  print(e);
                });
              },
            )
          ]
          
        ),
      ),
    );
  }
}
