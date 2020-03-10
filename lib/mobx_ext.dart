import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

extension MobxExt on Widget {
  mobxObserver({Key key, String name}) {
    return Observer(
      key: key,
      name: name,
      builder: (_) => this,
    );
  }

}
