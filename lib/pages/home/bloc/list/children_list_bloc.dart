import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:santa_list/data/ChildrenRepository.dart';
import 'package:santa_list/model/child.dart';

part 'children_list_bloc.freezed.dart';
part 'children_list_event.dart';
part 'children_list_state.dart';

class ChildrenListBloc extends Bloc<ChildrenListEvent, ChildrenListState> {
  final ChildrenRepository _childrenRepository;
  late StreamSubscription<List<Child>> subscription;

  ChildrenListBloc(this._childrenRepository)
      : super(const ChildrenListState.initial()) {
    subscription = _childrenRepository.children.listen((event) {
      debugPrint("Children list updated: $event");
      add(ChildrenListEvent.update(event));
    });

    on<_Update>((event, emit) {
      emit(ChildrenListState.loaded(event.children));
    });
  }

  @override
  void onTransition(
      Transition<ChildrenListEvent, ChildrenListState> transition) {
    debugPrint(
        "ChildrenListBloc ${transition.currentState} -> ${transition.nextState}");
    return super.onTransition(transition);
  }

  @override
  Future<void> close() {
    subscription.cancel();
    return super.close();
  }
}
