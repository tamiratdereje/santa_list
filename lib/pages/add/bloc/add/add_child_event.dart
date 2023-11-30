part of 'add_child_bloc.dart';

@freezed
class AddEditChildEvent with _$AddEditChildEvent {
  const factory AddEditChildEvent.save(Child child) = _Save;

  const factory AddEditChildEvent.update(Child child) = _Update;
}
