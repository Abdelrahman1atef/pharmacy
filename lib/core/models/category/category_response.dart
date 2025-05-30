import 'package:json_annotation/json_annotation.dart';
part 'category_response.g.dart';
@JsonSerializable()
class CategoryResponse {
  @JsonKey(name: 'category_id')
  final int? categoryId;
  @JsonKey(name: 'category_name_ar')
  final String? categoryNameAr;
  @JsonKey(name: 'category_name_en')
  final String? categoryImage;

  CategoryResponse({
    required this.categoryId,
    required this.categoryNameAr,
    required this.categoryImage,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseFromJson(json);
  static List<CategoryResponse> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => CategoryResponse.fromJson(json)).toList();
  }
}