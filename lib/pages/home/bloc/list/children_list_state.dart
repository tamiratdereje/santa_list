part of 'children_list_bloc.dart';

@freezed
class ChildrenListState with _$ChildrenListState {
  const factory ChildrenListState.initial() = _Initial;

  const factory ChildrenListState.loaded(List<Child> children) = _Loaded;
}
