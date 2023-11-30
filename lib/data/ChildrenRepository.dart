import 'dart:async';

import 'package:flutter/material.dart';
import 'package:santa_list/model/child.dart';

class ChildrenRepository {
  final _controller = StreamController<List<Child>>();
  var _children = <Child>[];

  late Stream<List<Child>> children;

  ChildrenRepository() {
    children = _controller.stream;
    _controller.add(_children);
  }

  void add(Child child) {
    _children =
        _children + [child.copyWith(id: DateTime.now().millisecondsSinceEpoch)];

    _controller.add(_children);
  }

  void update(Child child) {
    debugPrint("Updating child $child");
    _children = _children.map((e) => e.id! == child.id! ? child : e).toList();
    _controller.add(_children);
  }
}
