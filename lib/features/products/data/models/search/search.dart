import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'search.freezed.dart';
part 'search.g.dart';

@freezed
abstract class SearchModel with _$SearchModel {
  const factory SearchModel({
     int? id,
    required String text,
  }) = _SearchModel;

  factory SearchModel.fromJson(Map<String, dynamic> json) =>
      _$SearchModelFromJson(json);
}
