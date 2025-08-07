import 'package:json_annotation/json_annotation.dart';

part 'category_response.g.dart';

@JsonSerializable()
class CategoryResponse {
  int? count;
  String? next;
  String? previous;
  List<Results>? results;

  CategoryResponse(this.count, this.next, this.previous, this.results);

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseFromJson(json);
      
  Map<String, dynamic> toJson() => _$CategoryResponseToJson(this);
}

@JsonSerializable()
class Results {
  @JsonKey(name: 'category_id')
  final int? categoryId;
  @JsonKey(name: 'category_name_ar')
  final String? categoryNameAr;
  @JsonKey(name: 'category_name_en')
  final String? categoryImage;
  final String? description;
  final String? imageUrl;

  Results({
    required this.categoryId,
    required this.categoryNameAr,
    required this.categoryImage,
    required this.description,
    required this.imageUrl,
  });

  factory Results.fromJson(Map<String, dynamic> json) =>
      _$ResultsFromJson(json);
      
  Map<String, dynamic> toJson() => _$ResultsToJson(this);
}
