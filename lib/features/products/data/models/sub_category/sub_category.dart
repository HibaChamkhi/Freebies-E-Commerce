import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'sub_category.freezed.dart';
part 'sub_category.g.dart';

@freezed
abstract class SubCategoryModel with _$SubCategoryModel {
  const factory SubCategoryModel({
    required int id,
    required String name,
    required int category_id,
  }) = _SubCategoryModel;

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$SubCategoryModelFromJson(json);
}
