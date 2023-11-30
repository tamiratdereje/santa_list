part of 'children_list_bloc.dart';

@freezed
class ChildrenListEvent with _$ChildrenListEvent {
  const factory ChildrenListEvent.update(List<Child> children) = _Update;
}
