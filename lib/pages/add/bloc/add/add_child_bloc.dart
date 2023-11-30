import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:santa_list/data/ChildrenRepository.dart';
import 'package:santa_list/model/child.dart';

part 'add_child_bloc.freezed.dart';
part 'add_child_event.dart';
part 'add_child_state.dart';

class AddEditChildBloc extends Bloc<AddEditChildEvent, AddEditChildState> {
  final ChildrenRepository _childrenRepository;

  AddEditChildBloc(this._childrenRepository)
      : super(const AddEditChildState.initial()) {
    on<_Save>((event, emit) {
      _childrenRepository.add(event.child);
      emit(const AddEditChildState.saved());
    });
    on<_Update>((event, emit) {
      _childrenRepository.update(event.child);
      emit(const AddEditChildState.saved());
    });
  }
}
