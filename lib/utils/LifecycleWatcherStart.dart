

import 'package:flutter/material.dart';

abstract class LifecycleWatcherState<T extends StatefulWidget> extends State<T>
    with WidgetsBindingObserver {


  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {

    if (state == AppLifecycleState.resumed) {
      onResumed();
    } else if (state == AppLifecycleState.inactive) {
      onPaused();
    } else if (state == AppLifecycleState.paused) {
      onInactive();
    } else if (state == AppLifecycleState.detached) {
      onDetached();
    }

  }

  void onResumed();
  void onPaused();
  void onInactive();
  void onDetached();
}