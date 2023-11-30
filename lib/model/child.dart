import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:santa_list/model/status.dart';

part 'child.freezed.dart';

@freezed
class Child with _$Child {
  factory Child(String name, String country, Status status, int? id) = _Child;
}
