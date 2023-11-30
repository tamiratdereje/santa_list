part of 'add_child_bloc.dart';

@freezed
class AddEditChildState with _$AddEditChildState {
  const factory AddEditChildState.initial() = _Initial;

  const factory AddEditChildState.loading() = _Loading;

  const factory AddEditChildState.saved() = _Saved;

  const factory AddEditChildState.error(String error) = _Error;
}
