import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'news.freezed.dart';
part 'news.g.dart';

@freezed
abstract class NewsModel with _$NewsModel {
  const factory NewsModel({
    int? id,
    required String title,
    required String description,
    required String image,
    required String created_at,
  }) = _NewsModel;

  factory NewsModel.fromJson(Map<String, dynamic> json) =>
      _$NewsModelFromJson(json);
}
