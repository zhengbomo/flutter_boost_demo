import 'package:bmprogresshud/bmprogresshud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';


class ContentPage extends StatefulWidget {
  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  GlobalKey<ProgressHudState> _hudKey = GlobalKey<ProgressHudState>();

  // 取消监听
  VoidCallback _listenCancelable;
  @override
  void initState() {
    //flutter部分接收数据，dart代码
    _listenCancelable?.call();
    _listenCancelable = FlutterBoost.singleton.channel.addEventListener('showToast', (name, arguments) async {
      var msg = arguments["message"];
      if (msg != null) {
        await _hudKey.currentState.showAndDismiss(ProgressHudType.success, msg);
      }
      return null;
    });
    super.initState();
  }

  @override
  void dispose() {
    // 取消监听
    _listenCancelable.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProgressHud(
        key: _hudKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton(
                child: Text("show toast"),
                onPressed: () async {
                  await _hudKey.currentState.showAndDismiss(ProgressHudType.success, "flutter消息");
                },
              ),
              FlatButton(
                child: Text("show native alert"),
                onPressed: () async {
                  FlutterBoost.singleton.channel.sendEvent("alert", {"message": "flutter消息"});
                },
              )
            ],
          )
        ),
      ),
    );
  }
}